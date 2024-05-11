import express from "express";
import * as ComicsController from "../controllers/comics";
const router = express.Router();

router.get("/getComic", ComicsController.getComic);

router.get("/getChapterComic", ComicsController.getChapterOfComic);

router.get("/getComicBanner", ComicsController.getComicBanner);

router.get("/getComicAlbum", ComicsController.getComicAlbum);

router.get("/getNewChapterComic", ComicsController.getNewChapterComic);

router.get("/getComicInAlbum", ComicsController.getComicInAlbum);

router.get("/getRankingTable", ComicsController.getRankingTable);

router.get("/getDetailComicById", ComicsController.getDetailComicById);

router.put("/updateUserSaveChapter", ComicsController.updateUserSaveChapter);

router.get(
  "/checkUserHasLikeOrSaveChapter",
  ComicsController.checkUserHasLikeOrSaveChapter
);

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

router.get(
  "/getComicChapterComments",
  ComicsController.getComicChapterComments
);

router.post("/addRootChapterComments", ComicsController.addRootChapterComments);

router.get("/searchComic", ComicsController.searchComics);

export default router;
