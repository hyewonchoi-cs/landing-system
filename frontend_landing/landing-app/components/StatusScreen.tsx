import { View, Text, StyleSheet, ActivityIndicator, Pressable } from "react-native";

type Props = {
  title: string;
  description?: string;
  loading?: boolean;
  buttonText?: string;
  onPress?: () => void;
};

export default function StatusScreen({
  title,
  description,
  loading = false,
  buttonText,
  onPress,
}: Props) {
  return (
    <View style={styles.container}>
      {loading && <ActivityIndicator size="large" color="#22C55E" />}
      <Text style={styles.title}>{title}</Text>
      {description && <Text style={styles.desc}>{description}</Text>}

      {buttonText && onPress && (
        <Pressable style={styles.button} onPress={onPress}>
          <Text style={styles.buttonText}>{buttonText}</Text>
        </Pressable>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#FFFFFF",
    alignItems: "center",
    justifyContent: "center",
    padding: 24,
  },
  title: {
    marginTop: 16,
    fontSize: 18,
    fontWeight: "600",
    color: "#111827",
    textAlign: "center",
  },
  desc: {
    marginTop: 8,
    fontSize: 14,
    color: "#6B7280",
    textAlign: "center",
    lineHeight: 20,
  },
  button: {
    marginTop: 24,
    backgroundColor: "#22C55E",
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 999,
  },
  buttonText: {
    color: "#FFFFFF",
    fontSize: 14,
    fontWeight: "600",
  },
});