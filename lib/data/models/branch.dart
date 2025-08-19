class Branch {
  final String id;
  final String name;
  final String city;
  final String branch;
  final int pricePerHour;
  final double lat;
  final double lng;
  final List<String> images;
  final String description;
  final List<String> amenities;
  final String hours;

  Branch({
    required this.id,
    required this.name,
    required this.city,
    required this.branch,
    required this.pricePerHour,
    required this.lat,
    required this.lng,
    required this.images,
    required this.description,
    required this.amenities,
    required this.hours,
  });

  factory Branch.fromJson(Map<String, dynamic> j) => Branch(
    id: j['id'],
    name: j['name'],
    city: j['city'],
    branch: j['branch'],
    pricePerHour: j['pricePerHour'],
    lat: (j['lat'] as num).toDouble(),
    lng: (j['lng'] as num).toDouble(),
    images: (j['images'] as List).cast<String>(),
    description: j['description'],
    amenities: (j['amenities'] as List).cast<String>(),
    hours: j['hours'],
  );
}
