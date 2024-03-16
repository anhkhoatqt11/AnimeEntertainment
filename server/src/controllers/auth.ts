import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import UserModel from "../models/user"
import { random, authentication, hashOTP } from "../utils/utils"
import otpGenerator from "otp-generator";


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

export const createOtp:RequestHandler = async (req, res) => {
    try
    {
        const {phone } = req.body;
        const otp = otpGenerator.generate(4, {
            lowerCaseAlphabets: false,
            upperCaseAlphabets: false,
            specialChars: false,
        });
    
        const ttl = 5 * 60 * 1000;
        const expires = Date.now() + ttl;
        const data = `${phone}.${otp}.${expires}`;
        const hash = hashOTP(data);
        const fullHash = `${hash}.${expires}`;
    
        return res.status(200).send({message: "Success",data: fullHash});
    }
    catch (error){
        console.log(error);
        return res.sendStatus(400);
    }
    
}

export const verifyOTP:RequestHandler = async(req,res) => {
    try {
        const {hash,phone,otp } = req.body;
        let [hashValue, expires] = hash.split('.');
    
        let now = Date.now();
        if (now > parseInt(expires)) return res.status(200).send({message: "Success", data: "OTP expired"});
        let data = `${phone}.${otp}.${expires}`;
    
        let newHash = hashOTP(data);
        if (newHash === hashValue) {
            return res.status(200).send({message: "Success", data: "Success"});
        }
        return res.status(200).send({message: "Success", data: "Invalid OTP"});
    }
    catch (error) {
        console.log(error);
        return res.sendStatus(400);
    }
    

}