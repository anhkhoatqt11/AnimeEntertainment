import { RequestHandler } from "express";
import QuestionModel from "../models/questions";


export const getChallegenQuestions: RequestHandler = async (req, res, next) => {
    try {
        const questions = await QuestionModel.find().exec();
        res.status(200).json(questions);
    } catch (error) {
        next(error);
    }
}