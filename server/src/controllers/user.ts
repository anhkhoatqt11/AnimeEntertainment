import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import UserModel from "../models/user"

// api get
export const getUsers: RequestHandler = async (req, res, next)=>{
    try
    {
        const users = await UserModel.find().exec();
        console.log(users);
        res.status(200).json(users);
    }
    catch (error)
    {
        next(error);
    }
}
// // api get one
export const getUser: RequestHandler = async (req, res, next) => {
    const userId = req.params.userId;
    try
    {
        if (!mongoose.isValidObjectId(userId))
        {
            throw createHttpError(400, "Invalid user id")
        }
        const user = await UserModel.findById(userId).exec();

        if (!user) {
            throw createHttpError(404, "User not found")
        }
        res.status(200).json(user);
    }
    catch (error)
    {
        next(error)
    }
}
// api post

interface CreateUserBody {
    name: string,
    phoneNumber: string,
    total: number,
    payed: number,
    debt: number,
}

export const createUser: RequestHandler<unknown, unknown, CreateUserBody, unknown> = async (req, res, next ) => {
    const userData:CreateUserBody = {
        name: req.body.name,
        phoneNumber : req.body.phoneNumber,
        total : req.body.total ,
        payed : req.body.payed ,
        debt : req.body.debt ,
    };
    try
    {
        const newUser = await UserModel.create(userData)
        res.status(201).json(newUser);
    }
    catch (error)
    {
        next(error);
    }
}

interface UpdateUserParams {
    userId: string,
}

// interface UpdateUserBody {
//     name: string,
//     phoneNumber: string,
//     total: number,
//     payed: number,
//     debt: number,
// }

// export const updateUser: RequestHandler<UpdateUserParams, unknown, UpdateUserBody, unknown> = async(req, res, next) => {
//     const userId = req.params.userId;
//     try
//     {
//         if (!mongoose.isValidObjectId(userId))
//         {
//             throw createHttpError(400, "Invalid user id");
//         }
//         const user = await UserModel.findById(userId).exec();

//         if (!user)
//         {
//             throw createHttpError(404, "user not found");
//         }
//         await UserModel.findByIdAndUpdate(userId,req.body);

//         res.status(200).json(updateUser);

//     }
//     catch (error)
//     {
//         next(error);
//     }
// };

// // api delete
// export const deleteUser: RequestHandler = async(req, res, next) => {
//     const userId = req.params.userId;
//     try {
//         if (!mongoose.isValidObjectId(userId))
//         {
//             throw createHttpError(400, "Invalid user id");
//         }

//         const user = await UserModel.findById(userId).exec();

//         if (!user) {
//             throw createHttpError(404, "user not found");
//         }

//         await user.deleteOne();
//         res.sendStatus(204);

//     } catch (error) {
        
//     }
// }
