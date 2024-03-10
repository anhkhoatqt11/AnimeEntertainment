import express from "express"
import * as ComicsController from "../controllers/comics"
const router = express.Router();

router.get("/getAllComics", ComicsController.getComics);

router.get("/getComic/:comicId", ComicsController.getComic)

router.get("/getChapterComic/:comicId", ComicsController.getChapterOfComic)

export default router;