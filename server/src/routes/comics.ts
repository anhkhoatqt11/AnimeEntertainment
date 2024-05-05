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

router.put("/updateUserSaveChapter", ComicsController.updateUserSaveChapter);

router.get("/checkUserHasLikeOrSaveChapter", ComicsController.checkUserHasLikeOrSaveChapter);

router.post("/updateChapterView", ComicsController.updateChapterView);

router.post("/updateUserLikeChapter", ComicsController.updateUserLikeChapter);

router.get(
    "/checkUserHasLikeOrSaveChapter",
    ComicsController.checkUserHasLikeOrSaveChapter
);

router.post(
    "/updateUserHistoryHadSeenChapter",
    ComicsController.updateUserHistoryHadSeenChapter
);

router.get(
    "/checkUserHistoryHadSeenChapter",
    ComicsController.checkUserHistoryHadSeenChapter
);

export default router;

