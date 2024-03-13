import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import UserModel from "../models/user"
import { random, authentication } from "../utils/utils"

export const getUsers = () => UserModel.find();
export const getUserByPhone = (phone: string) => UserModel.findOne({ phone });
export const getUserBySessionToken = (sessionToken: string) => UserModel.findOne({ 'authentication.sessionToken': sessionToken });
export const getUserById = (id: string) => UserModel.findById(id);
export const createUser = (values: Record<string, any>) => new UserModel(values).save().then((user) => user.toObject());
export const deleteUserById = (id: string) => UserModel.findOneAndDelete({ _id: id });
export const updateUserById = (id: string, values: Record<string, any>) => UserModel.findByIdAndUpdate(id, values);


export const getLogin: RequestHandler = async (req,res) => {
    try {
        const result = await getUserBySessionToken(req.body.sessionToken);
        if (result)
        {
            res.send({ loggedIn: true }).sendStatus(200);
        }
        else {
            res.send({ loggedIn: false }).sendStatus(200);
        }
    }
    catch (error) {
        console.log(error);
        return res.sendStatus(400);
    }
}

export const postLogin: RequestHandler = async (req, res) => {
    try {
        const {phone, password} = req.body;
        if (!phone || !password ) {
            return res.sendStatus(400);

        }
        var user = await getUserByPhone(phone).select('+authentication.salt + authentication.password');
        if (!user)
        {
            return res.sendStatus(400);
        }
        var saltChecked = "";
        if (typeof(user.authentication?.salt) === "string")
        {
            saltChecked = user.authentication.salt;
        }
        const expectedHash = authentication(saltChecked, password);
        if (user.authentication?.password !== expectedHash)
        {
            return res.sendStatus(403);
        }
        else {
            req.session.user = phone;
            res.cookie("sessionId", req.sessionID);
        }

        const salt = random();
        user.authentication.sessionToken = authentication(salt, user._id.toString());
        await user.save();
        res.cookie('USER-AUTH', user.authentication.sessionToken, {domain: 'localhost',path: '/'});
        return res.status(200).json(user).end();

    }
    catch (error)
    {
        console.log(error);
        return res.sendStatus(400);
    }
}

export const register:RequestHandler = async (req, res)=>{
    try
    {
        const {phone, password} = req.body;

        if (!phone || !password) {
            return res.sendStatus(400);
        }
        const existingUser = await getUserByPhone(phone);
        if (existingUser) {
            return res.sendStatus(400);
        }

        const salt = random();
        const user = await createUser({
            phone,authentication:{
                salt,password: authentication(salt,password)
            }
        })

        return res.status(200).json(user).end();
    }
    catch (error)
    {
        console.log(error);
        return res.sendStatus(400);
    }
}