import express from "express";
import * as UserReportsController from "../controllers/reports";

const router = express.Router();

router.post("/sendUserReport", UserReportsController.sendUserReport);

export default router;