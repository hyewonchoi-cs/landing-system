import { View, Text, StyleSheet } from "react-native";

export default function ServerErrorPage() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>서버 오류가 발생했어요</Text>
      <Text style={styles.desc}>잠시 후 다시 시도해주세요</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  title: {
    fontSize: 18,
    fontWeight: "600",
  },
  desc: {
    color: "#666",
    marginTop: 8,
  },
});