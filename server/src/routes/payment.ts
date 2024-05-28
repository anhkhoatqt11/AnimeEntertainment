import express from "express";

import * as PaymentController from "../controllers/payment";

const router = express.Router();

router.get("/getPaymentHistoriesByUserId", PaymentController.getPaymentHistoriesByUserId);

export default router;