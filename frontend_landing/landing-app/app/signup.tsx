import {
  View,
  Text,
  StyleSheet,
  Image,
  TextInput,
  Pressable,
  Alert,
} from "react-native";
import { useState } from "react";
import { router } from "expo-router";

export default function SignupPage() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleSignup = () => {
    if (!email || !password) {
      Alert.alert("입력 오류", "이메일과 비밀번호를 모두 입력해봐.");
      return;
    }

    
    router.replace("/home");
  };

  return (
    <View style={styles.container}>
      {/* 로고 */}
      <Image
        source={require("@/assets/images/splash-logo.png")}
        style={styles.logo}
        resizeMode="contain"
      />

      {/* 타이틀 */}
      <Text style={styles.title}>회원가입</Text>
      <Text style={styles.subtitle}>
        예시 시작
      </Text>

      {/* 이메일 */}
      <TextInput
        style={styles.input}
        placeholder="이메일"
        value={email}
        onChangeText={setEmail}
        keyboardType="email-address"
        autoCapitalize="none"
      />

      {/* 비밀번호 */}
      <TextInput
        style={styles.input}
        placeholder="비밀번호"
        value={password}
        onChangeText={setPassword}
        secureTextEntry
      />

      {/* 회원가입 버튼 */}
      <Pressable style={styles.primaryButton} onPress={handleSignup}>
        <Text style={styles.primaryButtonText}>회원가입</Text>
      </Pressable>

      {/* 로그인 이동 */}
      <Pressable onPress={() => router.replace("/login")}>
        <Text style={styles.linkText}>이미 계정이 있어?</Text>
      </Pressable>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#FFFFFF",
    alignItems: "center",
    justifyContent: "center",
    paddingHorizontal: 24,
  },
  logo: {
    width: 90,
    height: 90,
    marginBottom: 24,
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
  input: {
    width: "100%",
    height: 48,
    borderWidth: 1,
    borderColor: "#DDD",
    borderRadius: 12,
    paddingHorizontal: 16,
    marginBottom: 12,
    fontSize: 14,
  },
  primaryButton: {
    width: "100%",
    backgroundColor: "#22C55E",
    paddingVertical: 14,
    borderRadius: 12,
    alignItems: "center",
    marginTop: 12,
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