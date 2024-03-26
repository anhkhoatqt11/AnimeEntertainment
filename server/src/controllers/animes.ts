import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import AnimesModel from "../models/anime"
import BannerModel from "../models/banner"


export const getAnimeBanner: RequestHandler = async (req, res, next)=>{
    try
    {
        const banners = await BannerModel.findOne({type: "Anime"});
        res.status(200).json(banners);
    }
    catch (error)
    {
        next(error);
    }
}



