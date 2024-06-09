import express from "express";
import * as UserController from "../controllers/user";
const router = express.Router();

router.get("/getAvatarList", UserController.getAvatarList);

router.post("/updateAvatar", UserController.updateAvatar);

router.post("/updateUsername", UserController.updateUsername);

router.post("/uploadUsername", UserController.uploadUsername);

router.get("/getBookmarkList", UserController.getBookmarkList);

router.post("/removeBookmark", UserController.removeBookmark);

router.put("/storeDeviceToken", UserController.storeDeviceToken);

router.get("/getNotification", UserController.getNotification);

router.post("/sendPushNoti", UserController.sendPushNoti);

router.post("/addCommentNotification", UserController.addCommentNotification);

router.put("/paySkycoin", UserController.paySkycoin);

router.put("/readNotification", UserController.readNotification);

router.get("/getPaymentHistories", UserController.getPaymentHistories);

export default router;
