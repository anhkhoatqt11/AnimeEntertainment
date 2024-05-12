import express from "express";
import * as UserController from "../controllers/user";
const router = express.Router();

router.get("/getAvatarList", UserController.getAvatarList);

router.post("/updateAvatar", UserController.updateAvatar);

router.post("/uploadUsername", UserController.uploadUsername);

router.get("/getBookmarkList", UserController.getBookmarkList);

router.post("/removeBookmark", UserController.removeBookmark);

export default router;
