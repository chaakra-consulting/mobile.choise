String getUtcOffset() {
  Duration offset = DateTime.now().timeZoneOffset;

  // Get the absolute hours and minutes
  int hours = offset.inHours;

  // Format the sign (e.g., + or -)
  String sign = hours >= 0 ? "+" : "-";

  // Return the formatted string
  return "UTC$sign${hours.abs()}";
}
