import express from "express";
import * as ComicsController from "../controllers/comics";
const router = express.Router();

router.get("/getComic/:comicId", ComicsController.getComic);

router.get("/getChapterComic/:comicId", ComicsController.getChapterOfComic);

router.get("/getComicBanner", ComicsController.getComicBanner);

router.get("/getComicAlbum", ComicsController.getComicAlbum);

router.get("/getNewChapterComic", ComicsController.getNewChapterComic);

router.post("/getComicInAlbum", ComicsController.getComicInAlbum);

router.get("/getDetailComicById", ComicsController.getDetailComicById);

router.put("/updateUserSaveComic", ComicsController.updateUserSaveComic);

router.get("/searchComic", ComicsController.searchComics);

export default router;
