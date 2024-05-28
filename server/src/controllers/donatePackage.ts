import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import DonatePackagesModel from "../models/donatePackage";
import UserModel from "../models/user";

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

    // Get user details
    const userIds = Object.keys(userDonations);
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