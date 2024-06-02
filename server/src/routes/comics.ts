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

router.post("/updateUserSaveChapter", ComicsController.updateUserSaveChapter);

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

router.get("/getComicChapter", ComicsController.getComicChapter);

router.get(
  "/getComicChapterComments",
  ComicsController.getComicChapterComments
);

router.post("/addRootChapterComments", ComicsController.addRootChapterComments);

router.post(
  "/addChildChapterComments",
  ComicsController.addChildChapterComments
);

router.get(
  "/checkValidCommentContent",
  ComicsController.checkValidCommentContent
);
router.get("/checkUserBanned", ComicsController.checkUserBanned);

router.put("/banUser", ComicsController.banUser);

router.get("/searchComic", ComicsController.searchComics);

router.post(
  "/updateUserLikeParentComment",
  ComicsController.updateUserLikeParentComment
);
router.post(
  "/updateUserLikeChildComment",
  ComicsController.updateUserLikeChildComment
);

router.get("/getReadingHistories", ComicsController.getReadingHistories);

router.get("/searchComicByGenres", ComicsController.searchComicByGenres);

export default router;
