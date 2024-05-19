import express from "express";
import * as UserController from "../controllers/user";
const router = express.Router();

router.get("/getAvatarList", UserController.getAvatarList);

router.post("/updateAvatar", UserController.updateAvatar);

router.put("/storeDeviceToken", UserController.storeDeviceToken);

router.get("/getNotification", UserController.getNotification);

router.post("/sendPushNoti", UserController.sendPushNoti);

export default router;
