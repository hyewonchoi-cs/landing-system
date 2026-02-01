import Onboarding from "../models/onboarding.model.js";

export const saveOnboarding = async (data) => {
  return await Onboarding.create(data);
};

export const getOnboardingByUser = async (userId) => {
  return await Onboarding.findOne({ userId });
};