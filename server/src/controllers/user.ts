import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import AvatarModel from "../models/avatars";
import UserModel from "../models/user";
import ComicsModel from "../models/comics";
import AnimeModel from "../models/anime";

// api get
export const getAvatarList: RequestHandler = async (req, res, next) => {
  try {
    const list = await AvatarModel.find().exec();
    res.status(200).json(list);
  } catch (error) {
    next(error);
  }
};

export const updateAvatar: RequestHandler = async (req, res, next) => {
  try {
    const { userId, avatarUrl } = req.body;
    var user = await UserModel.findById(userId);
    if (!user) {
      return res.sendStatus(400);
    }
    user.avatar = avatarUrl;
    await user?.save();
    return res.status(200).json(user).end();
  } catch (error) {
    next(error);
  }
};

export const uploadUsername: RequestHandler = async (req, res, next) => {
  try {
    const { userId, username } = req.body;
    var user = await UserModel.findById(userId);
    if (!user) {
      return res.sendStatus(400);
    }
    user.username = username;
    await user?.save();
    return res.status(200).json(user).end();
  } catch (error) {
    next(error);
  }
};

export const getBookmarkList: RequestHandler = async (req, res, next) => {
  try {
    const { userId } = req.query;

    // Find the user by userId
    // const user = await UserModel.findById(userId);
    // if (!user) {
    //   return res.sendStatus(400);
    // }

    // // Check if bookmarkList exists in user document
    // if (!user.bookmarkList) {
    //   return res.status(200).json({ comics: [], animes: [] });
    // }

    // // Get bookmarked comics
    // const comicsIds = user.bookmarkList.comic || [];
    // const comics = await ComicsModel.find({ _id: { $in: comicsIds } });

    // // Get bookmarked animes
    // const animesIds = user.bookmarkList.movies || [];
    // const animes = await AnimeModel.find({ _id: { $in: animesIds } });

    // return res.status(200).json({ comics, animes });

    const user = await UserModel.aggregate([
      {
        $match: { _id: new mongoose.Types.ObjectId(userId?.toString()) },
      },
      {
        $lookup: {
          from: "comics",
          localField: "bookmarkList.comic",
          foreignField: "_id",
          pipeline: [
            {
              $lookup: {
                from: "genres",
                localField: "genres",
                foreignField: "_id",
                pipeline: [],
                as: "genreNames",
              },
            },
          ],
          as: "comics",
        },
      },
      {
        $lookup: {
          from: "animes",
          localField: "bookmarkList.movies",
          foreignField: "_id",
          pipeline: [
            {
              $lookup: {
                from: "genres",
                localField: "genres",
                foreignField: "_id",
                pipeline: [],
                as: "genreNames",
              },
            },
          ],
          as: "animes",
        },
      },
      {
        $project: {
          comics: 1,
          animes: 1,
        },
      },
    ]);
    return res.status(200).json(user);
  } catch (error) {
    next(error);
  }
};

export const removeBookmark: RequestHandler = async (req, res, next) => {
  try {
    const { userId, bookmarksToRemove } = req.body;

    // Check if userId and bookmarksToRemove are provided
    if (!userId || !bookmarksToRemove || !Array.isArray(bookmarksToRemove)) {
      return res.status(400).json({ error: "Invalid input" });
    }

    // Find the user by userId
    const user = await UserModel.findById(userId);
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    // Assert that bookmarkList exists
    const bookmarkList = user.bookmarkList!;

    // Remove each bookmark from the user's bookmark list
    bookmarksToRemove.forEach((bookmarkId: string) => {
      const comicIndex = bookmarkList.comic.indexOf(bookmarkId);
      if (comicIndex !== -1) {
        bookmarkList.comic.splice(comicIndex, 1);
      }
      const movieIndex = bookmarkList.movies.indexOf(bookmarkId);
      if (movieIndex !== -1) {
        bookmarkList.movies.splice(movieIndex, 1);
      }
    });

    // Save the updated user
    await user.save();

    return res.status(200).json(user);
  } catch (error) {
    next(error);
  }
};
