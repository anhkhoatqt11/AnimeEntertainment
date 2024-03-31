import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import AnimesModel from "../models/anime";
import BannerModel from "../models/banner";
import AnimeEpisodeModel from "../models/animeEpisode";

import AnimeAlbumModel from "../models/animeAlbum";

export const getAnimeBanner: RequestHandler = async (req, res, next) => {
  try {
    const banners = await BannerModel.findOne({ type: "Anime" });
    res.status(200).json(banners);
  } catch (error) {
    next(error);
  }
};

export const getAnimeAlbum: RequestHandler = async (req, res, next) => {
  try {
    const albums = await AnimeAlbumModel.find().exec();
    res.status(200).json(albums);
  } catch (error) {
    next(error);
  }
};

export const getAnimeInAlbum: RequestHandler = async (req, res, next) => {
  try {
    const response: string = req.body.idAlbum;
    const limit = parseInt(req.body.limit);
    const page = parseInt(req.body.page);
    const albums = await AnimeAlbumModel.aggregate([
      {
        $match: { _id: new mongoose.Types.ObjectId(response) },
      },
      {
        $lookup: {
          from: "animes",
          localField: "animeList",
          foreignField: "_id",
          pipeline: [{ $skip: (page - 1) * limit }, { $limit: limit }],
          as: "detailList",
        },
      },
      {
        $project: {
          "detailList.genres": 0,
          "detailList.publishTime": 0,
          "detailList.ageFor": 0,
          "detailList.publisher": 0,
          "detailList.description": 0,
          "detailList.episodes": 0,
        },
      },
    ]);
    res.status(200).json(albums);
  } catch (error) {
    next(error);
  }
};

export const getNewEpisodeAnime: RequestHandler = async (req, res, next) => {
  try {
    const animes = await AnimeEpisodeModel.aggregate([
      {
        $lookup: {
          from: "animes",
          localField: "_id",
          foreignField: "episodes",
          as: "animeOwner",
        },
      },
      {
        $project: {
          _id: 1,
          coverImage: 1,
          episodeName: 1,
          "animeOwner.movieName": 1,
          publicTime: 1,
        },
      },
      { $sort: { publicTime: -1 } },
      { $limit: 10 },
    ]);
    res.status(200).json(animes);
  } catch (error) {
    next(error);
  }
};

export const getRankingTable: RequestHandler = async (req, res, next) => {
  try {
    const animes = await AnimeEpisodeModel.aggregate([
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
          from: "animes",
          localField: "_id",
          foreignField: "episodes",
          as: "movieOwner",
        },
      },
      // { $project : {"ratepoint":1,"_id":1,"movieOwner.movieName":1} },

      {
        $group: {
          _id: {
            movieOwnerId: "$movieOwner._id",
            coverImage: "$movieOwner.coverImage",
            landspaceImage: "$movieOwner.landspaceImage",
            movieName: "$movieOwner.movieName",
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
      { $limit: 9 },
    ]);
    res.status(200).json(animes);
  } catch (error) {
    next(error);
  }
};

export const getTopViewAnime: RequestHandler = async (req, res, next) => {
  try {
    const animes = await AnimeEpisodeModel.aggregate([
      {
        $lookup: {
          from: "animes",
          localField: "_id",
          foreignField: "episodes",
          as: "movieOwner",
        },
      },
      {
        $group: {
          _id: {
            movieOwnerId: "$movieOwner._id",
            movieName: "$movieOwner.movieName",
          },
          totalView: { $sum: "$views" },
        },
      },
      { $sort: { totalView: -1 } },
      { $limit: 10 },
    ]);
    res.status(200).json(animes);
  } catch (error) {
    next(error);
  }
};

export const getAnimeChapterById: RequestHandler = async (req, res, next) => {
  const animeId = req.body.animeId;
  const limit = parseInt(req.body.limit);
  const page = parseInt(req.body.page);
  try {
    if (!mongoose.isValidObjectId(animeId)) {
      throw createHttpError(400, "Invalid anime id");
    }
    const anime = await AnimesModel.aggregate([
      {
        $match: { _id: new mongoose.Types.ObjectId(animeId) },
      },
      {
        $lookup: {
          from: "animeepisodes",
          localField: "episodes",
          foreignField: "_id",
          pipeline: [{ $skip: (page - 1) * limit }, { $limit: limit }],
          as: "movieEpisodes",
        },
      },
      {
        $project: {
          _id: 1,
          movieName: 1,
          "movieEpisodes._id": 1,
          "movieEpisodes.coverImage": 1,
          "movieEpisodes.episodeName": 1,
          "movieEpisodes.views": 1,
        },
      },
    ]);

    if (!anime) {
      throw createHttpError(404, "anime not found");
    }
    res.status(200).json(anime);
  } catch (error) {
    next(error);
  }
};
