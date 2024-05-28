import { RequestHandler } from "express";
import PaymentHistories from "../models/paymentHistories";

export const getPaymentHistoriesByUserId: RequestHandler = async (req, res, next) => {
    try {
        const { userId } = req.query;
        
        if (!userId || typeof userId !== 'string') {
            return res.status(400).json({ message: "Invalid userId parameter" });
        }

        const histories = await PaymentHistories.find({ userId: userId }).exec();
        
        if (!histories || histories.length === 0) {
            return res.status(404).json({ message: "No payment histories found for this user" });
        }
        
        res.status(200).json(histories);
    } catch (error) {
        next(error);
    }
}