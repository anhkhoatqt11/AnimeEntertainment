import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import DonatePackagesModel from "../models/donatePackage";
import UserModel from "../models/user";
import PaymentHistoryModel from "../models/paymentHistories";
import qs from "qs";

export const getDonatePackageList: RequestHandler = async (req, res, next) => {
  try {
    const donatePackages = await DonatePackagesModel.find();
    res.status(200).json(donatePackages);
  } catch (error) {
    next(error);
  }
};

export const getDonatePackageDetail: RequestHandler = async (
  req,
  res,
  next
) => {
  const url = req.url;
  const [, params] = url.split("?");
  const parsedParams = qs.parse(params);
  const packageId =
    typeof parsedParams.packageId === "string" ? parsedParams.packageId : "";
  try {
    if (!mongoose.isValidObjectId(packageId)) {
      throw createHttpError(400, "Invalid packageId id");
    }
    const donatePackage = await DonatePackagesModel.findById(packageId);

    if (!donatePackage) {
      throw createHttpError(404, "Donate Package not found");
    }
    res.status(200).json(donatePackage);
  } catch (error) {
    next(error);
  }
};

export const uploadDonateRecord: RequestHandler = async (req, res, next) => {
  const { packageId, userId } = req.body;

  try {
    const donatePackage = await DonatePackagesModel.findById(packageId);

    if (!donatePackage) {
      return next(createHttpError(404, "Donate package not found"));
    }

    const newDonateRecord = {
      userId,
      datetime: new Date(),
    };

    donatePackage.donateRecords.push(newDonateRecord);
    await donatePackage.save();

    res.status(201).json(newDonateRecord);
  } catch (error) {
    next(error);
  }
};

export const getDonatorList: RequestHandler = async (req, res, next) => {
  try {
    const donatePackages = await DonatePackagesModel.find();

    const userDonations: {
      [key: string]: { totalCoins: number; donationCount: number };
    } = {};

    // Aggregate donations for each user
    donatePackages.forEach((donatePackage) => {
      const packageCoin = donatePackage.coin ?? 0;
      donatePackage.donateRecords.forEach((record) => {
        const userId = record.userId.toString();
        if (!userDonations[userId]) {
          userDonations[userId] = { totalCoins: 0, donationCount: 0 };
        }
        userDonations[userId].totalCoins += packageCoin;
        userDonations[userId].donationCount += 1;
      });
    });

    // Convert user IDs to ObjectId if valid
    const userIds = Object.keys(userDonations)
      .filter((id) => mongoose.Types.ObjectId.isValid(id))
      .map((id) => new mongoose.Types.ObjectId(id));

    // Get user details
    const users = await UserModel.find({ _id: { $in: userIds } }).select(
      "username avatar"
    );

    const result = users.map((user) => ({
      username: user.username,
      totalCoins: userDonations[user._id.toString()].totalCoins,
      donationCount: userDonations[user._id.toString()].donationCount,
      avatar: user.avatar,
    }));

    // Sort the result from highest to lowest totalCoins
    result.sort((a, b) => b.totalCoins - a.totalCoins);

    // Only get the top 10 highest records
    const top10Result = result.slice(0, 10);

    res.status(200).json(top10Result);
  } catch (error) {
    next(error);
  }
};

export const processDonationPayment: RequestHandler = async (
  req,
  res,
  next
) => {
  try {
    const { userId, amount } = req.body;

    const user = await UserModel.findById(userId);

    if (!user) {
      return next(createHttpError(404, "User not found"));
    }

    if ((user.coinPoint || 0) < (amount || 1)) {
      return next(createHttpError(404, "Skycoin not enough for payment"));
    } else user.coinPoint = (user.coinPoint ?? 0) - amount;

    const newPaymentHistory = await PaymentHistoryModel.create({
      userId: userId,
      orderDate: new Date(),
      paymentMethod: "Donation",
      status: "completed",
      price: amount,
      packageId: null,
    });
    await user.save();
    res.status(200).json(newPaymentHistory);
  } catch (error) {
    next(error);
  }
};
