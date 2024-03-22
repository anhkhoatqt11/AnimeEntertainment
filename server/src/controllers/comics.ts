import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import ComicsModel from "../models/comics"
import BannerModel from "../models/banner"
import ComicChapterModel from "../models/comicChapter"

import ComicAlbumModel from "../models/comicAlbum"

// api get
export const getComicBanner: RequestHandler = async (req, res, next)=>{
    try
    {
        const banners = await BannerModel.findOne({type: "Comic"});
        res.status(200).json(banners);
    }
    catch (error)
    {
        next(error);
    }
}

export const getComicAlbum: RequestHandler = async (req, res, next)=>{
    try
    {
        const albums = await ComicAlbumModel.find().exec();
        res.status(200).json(albums);
    }
    catch (error)
    {
        next(error);
    }
}

export const getNewChapterComic: RequestHandler = async (req, res, next)=>{
    try
    {
        const comics = await ComicChapterModel.aggregate([
            {
                $lookup: {
                    from: "comics",
                    localField: "_id",
                    foreignField:"chapterList",
                    as: "chapterOwner"

                },
            },
            { $project : { publicTime : 1 ,"chapterOwner._id": 1, "chapterOwner.comicName": 1,"chapterOwner.coverImage": 1,"chapterOwner.genres": 1} },
            {
                $lookup: {
                    from: "genres",
                    localField: "chapterOwner.genres",
                    foreignField:"_id",
                    as: "genreName"

                },
            },
            
            {
                $group: {
                    _id: { chapterOwnerId : "$chapterOwner._id", coverImage: "$chapterOwner.coverImage", comicName: "$chapterOwner.comicName", genres: "$genreName" },
                    publicTime: { $top:
                    {
                       output: [ "$publicTime" ],
                       sortBy: { "publicTime": -1 }
                    } }
                }
            },
            { "$sort": { "publicTime": -1 } },
            { $limit: 10 },
            
        ]);
        res.status(200).json(comics);
    }
    catch (error)
    {
        next(error);
    }
}
// api get one
export const getComicInAlbum: RequestHandler = async (req, res, next)=>{
    try
    {
        const response:string = req.body.idList;
        const limit = parseInt(req.body.limit);
        const page = parseInt(req.body.page);
        const comics:any[] = [];
        var idList = response.replace('[','').replace(']','').replace(/\s/g, "").split(',');
        if ((page-1)*limit > idList.length-1) {
          res.status(200).json(comics);  
          return;
        }
        else idList = idList.splice((page-1)*limit,limit);
        idList.forEach(async (element)=> {
            await ComicsModel.aggregate([
                {
                    $match: { _id: new mongoose.Types.ObjectId(element) }
                 },
                {
                    $lookup: {
                        from: "genres",
                        localField: "genres",
                        foreignField:"_id",
                        as: "genreName"
                    }
                },
                {
                    $project: { _id: 1, coverImage: 1, comicName: 1, genreName: 1, description: 1}
                }
               
            ]).then((item)=>{
                comics.push(item);
                if (comics.length === idList.length ) {
                    res.status(200).json(comics);
                }
            });
        });
    }
    catch (error)
    {
        next(error);
    }
}

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
        // Mỗi một comic có một field gọi là chapterList chứa id của các chapter 
        const comic = await ComicsModel.aggregate([
            {
                $lookup: {
                    // tên table comicChapter
                    from: "comicChapters",
                    // tên field của chapterList trong table comic
                    localField: "chapterList",
                    // khóa ngoại ở table comicChapter chính là _id
                    foreignField:"_id",
                    // alias cho table join mới
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
