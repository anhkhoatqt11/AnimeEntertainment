import express from "express";
import * as DonatePackagesController from "../controllers/donatePackage";
const router = express.Router();

router.get(
  "/getDonatePackageList",
  DonatePackagesController.getDonatePackageList
);

export default router;
