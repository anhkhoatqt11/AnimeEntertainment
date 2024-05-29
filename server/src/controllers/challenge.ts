import { RequestHandler } from "express";
import ChallengesModel from "../models/challenges";
import UserModel from "../models/user";

export const getChallegenQuestions: RequestHandler = async (req, res, next) => {
  try {
    const questions = await ChallengesModel.find().select("questionCollection");
    res.status(200).json(questions[0]?.questionCollection);
  } catch (error) {
    next(error);
  }
};

export const getChallengeInformation: RequestHandler = async (
  req,
  res,
  next
) => {
  try {
    const questions = await ChallengesModel.find();
    res.status(200).json(questions[0]);
  } catch (error) {
    next(error);
  }
};

export const getUsersChallengesPoint: RequestHandler = async (
  req,
  res,
  next
) => {
  try {
    const user = await UserModel.find().exec();
    res.status(200).json(
      user.map((u) => ({
        userId: u._id,
        name: u.username,
        avatar: u.avatar,
        point: u.challenges,
      }))
    );
  } catch (error) {
    next(error);
  }
};

export const uploadUsersChallengesPoint: RequestHandler = async (
  req,
  res,
  next
) => {
  try {
    const { userId, point, date, remainingTime } = req.body;
    var user = await UserModel.findById(userId);
    if (!user) {
      return res.sendStatus(400);
    }

    // Create a new challenge object
    var newChallenge = {
      date: date,
      point: point,
      time: remainingTime,
    };

    // Push the new challenge to the challenges array
    user.challenges.push(newChallenge);

    // Give price to user
    if (user.coinPoint)
      user.coinPoint = user.coinPoint + Math.round(point / 10);

    // Save the user document
    await user.save();

    // Respond with success status
    res.sendStatus(200);
  } catch (error) {
    next(error);
  }
};
