import { RequestHandler } from "express";
import UserReportsModel from "../models/userreport";
import mongoose from "mongoose";

export const sendUserReport: RequestHandler = async (req, res, next) => {
  try {
    const {
      reportContent,
      userBeReportedId,
      userReportedId,
      type,
      destinationId,
      commentId,
    } = req.body;
    await UserReportsModel.create({
      reportContent: reportContent,
      reportTime: Date.now(),
      userBeReportedId: new mongoose.Types.ObjectId(userBeReportedId),
      userReportedId: new mongoose.Types.ObjectId(userReportedId),
      type: type,
      destinationId: new mongoose.Types.ObjectId(destinationId),
      commentId: new mongoose.Types.ObjectId(commentId),
      status: "pending",
    });
    res.sendStatus(200);
  } catch (error) {
    next(error);
  }
};