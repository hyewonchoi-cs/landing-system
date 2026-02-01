import express from "express";
import { createOnboarding, getOnboarding } from "../controllers/onboarding.controller.js";

const router = express.Router();

router.post("/", createOnboarding);
router.get("/:userId", getOnboarding);

export default router;