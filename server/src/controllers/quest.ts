import { RequestHandler } from "express";
import DailyQuestModel from "../models/dailyQuest";
import UserModel from "../models/user";
import mongoose from "mongoose";
import createHttpError from "http-errors";

export const getDailyQuests: RequestHandler = async (req, res, next) => {
  try {
    const quests = await DailyQuestModel.find().exec();
    res.status(200).json(quests);
  } catch (error) {
    next(error);
  }
};

export const updateLoginLog: RequestHandler = async (req, res, next) => {
  const userId = req.body.userId;
  try {
    if (!mongoose.isValidObjectId(userId)) {
      throw createHttpError(400, "Invalid user id");
    }
    const userInfo = await UserModel.findById(userId);
    if (userInfo) {
      var plusCoin = 0;
      if (!userInfo.questLog["hasReceivedDailyGift"]) {
        const coinPoint = await DailyQuestModel.find({
          questType: "login",
        });
        plusCoin = plusCoin + (coinPoint[0]?.prize ? coinPoint[0].prize : 0);
        if (userInfo.coinPoint) {
          userInfo.coinPoint = userInfo.coinPoint + plusCoin;
        }
        userInfo.questLog = {
          readingTime: userInfo.questLog["readingTime"],
          watchingTime: userInfo.questLog["watchingTime"],
          received: userInfo.questLog["received"],
          finalTime: userInfo.questLog["finalTime"],
          hasReceivedDailyGift: true,
        };
        await userInfo?.save();
      }
      res.status(200).json(userInfo);
    } else {
      return res.sendStatus(400);
    }
  } catch (error) {
    return res.sendStatus(400);
  }
};

export const updateQuestLog: RequestHandler = async (req, res, next) => {
  const readingTime = parseInt(req.body.readingTime);
  const watchingTime = parseInt(req.body.watchingTime);
  const userId = req.body.userId;
  const received = req.body.received;
  try {
    if (!mongoose.isValidObjectId(userId)) {
      throw createHttpError(400, "Invalid user id");
    }
    const userInfo = await UserModel.findById(userId);
    if (userInfo) {
      const idList: mongoose.Types.ObjectId[] = userInfo.questLog.received;
      var plusCoin = 0;
      if (received !== "") {
        idList.push(new mongoose.Types.ObjectId(received));
        const coinPoint = await DailyQuestModel.findById(received).select(
          "prize"
        );
        plusCoin = plusCoin + (coinPoint?.prize ? coinPoint?.prize : 0);
        if (userInfo.coinPoint) {
          userInfo.coinPoint = userInfo.coinPoint + plusCoin;
        }
      }
      userInfo.questLog = {
        readingTime: readingTime,
        watchingTime: watchingTime,
        received: idList,
        finalTime: new Date(),
        hasReceivedDailyGift: userInfo.questLog["hasReceivedDailyGift"],
      };
      await userInfo?.save();
      res.status(200).json(userInfo);
    } else {
      return res.sendStatus(400);
    }
  } catch (error) {
    return res.sendStatus(400);
  }
};
