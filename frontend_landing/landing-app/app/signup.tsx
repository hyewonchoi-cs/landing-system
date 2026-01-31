import { View, Text, StyleSheet, TouchableOpacity } from "react-native";

export default function SignupPage() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>회원가입</Text>
      <Text style={styles.desc}>
        간단한 정보 입력 후 시작할 수 있어요
      </Text>

      <TouchableOpacity style={styles.button}>
        <Text style={styles.buttonText}>이메일로 회원가입</Text>
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
  title: {
    fontSize: 24,
    fontWeight: "700",
    marginBottom: 12,
  },
  desc: {
    fontSize: 14,
    color: "#666",
    marginBottom: 32,
  },
  button: {
    width: "100%",
    height: 52,
    borderRadius: 26,
    backgroundColor: "#1DB954",
    justifyContent: "center",
    alignItems: "center",
  },
  buttonText: {
    color: "#FFF",
    fontSize: 16,
    fontWeight: "600",
  },
});