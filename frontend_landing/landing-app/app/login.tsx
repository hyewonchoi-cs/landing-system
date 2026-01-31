import { View, Text, StyleSheet, Image, Pressable } from "react-native";
import { router } from "expo-router";

export default function LoginPage() {
  return (
    <View style={styles.container}>
      {/* 로고 */}
      <Image
        source={require("@/assets/images/splash-logo.png")}
        style={styles.logo}
        resizeMode="contain"
      />

      {/* 로그인 버튼 (Mock) */}
      <Pressable
        style={styles.primaryButton}
        onPress={() => router.replace("/home")}
      >
        <Text style={styles.primaryButtonText}>로그인</Text>
      </Pressable>

      {/* 회원가입 */}
      <Pressable onPress={() => router.push("/signup")}>
        <Text style={styles.linkText}>아직 계정이 없으신가요? 회원가입</Text>
      </Pressable>
    </View>
  );
}

/* ---------------- styles ---------------- */

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#FFFFFF",
    alignItems: "center",
    justifyContent: "center",
    paddingHorizontal: 24,
  },
  logo: {
    width: 100,
    height: 100,
    marginBottom: 32,
  },
  title: {
    fontSize: 24,
    fontWeight: "700",
    marginBottom: 8,
  },
  subtitle: {
    fontSize: 14,
    color: "#666",
    textAlign: "center",
    marginBottom: 32,
  },
  primaryButton: {
    width: "100%",
    backgroundColor: "#22C55E",
    paddingVertical: 14,
    borderRadius: 12,
    alignItems: "center",
    marginBottom: 16,
  },
  primaryButtonText: {
    color: "#FFFFFF",
    fontSize: 16,
    fontWeight: "600",
  },
  linkText: {
    fontSize: 13,
    color: "#22C55E",
  },
});