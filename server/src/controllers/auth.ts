import { RequestHandler } from "express";
import createHttpError from "http-errors";
import mongoose from "mongoose";
import UserModel from "../models/user";
import { random, authentication, hashOTP } from "../utils/utils";
import otpGenerator from "otp-generator";
var https = require("follow-redirects").https;
var fs = require("fs");
import env from "../utils/validateEnv";

export const getUsers = () => UserModel.find();
export const getUserByPhone = (phone: string) => UserModel.findOne({ phone });
export const getUserBySessionToken = (sessionToken: string) =>
  UserModel.findOne({ "authentication.sessionToken": sessionToken });
export const getUserById = (id: string) => UserModel.findById(id);
export const createUser = (values: Record<string, any>) =>
  new UserModel(values).save().then((user) => user.toObject());
export const deleteUserById = (id: string) =>
  UserModel.findOneAndDelete({ _id: id });
export const updateUserById = (id: string, values: Record<string, any>) =>
  UserModel.findByIdAndUpdate(id, values);

const calculateQuestDateRenew = (value: Date) => {
  var currentTime = new Date();
  if (
    currentTime.getFullYear() > value.getFullYear() ||
    currentTime.getMonth() > value.getMonth() ||
    currentTime.getDate() > value.getDate()
  ) {
    return true;
  } else {
    return false;
  }
};

export const getLogin: RequestHandler = async (req, res) => {
  try {
    const result = await getUserBySessionToken(req.body.sessionToken);
    var renewable = false;
    if (result) {
      if (
        calculateQuestDateRenew(
          new Date(result?.questLog.finalTime.toString())
        ) === true
      ) {
        renewable = true;
        result.questLog = {
          readingTime: 0,
          watchingTime: 0,
          received: [],
          finalTime: new Date(),
          hasReceivedDailyGift: false,
        };
        await result.save();
      }
      return res
        .status(200)
        .json({
          loggedIn: true,
          id: result["_id"],
          username: result["username"],
          avatar: result["avatar"],
          coinPoint: result["coinPoint"],
          questLog:
            renewable === true
              ? {
                  readingTime: 0,
                  watchingTime: 0,
                  received: [],
                  finalTime: new Date(),
                  hasReceivedDailyGift: false,
                }
              : result["questLog"],
          challenges: result["challenges"],
        notifications: result["notifications"]
        })
        .end();
    } else {
      return res.status(200).json({ loggedIn: false }).end();
    }
  } catch (error) {
    console.log(error);
    return res.sendStatus(400);
  }
};

export const postLogin: RequestHandler = async (req, res) => {
  try {
    const { phone, password } = req.body;
    if (!phone || !password) {
      return res.sendStatus(400);
    }
    var user = await getUserByPhone(phone).select(
      "+authentication.salt + authentication.password + username + avatar + coinPoint + questLog + challenges + notifications"
    );
    if (!user) {
      return res.sendStatus(400);
    }
    var saltChecked = "";
    if (typeof user.authentication?.salt === "string") {
      saltChecked = user.authentication.salt;
    }
    const expectedHash = authentication(saltChecked, password);
    if (user.authentication?.password !== expectedHash) {
      return res.sendStatus(403);
    } else {
      req.session.user = phone;
      res.cookie("sessionId", req.sessionID);
    }

    const salt = random();
    user.authentication.sessionToken = authentication(
      salt,
      user._id.toString()
    );
    //
    var renewable = false;
    if (user) {
      if (
        calculateQuestDateRenew(
          new Date(user?.questLog.finalTime.toString())
        ) === true
      ) {
        renewable = true;
        user.questLog = {
          readingTime: 0,
          watchingTime: 0,
          received: [],
          finalTime: new Date(),
          hasReceivedDailyGift: false,
        };
      }
    }
    //
    await user.save();
    return res.status(200).json(user).end();
  } catch (error) {
    return res.sendStatus(400);
  }
};

export const register: RequestHandler = async (req, res) => {
  try {
    const { phone, password } = req.body;

    if (!phone || !password) {
      return res.sendStatus(400);
    }
    const existingUser = await getUserByPhone(phone);
    if (existingUser) {
      return res.sendStatus(400);
    }

    const salt = random();
    const randomName = random();
    const user = await createUser({
      phone,
      authentication: {
        salt,
        password: authentication(salt, password),
      },
      bookmarkList: {},
      histories: {},
      paymentHistories: {},
      avatar:
        "https://i.pinimg.com/736x/dc/9c/61/dc9c614e3007080a5aff36aebb949474.jpg",
      username: "user" + randomName,
      coinPoint: 0,
      challenges: [],
      questLog: {
        readingTime: 0,
        watchingTime: 0,
        received: [],
        finalTime: new Date(),
        hasReceivedDailyGift: false,
      },
    });

    return res.status(200).json(user).end();
  } catch (error) {
    console.log(error);
    return res.sendStatus(400);
  }
};

export const checkExistingAccount: RequestHandler = async (req, res) => {
  try {
    const { phone } = req.body;
    const existingUser = await getUserByPhone(phone);
    if (existingUser) {
      return res.sendStatus(200);
    }
    return res.sendStatus(400);
  } catch (error) {
    console.log(error);
    return res.sendStatus(400);
  }
};

export const updatePassword: RequestHandler = async (req, res) => {
  try {
    const { phone, password } = req.body;
    if (!phone || !password) {
      return res.sendStatus(400);
    }
    var user = await getUserByPhone(phone).select(
      "+authentication.salt + authentication.password"
    );
    if (!user) {
      return res.sendStatus(400);
    }
    const salt = random();
    user.authentication = { salt, password: authentication(salt, password) };
    await user.save();
    return res.status(200).json(user).end();
  } catch (error) {
    console.log(error);
    return res.sendStatus(400);
  }
};

export const createOtp: RequestHandler = async (req, res) => {
  try {
    const { phone } = req.body;
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
    console.log(phone);
    sendSMS(phone, otp);

    return res.status(200).send({ message: "Success", data: fullHash });
  } catch (error) {
    console.log(error);
    return res.sendStatus(400);
  }
};

export const verifyOTP: RequestHandler = async (req, res) => {
  try {
    const { hash, phone, otp } = req.body;
    let [hashValue, expires] = hash.split(".");

    let now = Date.now();
    if (now > parseInt(expires))
      return res.status(200).send({
        message: "Success",
        data: "Mã OTP đã hết hạn, vui lòng thực hiện lại",
      });
    let data = `${phone}.${otp}.${expires}`;

    let newHash = hashOTP(data);
    if (newHash === hashValue) {
      return res.status(200).send({ message: "Success", data: "Success" });
    }
    return res.status(200).send({
      message: "Success",
      data: "Mã OTP không hợp lệ, vui lòng nhập lại",
    });
  } catch (error) {
    console.log(error);
    return res.sendStatus(400);
  }
};

const sendSMS = (phone: string, otp: string) => {
  var options = {
    method: "POST",
    hostname: "ggzgge.api.infobip.com",
    path: "/sms/2/text/advanced",
    headers: {
      Authorization: `App ${env.SEND_SMS_API}`,
      "Content-Type": "application/json",
      Accept: "application/json",
    },
    maxRedirects: 20,
  };

  var req = https.request(
    options,
    function (res: {
      on: (
        arg0: string,
        arg1: { (chunk: any): void; (chunk: any): void; (error: any): void }
      ) => void;
    }) {
      var chunks: any[] = [];

      res.on("data", function (chunk: any) {
        chunks.push(chunk);
      });

      res.on("end", function (chunk: any) {
        var body = Buffer.concat(chunks);
        console.log(body.toString());
      });

      res.on("error", function (error: any) {
        console.error(error);
      });
    }
  );

  var postData = JSON.stringify({
    messages: [
      {
        destinations: [{ to: phone }],
        from: "ServiceSMS",
        text: "Skylark comic xin chào, mã xác nhận của bạn là " + otp,
      },
    ],
  });

  req.write(postData);

  req.end();
};
