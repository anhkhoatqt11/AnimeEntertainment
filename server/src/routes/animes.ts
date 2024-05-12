import express from "express";
import * as AnimeController from "../controllers/animes";
const router = express.Router();

router.get("/getAnimeBanner", AnimeController.getAnimeBanner);

router.get("/getAnimeAlbum", AnimeController.getAnimeAlbum);

router.get("/getAnimeInAlbum", AnimeController.getAnimeInAlbum);

router.get("/getNewEpisodeAnime", AnimeController.getNewEpisodeAnime);

router.get("/getRankingTable", AnimeController.getRankingTable);

router.get("/getTopViewAnime", AnimeController.getTopViewAnime);

router.get("/getAnimeChapterById", AnimeController.getAnimeChapterById);

router.get("/getAnimeDetailById", AnimeController.getAnimeDetailById);

router.get("/getSomeTopViewEpisodes", AnimeController.getSomeTopViewEpisodes);

router.get(
  "/getAnimeEpisodeDetailById",
  AnimeController.getAnimeEpisodeDetailById
);

router.get(
  "/getAnimeDetailInEpisodePageById",
  AnimeController.getAnimeDetailInEpisodePageById
);

router.post("/updateEpisodeView", AnimeController.updateEpisodeView);

router.post("/updateUserLikeEpisode", AnimeController.updateUserLikeEpisode);

router.post("/updateUserSaveEpisode", AnimeController.updateUserSaveEpisode);

router.get(
  "/checkUserHasLikeOrSaveEpisode",
  AnimeController.checkUserHasLikeOrSaveEpisode
);

router.post(
  "/updateUserHistoryHadSeenEpisode",
  AnimeController.updateUserHistoryHadSeenEpisode
);

router.get(
  "/checkUserHistoryHadSeenEpisode",
  AnimeController.checkUserHistoryHadSeenEpisode
);

router.get("/searchAnimeAndEpisodes", AnimeController.searchAnimeAndEpisodes);

router.get("/getWatchingHistories", AnimeController.getWatchingHistories);
export default router;
