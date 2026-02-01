import mongoose from "mongoose";

const onboardingSchema = new mongoose.Schema(
  {
    userId: {
      type: String,
      required: true
    },

    stopReason: String,          // 치료 중단 이유
    height: Number,
    weight: Number,

    workSchedule: {
      type: String,              // 고정근무 / 자유근무 등
    },

    workTime: {
      type: String,              // 09:00-18:00
    },

    sleepPattern: String,        // 22:00-06:00
    exerciseLevel: String        // 주 1-2회 산책
  },
  {
    timestamps: true
  }
);

const Onboarding = mongoose.model("Onboarding", onboardingSchema);
export default Onboarding;