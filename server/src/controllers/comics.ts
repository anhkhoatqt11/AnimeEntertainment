import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import ComicsModel from "../models/comics"

// api get
export const getComics: RequestHandler = async (req, res, next)=>{
    try
    {
        const comics = await ComicsModel.find().exec();
        console.log(comics);
        res.status(200).json(comics);
    }
    catch (error)
    {
        next(error);
    }
}
// api get one
export const getComic: RequestHandler = async (req, res, next) => {
    const comicId = req.params.comicId;
    try
    {
        if (!mongoose.isValidObjectId(comicId))
        {
            throw createHttpError(400, "Invalid comic id")
        }
        const comic = await ComicsModel.findById(comicId).exec();

        if (!comic) {
            throw createHttpError(404, "comic not found")
        }
        res.status(200).json(comic);
    }
    catch (error)
    {
        next(error)
    }
}


export const getChapterOfComic: RequestHandler = async (req, res, next) => {
    const comicId = req.params.comicId;
    try
    {
        if (!mongoose.isValidObjectId(comicId))
        {
            throw createHttpError(400, "Invalid comic id")
        }
        // const comic = await ComicsModel.aggregate([
        //     {
        //         $lookup: {
        //             from: "comicChapters",
        //             as: "detailChapterList",
        //             let: {comicId: "$_id"},
        //             pipeline: [
        //                 {
        //                     $match: {
        //                         $expr: {
        //                             $and: [
        //                                 {$eq: ["$chapterList","$$comicId"]}
        //                             ]
        //                         }
        //                     }
        //                 }
        //             ]
        //         }
        //     }
        // ]);

        const comic = await ComicsModel.aggregate([
            {
                $lookup: {
                    from: "comicChapters",
                    localField: "chapterList",
                    foreignField:"_id",
                    as: "detailChapterList"

                }
            }
        ])

        if (!comic) {
            throw createHttpError(404, "comic not found")
        }
        res.status(200).json(comic);
    }
    catch (error)
    {
        next(error)
    }
}
