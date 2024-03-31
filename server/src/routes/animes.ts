import express from "express";
import * as AnimeController from "../controllers/animes";
const router = express.Router();

router.get("/getAnimeBanner", AnimeController.getAnimeBanner);

router.get("/getAnimeAlbum", AnimeController.getAnimeAlbum);

router.post("/getAnimeInAlbum", AnimeController.getAnimeInAlbum);

router.get("/getNewEpisodeAnime", AnimeController.getNewEpisodeAnime);

router.get("/getRankingTable", AnimeController.getRankingTable);

router.get("/getTopViewAnime", AnimeController.getTopViewAnime);

router.post("/getAnimeChapterById", AnimeController.getAnimeChapterById);

router.post("/getAnimeDetailById", AnimeController.getAnimeDetailById);

router.post("/getEpisodeById", AnimeController.getEpisodeById);
export default router;
