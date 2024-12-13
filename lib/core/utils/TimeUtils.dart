
class TimeUtils {
  static String otpTime(int timeLeft) {
    final minutes = timeLeft ~/ 60;
    final seconds = timeLeft % 60;
    return "${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  static DateTime? fromIso8601String(String? date) =>
      date == null ? null : DateTime.parse(date);

  static String? toIso8601String(DateTime? date) => date?.toIso8601String();

}