import express from "express";

import * as ChallengeController from "../controllers/challenge";

const router = express.Router();

router.get("/getChallengeQuestions", ChallengeController.getChallegenQuestions);

export default router;