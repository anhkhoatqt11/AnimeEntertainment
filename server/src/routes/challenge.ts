import express from "express";

import * as ChallengeController from "../controllers/challenge";

const router = express.Router();

router.get("/getChallengeQuestions", ChallengeController.getChallegenQuestions);

router.get(
  "/getChallengeInformation",
  ChallengeController.getChallengeInformation
);

router.get(
  "/getUsersChallengesPoint",
  ChallengeController.getUsersChallengesPoint
);

router.post(
  "/uploadUsersChallengesPoint",
  ChallengeController.uploadUsersChallengesPoint
);

export default router;
