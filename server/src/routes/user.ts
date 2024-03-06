import express from "express"
import * as UserController from "../controllers/user"
const router = express.Router();

router.get("/getAllUsers", UserController.getUsers);

router.get("/getUser/:userId", UserController.getUser)

router.post("/createUser", UserController.createUser)

router.patch("/updateUser/:userId", UserController.updateUser)

router.delete("/deleteUser/:userId", UserController.deleteUser)


export default router;