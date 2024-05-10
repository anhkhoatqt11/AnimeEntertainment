import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import ComicsModel from "../models/comics";
import Comics from "../models/comics";
import BannerModel from "../models/banner";
import ComicChapterModel from "../models/comicChapter";
import UserModel from "../models/user";

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
      throw createHttpError(404, "comic not found");
    }
    res.status(200).json(comic);
  } catch (error) {
    next(error);
  }
};

export const getDetailComicById: RequestHandler = async (req, res, next) => {
  const url = req.url;
  const [, params] = url.split("?");
  const parsedParams = qs.parse(params);
  const comicId: string =
    typeof parsedParams.comicId === "string" ? parsedParams.comicId : "0";
  try {
    if (!mongoose.isValidObjectId(comicId)) {
      throw createHttpError(400, "Invalid comic id");
    }
    // Mỗi một comic có một field gọi là chapterList chứa id của các chapter
    const comic = await ComicsModel.aggregate([
      {
        $match: { _id: new mongoose.Types.ObjectId(comicId) },
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
    ]);

    if (!comic) {
      throw createHttpError(404, "comic not found");
    }
    res.status(200).json(comic);
  } catch (error) {
    next(error);
  }
};

export const updateUserSaveChapter: RequestHandler = async (req, res, next) => {
  try {
    const { chapterId, userId } = req.body;
    var user = await UserModel.findById(userId);
    if (!user) {
      return res.sendStatus(400);
    }
    var checkSave = user.bookmarkList!["comic"].filter(
      (item) => item.toString() === chapterId
    );
    if (checkSave.length === 0) {
      user.bookmarkList!["comic"].push(new mongoose.Types.ObjectId(chapterId));
    } else {
      user.bookmarkList!["comic"] = user.bookmarkList!["comic"].filter(
        (item) => item.toString() !== chapterId
      );
    }
    await user?.save();
    return res.status(200).json(user).end();
  } catch (error) {
    next(error);
  }
};

// Define the searchComics controller function
export const searchComics: RequestHandler = async (req, res, next) => {
  // Extract the search term from the query string
  const { query } = req.query;

  try {
    // Construct the MongoDB query object to search across multiple fields
    const comics: (typeof Comics)[] = await ComicsModel.find({
      $or: [
        { comicName: { $regex: new RegExp(query as string, "i") } },
        { publisher: { $regex: new RegExp(query as string, "i") } },
        { author: { $regex: new RegExp(query as string, "i") } },
        { artist: { $regex: new RegExp(query as string, "i") } },
      ],
    });

    // Check if any comics were found
    if (!comics.length) {
      throw createHttpError(
        404,
        "No comics found matching the search criteria"
      );
    }

    // Return the search results as a JSON response
    res.status(200).json(comics);
  } catch (error) {
    // Pass any errors to the error handling middleware
    next(error);
  }
};
export const checkUserHasLikeOrSaveChapter: RequestHandler = async (
  req,
  res,
  next
) => {
  try {
    const url = req.url;
    const [, params] = url.split("?");
    const parsedParams = qs.parse(params);
    const chapterId =
      typeof parsedParams.chapterId === "string" ? parsedParams.chapterId : "";
    const userId =
      typeof parsedParams.userId === "string" ? parsedParams.userId : "";

    // check like
    var chapter = await ComicChapterModel.findById(chapterId);
    if (!chapter) {
      return res.sendStatus(400);
    }
    var check = chapter.likes.filter((item) => item.toString() === userId);
    // check bookmark
    var user = await UserModel.findById(userId);
    if (!user) {
      return res.sendStatus(400);
    }
    var checkSave = user.bookmarkList!["comic"].filter(
      (item) => item.toString() === chapterId
    );
    return res
      .status(200)
      .json({
        like: check.length === 0 ? false : true,
        bookmark: checkSave.length === 0 ? false : true,
      })
      .end();
  } catch (error) {
    next(error);
  }
};

export const updateChapterView: RequestHandler = async (req, res, next) => {
  try {
    const chapterId = req.body.chapterId;
    var chapter = await ComicChapterModel.findById(chapterId);
    if (!chapter) {
      return res.sendStatus(400);
    }
    chapter.views = chapter.views! + 1;
    await chapter?.save();
    return res.status(200).json(chapter).end();
  } catch (error) {
    next(error);
  }
};

export const updateUserLikeChapter: RequestHandler = async (req, res, next) => {
  try {
    const { chapterId, userId } = req.body;
    var chapter = await ComicChapterModel.findById(chapterId);
    if (!chapter) {
      return res.sendStatus(400);
    }
    var check = chapter.likes.filter((item) => item.toString() === userId);
    if (check.length === 0) {
      chapter.likes.push(new mongoose.Types.ObjectId(userId));
    } else {
      chapter.likes = chapter.likes.filter(
        (item) => item.toString() !== userId
      );
    }
    await chapter?.save();
    return res.status(200).json(chapter).end();
  } catch (error) {
    next(error);
  }
};

export const checkUserHistoryHadSeenChapter: RequestHandler = async (
  req,
  res,
  next
) => {
  const url = req.url;
  const [, params] = url.split("?");
  const parsedParams = qs.parse(params);
  const chapterId =
    typeof parsedParams.chapterId === "string" ? parsedParams.chapterId : "";
  const userId =
    typeof parsedParams.userId === "string" ? parsedParams.userId : "";
  try {
    if (!mongoose.isValidObjectId(chapterId)) {
      throw createHttpError(400, "Invalid chapter id");
    }
    const userInfo = await UserModel.findById(userId).select("histories");
    var check = userInfo?.histories?.readingComic.find(
      (item) => item.chapterId.toString() === chapterId
    );
    res.status(200).json(check === undefined ? {} : check);
  } catch (error) {
    next(error);
  }
};

export const updateUserHistoryHadSeenChapter: RequestHandler = async (
  req,
  res,
  next
) => {
  const chapterId = req.body.chapterId;
  const userId = req.body.userId;
  try {
    if (!mongoose.isValidObjectId(userId)) {
      throw createHttpError(400, "Invalid user id");
    }
    const userInfo = await UserModel.findById(userId).select("histories");
    var check = userInfo?.histories?.readingComic.find(
      (item) => item.chapterId.toString() === chapterId
    );
    if (check === undefined) {
      userInfo?.histories?.readingComic.push({
        chapterId: new mongoose.Types.ObjectId(chapterId),
      });
    } else {
      const indexOfItem = userInfo?.histories?.readingComic.indexOf(check);
      if (indexOfItem !== undefined) {
        userInfo?.histories?.readingComic.splice(indexOfItem, 1, {
          chapterId: new mongoose.Types.ObjectId(chapterId),
        });
      }
    }
    await userInfo?.save();
    res.status(200).json(userInfo);
  } catch (error) {
    next(error);
  }
};

export const getComicChapterComments: RequestHandler = async (
  req,
  res,
  next
) => {
  try {
    const url = req.url;
    const [, params] = url.split("?");
    const parsedParams = qs.parse(params);
    const chapterId =
      typeof parsedParams.chapterId === "string" ? parsedParams.chapterId : "";

    var chapter = await ComicChapterModel.findById(chapterId).select(
      "comments"
    );
    if (!chapter) {
      return res.sendStatus(400);
    }

    return res.status(200).json(chapter.comments).end();
  } catch (error) {
    next(error);
  }
};

export const addRootChapterComments: RequestHandler = async (
  req,
  res,
  next
) => {
  try {
    const { chapterId, userId, content } = req.body;
    var chapter = await ComicChapterModel.findById(chapterId);
    console.log(chapter);
    if (!chapter) {
      return res.sendStatus(400);
    }

    var user = await UserModel.findById(userId);
    if (!user) {
      return res.sendStatus(400);
    }

    chapter.comments.push({
      _id: new mongoose.Types.ObjectId(),
      userId: new mongoose.Types.ObjectId(userId),
      likes: new mongoose.Types.Array(),
      replies: new mongoose.Types.Array(),
      content: content,
      avatar: user.avatar,
      userName: user.username,
    });

    await chapter?.save();
    return res.status(200).json(chapter).end();
  } catch (error) {
    next(error);
  }
};
