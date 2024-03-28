import express from "express"
import * as AnimeController from "../controllers/animes"
const router = express.Router();

router.get("/getAnimeBanner",AnimeController.getAnimeBanner);

router.get("/getAnimeAlbum",AnimeController.getAnimeAlbum);

router.post("/getAnimeInAlbum",AnimeController.getAnimeInAlbum);

router.get("/getNewEpisodeAnime",AnimeController.getNewEpisodeAnime);

router.get("/getRankingTable",AnimeController.getRankingTable);
export default router;