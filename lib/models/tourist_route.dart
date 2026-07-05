class TouristRoute {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final int estimatedMinutes;
  final List<String> tags;

  const TouristRoute({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.estimatedMinutes,
    required this.tags,
  });
}
