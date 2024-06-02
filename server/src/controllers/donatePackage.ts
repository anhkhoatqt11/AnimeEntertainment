import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import DonatePackagesModel from "../models/donatePackage";
import UserModel from "../models/user";
import PaymentHistoryModel from "../models/paymentHistories";

export const getDonatePackageList: RequestHandler = async (req, res, next) => {
  try {
    const donatePackages = await DonatePackagesModel.find();
    res.status(200).json(donatePackages);
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
      datetime: new Date()
    };

    donatePackage.donateRecords.push(newDonateRecord);
    await donatePackage.save();

    res.status(201).json(newDonateRecord);
  } catch (error) {
    next(error);
  }
}

export const getDonatorList: RequestHandler = async (req, res, next) => {
  try {
    const donatePackages = await DonatePackagesModel.find();

    const userDonations: { [key: string]: number } = {};

    // Aggregate donations for each user
    donatePackages.forEach((donatePackage) => {
      const packageCoin = donatePackage.coin ?? 0;
      donatePackage.donateRecords.forEach((record) => {
        const userId = record.userId.toString();
        if (!userDonations[userId]) {
          userDonations[userId] = 0;
        }
        userDonations[userId] += packageCoin;
      });
    });

    // Convert user IDs to ObjectId if valid
    const userIds = Object.keys(userDonations).filter(id => mongoose.Types.ObjectId.isValid(id)).map(id => new mongoose.Types.ObjectId(id));

    // Get user details
    const users = await UserModel.find({ _id: { $in: userIds } }).select('username');

    const result = users.map((user) => ({
      username: user.username,
      totalCoins: userDonations[user._id.toString()],
    }));

    res.status(200).json(result);
  } catch (error) {
    next(error);
  }
};


export const processDonationPayment: RequestHandler = async (req, res, next) => {

  try {
    const { userId, amount } = req.body;

    const user = await UserModel.findById(userId);

    if (!user) {
      return next(createHttpError(404, "User not found"));
    }

    user.coinPoint = (user.coinPoint ?? 0) - amount;

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
}