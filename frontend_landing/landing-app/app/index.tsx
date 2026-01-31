import { View, Text, StyleSheet, Image, ActivityIndicator, Pressable } from "react-native";
import { useEffect, useState } from "react";
import { router } from "expo-router";
import { BASE_URL } from "@/constants/api";

type IntroData = {
  appName: string;
  tagline: string;
  description: string;
};

export default function IntroPage() {
  const [intro, setIntro] = useState<IntroData | null>(null);

  useEffect(() => {
    const fetchIntro = async () => {
      try {
        const res = await fetch(`${BASE_URL}/api/intro`);

        if (!res.ok) {
          router.replace("/server-error");
          return;
        }

        const data = await res.json();
        setIntro(data);
      } catch {
        router.replace("/network-error");
      }
    };

    fetchIntro();
  }, []);

  /* ---------------- 로딩 상태 ---------------- */
  if (!intro) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color="#22C55E" />
      </View>
    );
  }

  /* ---------------- 정상 화면 ---------------- */
  return (
    <View style={styles.container}>
      {/* 로고 */}
      <Image
        source={require("@/assets/images/splash-logo.png")}
        style={styles.logo}
        resizeMode="contain"
      />

      {/* 앱 이름 */}
      <Text style={styles.appName}>{intro.appName}</Text>

      {/* 태그라인 */}
      <Text style={styles.tagline}>{intro.tagline}</Text>

      {/* 설명 */}
      <Text style={styles.description}>{intro.description}</Text>

      {/* CTA 버튼 */}
      <Pressable
        style={styles.button}
        onPress={() => router.push("/login")} // 다음 화면
      >
        <Text style={styles.buttonText}>시작하기</Text>
      </Pressable>
    </View>
  );
}

/* ---------------- 스타일 ---------------- */

const styles = StyleSheet.create({
  loadingContainer: {
    flex: 1,
    backgroundColor: "#FFFFFF",
    alignItems: "center",
    justifyContent: "center",
  },
  container: {
    flex: 1,
    backgroundColor: "#FFFFFF",
    alignItems: "center",
    justifyContent: "center",
    paddingHorizontal: 24,
  },
  logo: {
    width: 120,
    height: 120,
    marginBottom: 24,
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
    marginBottom: 12,
  },
  description: {
    fontSize: 14,
    color: "#555",
    textAlign: "center",
    lineHeight: 20,
    marginBottom: 32,
  },
  button: {
    backgroundColor: "#22C55E",
    paddingVertical: 14,
    paddingHorizontal: 32,
    borderRadius: 999,
  },
  buttonText: {
    color: "#FFFFFF",
    fontSize: 16,
    fontWeight: "600",
  },
});