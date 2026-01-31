import { View, Text, StyleSheet, TouchableOpacity } from "react-native";
import { router } from "expo-router";

export default function LoginPage() {
  return (
    <View style={styles.container}>
      <Text style={styles.logo}>noyo</Text>
      <Text style={styles.title}>회원가입이 필요해요</Text>

      <TouchableOpacity style={styles.socialButton}>
        <Text style={styles.socialText}>🍎 애플로 시작하기</Text>
      </TouchableOpacity>

      <TouchableOpacity style={styles.socialButton}>
        <Text style={styles.socialText}>💬 카카오로 시작하기</Text>
      </TouchableOpacity>

      <TouchableOpacity style={styles.socialButton}>
        <Text style={styles.socialText}>🌐 Google로 시작하기</Text>
      </TouchableOpacity>

      <View style={styles.divider}>
        <View style={styles.line} />
        <Text style={styles.or}>또는</Text>
        <View style={styles.line} />
      </View>

      <TouchableOpacity style={styles.loginButton}>
        <Text style={styles.loginText}>로그인</Text>
      </TouchableOpacity>

      <TouchableOpacity onPress={() => router.push("/signup")}>
        <Text style={styles.signupText}>아직 계정이 없으신가요?  회원가입</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#FFFFFF",
    justifyContent: "center",
    alignItems: "center",
    paddingHorizontal: 24,
  },
  logo: {
    fontSize: 32,
    fontWeight: "700",
    color: "#1DB954",
    marginBottom: 12,
  },
  title: {
    fontSize: 18,
    fontWeight: "600",
    marginBottom: 32,
  },
  socialButton: {
    width: "100%",
    height: 52,
    borderRadius: 26,
    borderWidth: 1,
    borderColor: "#DDD",
    justifyContent: "center",
    alignItems: "center",
    marginBottom: 12,
  },
  socialText: {
    fontSize: 16,
    fontWeight: "500",
  },
  divider: {
    flexDirection: "row",
    alignItems: "center",
    marginVertical: 24,
    width: "100%",
  },
  line: {
    flex: 1,
    height: 1,
    backgroundColor: "#E0E0E0",
  },
  or: {
    marginHorizontal: 12,
    color: "#999",
  },
  loginButton: {
    width: "100%",
    height: 52,
    borderRadius: 26,
    backgroundColor: "#F2F2F2",
    justifyContent: "center",
    alignItems: "center",
    marginBottom: 16,
  },
  loginText: {
    fontSize: 16,
    fontWeight: "600",
    color: "#999",
  },
  signupText: {
    fontSize: 14,
    color: "#1DB954",
    fontWeight: "600",
  },
});