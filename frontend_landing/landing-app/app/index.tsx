import { View, Text, StyleSheet } from "react-native";
import { useEffect, useState } from "react";
import { BASE_URL } from "@/constants/api";


type IntroData = {
  appName: string;
  tagline: string;
  description: string;
};

export default function IntroPage() {
  const [intro, setIntro] = useState<IntroData | null>(null);

  useEffect(() => {
  fetch(`${BASE_URL}/api/intro`)
    .then((res) => res.json())
    .then((data) => setIntro(data))
    .catch((err) => {
      console.error("Failed to load intro data", err);
    });
}, []);

  if (!intro) {
    return (
      <View style={styles.container}>
        <Text>Loading...</Text>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      {/* 임시 로고 영역 */}
      <View style={styles.logoCircle}>
        <Text style={styles.logoText}>LOGO</Text>
      </View>

      {/* 앱 이름 */}
      <Text style={styles.appName}>{intro.appName}</Text>

      {/* 한 줄 설명 */}
      <Text style={styles.tagline}>{intro.tagline}</Text>

      {/* 상세 설명 */}
      <Text style={styles.description}>{intro.description}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#F2F2F2", // 🔹 임시 배경색
    alignItems: "center",
    justifyContent: "center",
    paddingHorizontal: 24,
  },
  logoCircle: {
    width: 110,
    height: 110,
    borderRadius: 55,
    backgroundColor: "#222",
    alignItems: "center",
    justifyContent: "center",
    marginBottom: 24,
  },
  logoText: {
    color: "#fff",
    fontWeight: "bold",
    fontSize: 16,
  },
  appName: {
    fontSize: 28,
    fontWeight: "700",
    marginBottom: 8,
  },
  tagline: {
    fontSize: 16,
    fontWeight: "600",
    textAlign: "center",
    marginBottom: 16,
  },
  description: {
    fontSize: 14,
    color: "#555",
    textAlign: "center",
    lineHeight: 20,
  },
});
