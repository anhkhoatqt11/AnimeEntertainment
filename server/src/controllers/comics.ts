import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import ComicsModel from "../models/comics";
import BannerModel from "../models/banner";
import ComicChapterModel from "../models/comicChapter";

import ComicAlbumModel from "../models/comicAlbum";
import qs from "qs";

// api get
export const getComicBanner: RequestHandler = async (req, res, next) => {
  try {
    const banners = await BannerModel.findOne({ type: "Comic" });
    res.status(200).json(banners);
  } catch (error) {
    next(error);
  }
};

export const getComicAlbum: RequestHandler = async (req, res, next) => {
  try {
    const albums = await ComicAlbumModel.find().exec();
    res.status(200).json(albums);
  } catch (error) {
    next(error);
  }
};

export const getNewChapterComic: RequestHandler = async (req, res, next) => {
  try {
    const comics = await ComicChapterModel.aggregate([
      {
        $lookup: {
          from: "comics",
          localField: "_id",
          foreignField: "chapterList",
          as: "chapterOwner",
        },
      },
      {
        $project: {
          publicTime: 1,
          "chapterOwner._id": 1,
          "chapterOwner.comicName": 1,
          "chapterOwner.coverImage": 1,
          "chapterOwner.genres": 1,
        },
      },
      {
        $lookup: {
          from: "genres",
          localField: "chapterOwner.genres",
          foreignField: "_id",
          as: "genreName",
        },
      },

      {
        $group: {
          _id: {
            chapterOwnerId: "$chapterOwner._id",
            coverImage: "$chapterOwner.coverImage",
            comicName: "$chapterOwner.comicName",
            genres: "$genreName",
          },
          publicTime: {
            $top: {
              output: ["$publicTime"],
              sortBy: { publicTime: -1 },
            },
          },
        },
      },
      { $sort: { publicTime: -1 } },
      { $limit: 10 },
    ]);
    res.status(200).json(comics);
  } catch (error) {
    next(error);
  }
};
// api get one
export const getComicInAlbum: RequestHandler = async (req, res, next) => {
  try {
    const url = req.url;
    const [, params] = url.split("?");
    const parsedParams = qs.parse(params);
    const page = parseInt(
      typeof parsedParams.page === "string" ? parsedParams.page : "0"
    );
    const limit = parseInt(
      typeof parsedParams.limit === "string" ? parsedParams.limit : "0"
    );
    const response: string =
      typeof parsedParams.idList === "string" ? parsedParams.idList : "";
    const comics: any[] = [];
    var idList = response
      .replace("[", "")
      .replace("]", "")
      .replace(/\s/g, "")
      .split(",");
    if ((page - 1) * limit > idList.length - 1) {
      res.status(200).json(comics);
      return;
    } else idList = idList.splice((page - 1) * limit, limit);
    idList.forEach(async (element) => {
      await ComicsModel.aggregate([
        {
          $match: { _id: new mongoose.Types.ObjectId(element) },
        },
        {
          $lookup: {
            from: "genres",
            localField: "genres",
            foreignField: "_id",
            as: "genreName",
          },
        },
        {
          $project: {
            _id: 1,
            coverImage: 1,
            comicName: 1,
            genreName: 1,
            description: 1,
          },
        },
      ]).then((item) => {
        comics.push(item);
        if (comics.length === idList.length) {
          res.status(200).json(comics);
        }
      });
    });
  } catch (error) {
    next(error);
  }
};

export const getComic: RequestHandler = async (req, res, next) => {
  const url = req.url;
  const [, params] = url.split("?");
  const parsedParams = qs.parse(params);
  const comicId =
    typeof parsedParams.comicId === "string" ? parsedParams.comicId : "0";

  try {
    if (!mongoose.isValidObjectId(comicId)) {
      throw createHttpError(400, "Invalid comic id");
    }
    const comic = await ComicsModel.findById(comicId).exec();

    if (!comic) {
      throw createHttpError(404, "comic not found");
    }
    res.status(200).json(comic);
  } catch (error) {
    next(error);
  }
};

export const getRankingTable: RequestHandler = async (req, res, next) => {
  try {
    const comics = await ComicChapterModel.aggregate([
      // 21600 stand for meaning reset ranking table each 6 hours
      {
        $addFields: {
          timestamp: { $toLong: "$publicTime" },
          begintimestamp: {
            $toLong: new Date("2024-01-01T17:00:00.000+00:00"),
          },
        },
      },
      {
        $addFields: {
          seconds: { $subtract: ["$timestamp", "$begintimestamp"] },
          sign: { $cond: [{ $gt: ["$views", 0] }, 1, 0] },
          n: {
            $cond: [{ $gte: [{ $abs: "$views" }, 1] }, { $abs: "$views" }, 1],
          },
        },
      },
      {
        $addFields: {
          ratepoint: {
            $sum: [
              { $log: ["$n", 10] },
              { $divide: [{ $multiply: ["$sign", "$seconds"] }, 21600] },
            ],
          },
        },
      },
      {
        $sort: { ratepoint: -1 },
      },
      {
        $lookup: {
          from: "comics",
          localField: "_id",
          foreignField: "chapterList",
          as: "comicOwner",
        },
      },
      {
        $lookup: {
          from: "genres",
          localField: "comicOwner.genres",
          foreignField: "_id",
          as: "genreNames",
        },
      },
      {
        $group: {
          _id: {
            comicOwnerId: "$comicOwner._id",
            coverImage: "$comicOwner.coverImage",
            landspaceImage: "$comicOwner.landspaceImage",
            comicName: "$comicOwner.comicName",
            genres: "$genreNames",
          },
          ratepoint: {
            $top: {
              output: ["$ratepoint"],
              sortBy: { ratepoint: -1 },
            },
          },
        },
      },
      { $sort: { ratepoint: -1 } },
      { $limit: 20 },
    ]);
    res.status(200).json(comics);
  } catch (error) {
    next(error);
  }
};

export const getChapterOfComic: RequestHandler = async (req, res, next) => {
  const url = req.url;
  const [, params] = url.split("?");
  const parsedParams = qs.parse(params);
  const comicId =
    typeof parsedParams.comicId === "string" ? parsedParams.comicId : "0";
  try {
    if (!mongoose.isValidObjectId(comicId)) {
      throw createHttpError(400, "Invalid comic id");
    }
    // Mỗi một comic có một field gọi là chapterList chứa id của các chapter
    const comic = await ComicsModel.aggregate([
      {
        $lookup: {
          // tên table comicChapter
          from: "comicChapters",
          // tên field của chapterList trong table comic
          localField: "chapterList",
          // khóa ngoại ở table comicChapter chính là _id
          foreignField: "_id",
          // alias cho table join mới
          as: "detailChapterList",
        },
      },
    ]);

    if (!comic) {
      throw createHttpError(404, "comic not found")
    }
    res.status(200).json(comic);
  }
  catch (error) {
    next(error)
  }
}

export const getDetailComicById: RequestHandler = async (req, res, next) => {
  const url = req.url;
  const [, params] = url.split("?");
  const parsedParams = qs.parse(params);
  const comicId: string =
    typeof parsedParams.comicId === "string" ? parsedParams.comicId : "0";
  try {
    if (!mongoose.isValidObjectId(comicId)) {
      throw createHttpError(400, "Invalid comic id")
    }
    // Mỗi một comic có một field gọi là chapterList chứa id của các chapter 
    const comic = await ComicsModel.aggregate([
      {
        $match: { _id: new mongoose.Types.ObjectId(comicId) }
      },
      {
        $lookup: {
          from: "comicchapters",
          localField: "chapterList",
          foreignField: "_id",
          pipeline: [
            {
              $addFields: {
                likeCount: { $size: "$likes" },
              },
            },
          ],
          as: "detailChapterList",
        },
      },
      {
        $lookup: {
          from: "genres",
          localField: "genres",
          foreignField: "_id",
          as: "genreNames",
        },
      },
      {
        $addFields: {
          totalViews: {
            $sum: "$detailChapterList.views",
          },
        },
      },
      {
        $addFields: {
          totalLikes: {
            $sum: "$detailChapterList.likeCount",
          },
        },
      },
    ])

    if (!comic) {
      throw createHttpError(404, "comic not found")
    }
    res.status(200).json(comic);
  }
  catch (error) {
    next(error)
  }
}