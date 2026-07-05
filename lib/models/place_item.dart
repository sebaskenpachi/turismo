class PlaceItem {
  final String id;
  final String name;
  final String category;
  final String description;
  final double latitude;
  final double longitude;
  final double rating;
  final String priceLevel;
  final bool sponsored;

  const PlaceItem({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.priceLevel,
    this.sponsored = false,
  });
}
