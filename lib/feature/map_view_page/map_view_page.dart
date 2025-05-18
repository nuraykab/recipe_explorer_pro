import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapViewPage extends StatefulWidget {
  const MapViewPage({super.key});

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  final MapController _mapController = MapController();
  final List<Marker> _markers = [];
  LatLng _center = LatLng(51.0909470, 71.4180072); // AITU

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _loadStaticMarkers();
  }

  /// Получение текущей геолокации пользователя
  Future<void> _getUserLocation() async {
    final location = Location();
    final hasPermission = await location.requestPermission();
    if (hasPermission == PermissionStatus.granted) {
      final loc = await location.getLocation();
      setState(() {
        _center = LatLng(loc.latitude!, loc.longitude!);
        _markers.add(
          Marker(
            point: _center,
            child: Column(
              children: const [
                Text("Вы здесь", style: TextStyle(fontSize: 12, color: Colors.black)),
                Icon(Icons.person_pin_circle, color: Colors.red, size: 40),
              ],
            ),
          ),
        );
      });
      _mapController.move(_center, 15);
    }
  }

  /// Предустановленные маркеры (например, рестораны или кафе)
  void _loadStaticMarkers() {
    final List<Map<String, dynamic>> places = [
      {
        'title': 'Dastarkhan Cafe',
        'point': LatLng(51.0915, 71.4172),
        'icon': Icons.restaurant,
        'color': Colors.green,
      },
      {
        'title': 'Nauryz Market',
        'point': LatLng(51.0889, 71.4210),
        'icon': Icons.store,
        'color': Colors.orange,
      },
    ];

    for (var place in places) {
      _markers.add(
        Marker(
          point: place['point'],
          child: Column(
            children: [
              Text(
                place['title'],
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
              Icon(
                place['icon'],
                color: place['color'],
                size: 36,
              ),
            ],
          ),
        ),
      );
    }
  }

  /// Добавление маркера по нажатию
  void _addMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          point: point,
          child: Column(
            children: const [
              Text("Пользовательская точка", style: TextStyle(fontSize: 12, color: Colors.black)),
              Icon(Icons.location_on, color: Colors.blue, size: 36),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _getUserLocation,
          ),
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: _center,
          zoom: 12,
          onTap: (tapPosition, point) => _addMarker(point),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.recipe_explorer_pro',
          ),
          MarkerLayer(markers: _markers),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getUserLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
