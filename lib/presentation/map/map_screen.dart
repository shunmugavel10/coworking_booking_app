import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/widgets/app_scaffold.dart';
import '../providers/branch_providers.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  LatLng? userLocation;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check service
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    // Get location
    final pos = await Geolocator.getCurrentPosition();
    setState(() {
      userLocation = LatLng(pos.latitude, pos.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(branchesProvider);

    return AppScaffold(
      title: 'Map',
      currentIndex: 1,
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(e.toString())),
        data: (list) {
          final center = userLocation ?? LatLng(list.first.lat, list.first.lng);
          return FlutterMap(
            options: MapOptions(initialCenter: center, initialZoom: 13),
            children: [
              TileLayer(
                urlTemplate: 'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=YOUR_API_KEY',
                userAgentPackageName: 'com.example.coworking_booking_app',
              ),
              if (userLocation != null)
                MarkerLayer(markers: [
                  Marker(
                    point: userLocation!,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.my_location, color: Colors.blue, size: 36),
                  )
                ]),
              MarkerLayer(markers: [
                for (final b in list)
                  Marker(
                    width: 40,
                    height: 40,
                    point: LatLng(b.lat, b.lng),
                    child: GestureDetector(
                      onTap: () => context.go('/details?id=${b.id}'),
                      child: const Icon(Icons.location_on, size: 36, color: Colors.red),
                    ),
                  )
              ])
            ],
          );
        },
      ),
    );
  }
}
