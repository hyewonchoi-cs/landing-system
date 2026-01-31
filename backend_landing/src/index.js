const express = require("express");
const cors = require("cors");

const introRoute = require("./routes/intro.route");

const app = express();
app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.send("🚀 Landing System Backend is running");
});

app.use("/api", introRoute);

const PORT = 4000;
app.listen(PORT, "0.0.0.0", () => {
  console.log(`✅ Server running on http://localhost:${PORT}`);
});
