import express from "express";
import cors from "cors";
import { connectDB } from "./utils/db.js";
import onboardingRouter from "./routes/onboarding.route.js";

const app = express();

app.use(cors());
app.use(express.json());

connectDB();

app.use("/api/onboarding", onboardingRouter);

app.get("/", (req, res) => {
  res.send("Server running");
});

app.listen(4000, () => {
  console.log("Server running on port 4000");
});