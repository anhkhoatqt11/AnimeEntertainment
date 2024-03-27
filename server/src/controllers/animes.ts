import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import ComicsModel from "../models/comics"
import BannerModel from "../models/banner"
import AnimeEpisodeModel from "../models/animeEpisode"

import AnimeAlbumModel from "../models/animeAlbum"


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


export const getAnimeAlbum: RequestHandler = async (req, res, next)=>{
    try
    {
        const albums = await AnimeAlbumModel.find().exec();
        res.status(200).json(albums);
    }
    catch (error)
    {
        next(error);
    }
}

export const getAnimeInAlbum: RequestHandler = async (req, res, next)=>{
    try
    {
        const response:string = req.body.idAlbum;
        const limit = parseInt(req.body.limit);
        const page = parseInt(req.body.page);
        const albums = await AnimeAlbumModel.aggregate([
            {
                $match: { _id: new mongoose.Types.ObjectId(response) }
            },
            {
                
                $lookup: {
                    from: "animes",
                    localField: "animeList",
                    foreignField:"_id",
                    pipeline: [
                        { $skip: (page-1)*limit},
                        { $limit: limit },
                      ],
                    as: "detailList"
                }
                
            },
            {
                $project: { "detailList.genres": 0,"detailList.publishTime": 0,"detailList.ageFor": 0,"detailList.publisher": 0
                            ,"detailList.description": 0,"detailList.episodes": 0}
            }
        ]);
            res.status(200).json(albums);

    }
    catch (error)
    {
        next(error);
    }
}



export const getNewEpisodeAnime: RequestHandler = async (req, res, next)=>{
    try
    {
        const animes = await AnimeEpisodeModel.aggregate([
            {
                $lookup: {
                    from: "animes",
                    localField: "_id",
                    foreignField:"episodes",
                    as: "animeOwner"

                },
            },
            { $project : { _id: 1, coverImage: 1, episodeName: 1, "animeOwner.movieName" : 1, publicTime: 1} },
            { "$sort": { "publicTime": -1 } },
            { $limit: 10 },
            
        ]);
        res.status(200).json(animes);
    }
    catch (error)
    {
        next(error);
    }
}




