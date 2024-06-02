import express from "express";
import * as DonatePackagesController from "../controllers/donatePackage";
const router = express.Router();

router.get(
  "/getDonatePackageList",
  DonatePackagesController.getDonatePackageList
);

router.post("/uploadDonateRecord", DonatePackagesController.uploadDonateRecord);

router.get("/getDonatorList", DonatePackagesController.getDonatorList);

router.post("/processDonationPayment", DonatePackagesController.processDonationPayment);

export default router;
