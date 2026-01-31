import { View, Text, StyleSheet } from "react-native";

export default function NetworkErrorPage() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>네트워크 연결이 불안정해요</Text>
      <Text style={styles.desc}>인터넷 상태를 확인해주세요</Text>
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