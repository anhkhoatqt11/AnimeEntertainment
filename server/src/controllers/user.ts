import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import * as admin from 'firebase-admin';
import AvatarModel from "../models/avatars";
import UserModel from "../models/user";
import qs from "qs";
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

export const getNotification: RequestHandler = async (
  req,
  res,
  next
) => {
  const url = req.url;
  const [, params] = url.split("?");
  const parsedParams = qs.parse(params);
  const userId =
    typeof parsedParams.userId === "string" ? parsedParams.userId : "";

  try {
    var user = await UserModel.findById(userId);

    if (!user) {
      return res.status(400);
    }

    res.status(200).json(user?.notifications).end();
  } catch (error) {
    next(error);
  }
};

export const storeDeviceToken: RequestHandler = async (req, res, next) => {
  try {
    const { userId, token } = req.body;
    var user = await UserModel.findById(userId);
    if (!user) {
      return res.sendStatus(400);
    }
    user.deviceToken = token;
    await user?.save();
    return res.status(200).json(user).end();
  } catch (error) {
    next(error);
  }
};

export const sendPushNoti: RequestHandler = async (
  req,
  res,
  next
) => {
  try {
    try {
      var serviceAccount = require("../../pushnotiflutter-95328-firebase-adminsdk-rdiar-9008d7c00f.json");
      admin.initializeApp({
        credential: admin.credential.cert(serviceAccount)
      });
    }
    catch {

    }

    //const token = "fYxl0HrhQGWk50NtCOKqq6:APA91bHMWUF391_XNFlIlBQcCzPK-1qwofwwZAj0pfE072_3q5ZhbzGOIgmV8i-nk-lOrLHoYPVo6rL7MjFXn0XttdBFwn5-rh3Wad8dfy7xFXfcN5MNRdmaUb0PpOJakDZvqLvdXGAt";

    const message = {
      notification: {
        title: req.body.title,
        body: req.body.body,
      },
      token: req.body.token, // This is the device token
    };

    // Send a message to the device corresponding to the provided
    // registration token.
    admin.messaging().send(message)
      .then((response) => {
        // Response is a message ID string.
        console.log('Successfully sent message:', response);
        res.send('Successfully sent message: ' + response);
      })
      .catch((error) => {
        console.log('Error sending message:', error);
        res.send('Error sending message: ' + error);
      });
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