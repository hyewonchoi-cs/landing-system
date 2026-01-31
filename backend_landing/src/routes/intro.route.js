// backend_landing/src/routes/intro.route.js
const express = require("express");
const router = express.Router();

router.get("/intro", (req, res) => {
  res.json({
    appName: "Landing",
    tagline: "위고비 중단 이후를 위한 착륙 시스템",
    description:
      "이 앱은 감량을 위한 앱이 아닙니다. 약물 중단 이후 발생하는 생리적·행동적·심리적 부작용을 관리하기 위한 안전한 착륙을 돕습니다."
  });
});

module.exports = router;
