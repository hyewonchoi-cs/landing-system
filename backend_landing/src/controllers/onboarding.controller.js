import { saveOnboarding, getOnboardingByUser } from "../services/onboarding.service.js";

export const createOnboarding = async (req, res) => {
  try {
    const onboarding = await saveOnboarding(req.body);
    res.status(201).json({
      success: true,
      data: onboarding
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      success: false,
      message: "온보딩 저장 실패"
    });
  }
};

export const getOnboarding = async (req, res) => {
  try {
    const { userId } = req.params;
    const onboarding = await getOnboardingByUser(userId);

    res.status(200).json({
      success: true,
      data: onboarding
    });
  } catch (error) {
    res.status(500).json({ success: false });
  }
};