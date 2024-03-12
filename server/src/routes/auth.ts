import express from "express"
import * as AuthController from "../controllers/auth"
const router = express.Router();


router.post("/login" ,AuthController.postLogin);
router.post("/autoLogin",AuthController.getLogin);
router.post("/register", AuthController.register);

export default router;