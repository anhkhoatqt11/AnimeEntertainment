import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import AnimesModel from "../models/anime";
import BannerModel from "../models/banner";
import AnimeEpisodeModel from "../models/animeEpisode";
import UserModel from "../models/user";
import AnimeAlbumModel from "../models/animeAlbum";
import qs from "qs";

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
    const url = req.url;
    const [, params] = url.split("?");
    const parsedParams = qs.parse(params);
    const limit = parseInt(
      typeof parsedParams.limit === "string" ? parsedParams.limit : "0"
    );
    const page = parseInt(
      typeof parsedParams.page === "string" ? parsedParams.page : "0"
    );
    const response: string =
      typeof parsedParams.idAlbum === "string" ? parsedParams.idAlbum : "0";

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
  const url = req.url;
  const [, params] = url.split("?");
  const parsedParams = qs.parse(params);
  const page = parseInt(
    typeof parsedParams.page === "string" ? parsedParams.page : "0"
  );
  const limit = parseInt(
    typeof parsedParams.limit === "string" ? parsedParams.limit : "0"
  );
  const animeId =
    typeof parsedParams.animeId === "string" ? parsedParams.animeId : "";
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

export const getAnimeDetailById: RequestHandler = async (req, res, next) => {
  const url = req.url;
  const [, params] = url.split("?");
  const parsedParams = qs.parse(params);
  const animeId =
    typeof parsedParams.animeId === "string" ? parsedParams.animeId : "";
  try {
    if (!mongoose.isValidObjectId(animeId)) {
      throw createHttpError(400, "Invalid anime id");
    }
    // Mỗi một comic có một field gọi là chapterList chứa id của các chapter
    const anime = await AnimesModel.aggregate([
      {
        $match: { _id: new mongoose.Types.ObjectId(animeId) },
      },
      {
        $lookup: {
          from: "animeepisodes",
          localField: "episodes",
          foreignField: "_id",
          pipeline: [
            {
              $addFields: {
                likeCount: { $size: "$likes" },
              },
            },
          ],
          as: "detailEpisodeList",
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
            $sum: "$detailEpisodeList.views",
          },
        },
      },
      {
        $addFields: {
          totalLikes: {
            $sum: "$detailEpisodeList.likeCount",
          },
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

export const getSomeTopViewEpisodes: RequestHandler = async (
  req,
  res,
  next
) => {
  try {
    const animes = await AnimeEpisodeModel.aggregate([
      { $sort: { views: -1 } },
      {
        $project: {
          _id: 1,
          coverImage: 1,
          episodeName: 1,
          totalTime: 1,
          views: 1,
        },
      },
      { $limit: 12 },
    ]);
    res.status(200).json(animes);
  } catch (error) {
    next(error);
  }
};

export const getAnimeEpisodeDetailById: RequestHandler = async (
  req,
  res,
  next
) => {
  const url = req.url;
  const [, params] = url.split("?");
  const parsedParams = qs.parse(params);
  const episodeId =
    typeof parsedParams.episodeId === "string" ? parsedParams.episodeId : "";
  try {
    if (!mongoose.isValidObjectId(episodeId)) {
      throw createHttpError(400, "Invalid episode id");
    }
    const episode = await AnimeEpisodeModel.findById(episodeId);

    if (!episode) {
      throw createHttpError(404, "episode not found");
    }
    res.status(200).json(episode);
  } catch (error) {
    next(error);
  }
};

export const getAnimeDetailInEpisodePageById: RequestHandler = async (
  req,
  res,
  next
) => {
  const url = req.url;
  const [, params] = url.split("?");
  const parsedParams = qs.parse(params);
  const animeId =
    typeof parsedParams.animeId === "string" ? parsedParams.animeId : "";
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
          from: "genres",
          localField: "genres",
          foreignField: "_id",
          as: "genreNames",
        },
      },
      {
        $lookup: {
          from: "animeepisodes",
          localField: "episodes",
          foreignField: "_id",
          as: "listEpisodes",
        },
      },
      {
        $project: {
          _id: 1,
          movieName: 1,
          publishTime: 1,
          ageFor: 1,
          publisher: 1,
          genreNames: 1,
          "listEpisodes._id": 1,
          "listEpisodes.coverImage": 1,
          "listEpisodes.episodeName": 1,
          "listEpisodes.totalTime": 1,
          "listEpisodes.views": 1,
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

export const updateEpisodeView: RequestHandler = async (req, res, next) => {
  try {
    const episodeId = req.body.episodeId;
    var episode = await AnimeEpisodeModel.findById(episodeId);
    if (!episode) {
      return res.sendStatus(400);
    }
    episode.views = episode.views! + 1;
    await episode?.save();
    return res.status(200).json(episode).end();
  } catch (error) {
    next(error);
  }
};

export const updateUserLikeEpisode: RequestHandler = async (req, res, next) => {
  try {
    const { episodeId, userId } = req.body;
    var episode = await AnimeEpisodeModel.findById(episodeId);
    if (!episode) {
      return res.sendStatus(400);
    }
    var check = episode.likes.filter((item) => item.toString() === userId);
    if (check.length === 0) {
      episode.likes.push(new mongoose.Types.ObjectId(userId));
    } else {
      episode.likes = episode.likes.filter(
        (item) => item.toString() !== userId
      );
    }
    await episode?.save();
    return res.status(200).json(episode).end();
  } catch (error) {
    next(error);
  }
};

export const updateUserSaveEpisode: RequestHandler = async (req, res, next) => {
  try {
    const { episodeId, userId } = req.body;
    var user = await UserModel.findById(userId);
    if (!user) {
      return res.sendStatus(400);
    }
    var checkSave = user.bookmarkList!["movies"].filter(
      (item) => item.toString() === episodeId
    );
    if (checkSave.length === 0) {
      user.bookmarkList!["movies"].push(new mongoose.Types.ObjectId(episodeId));
    } else {
      user.bookmarkList!["movies"] = user.bookmarkList!["movies"].filter(
        (item) => item.toString() !== episodeId
      );
    }
    await user?.save();
    return res.status(200).json(user).end();
  } catch (error) {
    next(error);
  }
};

export const checkUserHasLikeOrSaveEpisode: RequestHandler = async (
  req,
  res,
  next
) => {
  try {
    const url = req.url;
    const [, params] = url.split("?");
    const parsedParams = qs.parse(params);
    const episodeId =
      typeof parsedParams.episodeId === "string" ? parsedParams.episodeId : "";
    const userId =
      typeof parsedParams.userId === "string" ? parsedParams.userId : "";

    // check like
    var episode = await AnimeEpisodeModel.findById(episodeId);
    if (!episode) {
      return res.sendStatus(400);
    }
    var check = episode.likes.filter((item) => item.toString() === userId);
    // check bookmark
    var user = await UserModel.findById(userId);
    if (!user) {
      return res.sendStatus(400);
    }
    var checkSave = user.bookmarkList!["movies"].filter(
      (item) => item.toString() === episodeId
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

export const checkUserHistoryHadSeenEpisode: RequestHandler = async (
  req,
  res,
  next
) => {
  const url = req.url;
  const [, params] = url.split("?");
  const parsedParams = qs.parse(params);
  const episodeId =
    typeof parsedParams.episodeId === "string" ? parsedParams.episodeId : "";
  const userId =
    typeof parsedParams.userId === "string" ? parsedParams.userId : "";
  try {
    if (!mongoose.isValidObjectId(episodeId)) {
      throw createHttpError(400, "Invalid episode id");
    }
    const userInfo = await UserModel.findById(userId).select("histories");
    var check = userInfo?.histories?.watchingMovie.find(
      (item) => item.episodeId.toString() === episodeId
    );
    res.status(200).json(check === undefined ? {} : check);
  } catch (error) {
    next(error);
  }
};

export const updateUserHistoryHadSeenEpisode: RequestHandler = async (
  req,
  res,
  next
) => {
  const episodeId = req.body.episodeId;
  const userId = req.body.userId;
  const position = parseInt(req.body.position);
  try {
    if (!mongoose.isValidObjectId(userId)) {
      throw createHttpError(400, "Invalid user id");
    }
    const userInfo = await UserModel.findById(userId).select("histories");
    var check = userInfo?.histories?.watchingMovie.find(
      (item) => item.episodeId.toString() === episodeId
    );
    if (check === undefined) {
      userInfo?.histories?.watchingMovie.push({
        episodeId: new mongoose.Types.ObjectId(episodeId),
        position: position,
      });
    } else {
      const indexOfItem = userInfo?.histories?.watchingMovie.indexOf(check);
      if (indexOfItem !== undefined) {
        userInfo?.histories?.watchingMovie.splice(indexOfItem, 1, {
          episodeId: new mongoose.Types.ObjectId(episodeId),
          position: position,
        });
      }
    }
    await userInfo?.save();
    res.status(200).json(userInfo);
  } catch (error) {
    next(error);
  }
};

export const getWatchingHistories: RequestHandler = async (req, res, next) => {
  const url = req.url;
  const [, params] = url.split("?");
  const parsedParams = qs.parse(params);
  const page = parseInt(
    typeof parsedParams.page === "string" ? parsedParams.page : "0"
  );
  const limit = parseInt(
    typeof parsedParams.limit === "string" ? parsedParams.limit : "0"
  );
  const userId =
    typeof parsedParams.userId === "string" ? parsedParams.userId : "";
  try {
    if (!mongoose.isValidObjectId(userId)) {
      throw createHttpError(400, "Invalid user id");
    }
    const histories = await UserModel.aggregate([
      {
        $match: { _id: new mongoose.Types.ObjectId(userId) },
      },
      {
        $project: { histories: 1 },
      },
      {
        $lookup: {
          from: "animeepisodes",
          localField: "histories.watchingMovie.episodeId",
          foreignField: "_id",
          pipeline: [{ $skip: (page - 1) * limit }, { $limit: limit }],
          as: "detailHistories",
        },
      },
      {
        $project: {
          histories: 1,
          "detailHistories._id": 1,
          "detailHistories.episodeName": 1,
          "detailHistories.coverImage": 1,
          "detailHistories.totalTime": 1,
          "detailHistories.position": 1,
        },
      },
    ]);
    res.status(200).json(histories);
  } catch (error) {
    next(error);
  }
};
