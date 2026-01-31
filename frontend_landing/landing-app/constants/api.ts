import { Platform } from "react-native";

export const BASE_URL =
  Platform.OS === "web"
    ? "http://localhost:4000"
    : "http://10.10.151.35:4000";
