class BusRoute {
  final String busStandName;
  final String routeName;
  final String from;
  final String via;
  final String to;
  final String departureTime;

  BusRoute({
    required this.busStandName,
    required this.routeName,
    required this.from,
    required this.via,
    required this.to,
    required this.departureTime,
  });

  factory BusRoute.fromJson(Map<String, dynamic> json) {
    return BusRoute(
      busStandName: json['Bus_Stand_Name'] as String? ?? "Unknown Stand",
      routeName: json['Route_Name'] as String? ?? "Unknown Route",
      from: json['From'] as String? ?? "Unknown",
      via: json['Via'] as String? ?? "Unknown",
      to: json['To'] as String? ?? "Unknown",
      departureTime: (json['Departure_Time'] != null)
          ? json['Departure_Time'].toString() // Convert double to String if needed
          : "00:00", // Default time if missing
    );
  }
}
