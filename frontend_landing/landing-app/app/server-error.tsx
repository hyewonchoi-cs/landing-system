import StatusScreen from "@/components/StatusScreen";
import { router } from "expo-router";

export default function ServerErrorScreen() {
  return (
    <StatusScreen
      title="시스템 오류가 발생"
      description="일시적인 오류가 발생\n잠시 후 다시 시도하기"
      buttonText="다시 시도하기"
      onPress={() => router.replace("/")}
    />
  );
}