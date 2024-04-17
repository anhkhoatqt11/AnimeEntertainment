import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import DonatePackagesModel from "../models/donatePackage";

export const getDonatePackageList: RequestHandler = async (req, res, next) => {
  try {
    const donatePackages = await DonatePackagesModel.find();
    res.status(200).json(donatePackages);
  } catch (error) {
    next(error);
  }
};
