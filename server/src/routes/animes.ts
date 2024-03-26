import express from "express"
import * as AnimeController from "../controllers/animes"
const router = express.Router();

router.get("/getAllAnimes",AnimeController.getAllMovies);


export default router;