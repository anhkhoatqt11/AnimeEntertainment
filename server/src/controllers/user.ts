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

export const getBookmarkList: RequestHandler = async (req, res, next) => {
  try {
    const { userId } = req.query;

    // Find the user by userId
    const user = await UserModel.findById(userId);
    if (!user) {
      return res.sendStatus(400);
    }

    // Check if bookmarkList exists in user document
    if (!user.bookmarkList) {
      return res.status(200).json({ comics: [], animes: [] });
    }

    // Get bookmarked comics
    const comicsIds = user.bookmarkList.comic || [];
    const comics = await ComicsModel.find({ _id: { $in: comicsIds } });

    // Get bookmarked animes
    const animesIds = user.bookmarkList.movies || [];
    const animes = await AnimeModel.find({ _id: { $in: animesIds } });

    return res.status(200).json({ comics, animes });
  } catch (error) {
    next(error);
  }
};



