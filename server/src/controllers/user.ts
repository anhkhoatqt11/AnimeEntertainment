import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import * as admin from 'firebase-admin';
import AvatarModel from "../models/avatars";
import UserModel from "../models/user";
import qs from "qs";

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