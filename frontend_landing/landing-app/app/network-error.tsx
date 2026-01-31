import StatusScreen from "@/components/StatusScreen";
import { router } from "expo-router";

export default function NetworkErrorScreen() {
  return (
    <StatusScreen
      title="현재 접속이 원활하지 않아요"
      description="현재 네트워크에 연결되어 있지 않아요.\n잠시 후 다시 시도해주세요."
      buttonText="다시 시도하기"
      onPress={() => router.replace("/")}
    />
  );
}