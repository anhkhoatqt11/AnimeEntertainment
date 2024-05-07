import express from "express";
import * as DailyQuestController from "../controllers/quest";
const router = express.Router();

router.get("/getDailyQuests", DailyQuestController.getDailyQuests);

router.post("/updateQuestLog", DailyQuestController.updateQuestLog);

export default router;
