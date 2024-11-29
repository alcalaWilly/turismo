import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turismo/src/pages/home/modules/mapas/descargarMapa.dart';
import 'package:turismo/src/pages/home/modules/mapas/ubicacion.dart';

class Mapatsomontonari extends StatefulWidget {
  final Lugar lugar;

  const Mapatsomontonari({required this.lugar, Key? key}) : super(key: key);

  @override
  State<Mapatsomontonari> createState() => _MapatsomontonariState();
}

class _MapatsomontonariState extends State<Mapatsomontonari> {
  bool _isDownloading = false;
  bool _isDownloaded = false;
  bool _isFetchingLocation = false; // Nuevo estado para buscar ubicación
  double _downloadProgress = 0.0;
  LatLng? _currentLocation;
  Marker? _currentLocationMarker;

  final MapController _mapController = MapController();
  late MapDownloadManager _mapDownloadManager;
  late LocationService _locationService;

  @override
  void initState() {
    super.initState();
    _mapDownloadManager = MapDownloadManager(widget.lugar);
    _locationService = LocationService();
    _checkIfMapDownloaded();
  }

  void _checkIfMapDownloaded() async {
    bool isDownloaded = await _mapDownloadManager.isMapDownloaded();
    setState(() {
      _isDownloaded = isDownloaded;
    });

    if (!isDownloaded) {
      Future.delayed(Duration.zero, _showDownloadDialog);
    }
  }

  void _startDownload() {
    setState(() {
      _isDownloading = true;
    });

    final progressStream = _mapDownloadManager.startMapDownload();
    progressStream.listen((progress) {
      setState(() {
        _downloadProgress = progress.percentageProgress;
      });

      if (progress.percentageProgress >= 1.0) {
        setState(() {
          _isDownloading = false;
          _isDownloaded = true;
        });
      }
    });
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isFetchingLocation = true; // Mostrar diálogo de cargando
    });

    try {
      final location = await _locationService.getCurrentLocation();
      if (location != null) {
        setState(() {
          _currentLocation = location;
          _currentLocationMarker = Marker(
            width: 80.0,
            height: 80.0,
            point: _currentLocation!,
            child: Icon(Icons.person_pin_circle, color: Colors.blue, size: 40),
          );
        });
        _mapController.move(_currentLocation!, 15.0);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo obtener la ubicación: $e')),
      );
    } finally {
      setState(() {
        _isFetchingLocation = false; // Ocultar diálogo de cargando
      });
    }
  }

  void _showDownloadDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Descargar Mapa'),
          content: Text('¿Deseas descargar el mapa de ${widget.lugar.nombre}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _startDownload();
              },
              child: Text('Descargar'),
            ),
          ],
        );
      },
    );
  }

  void _deleteDownloadedMap() async {
    await _mapDownloadManager.deleteDownloadedMap();
    setState(() {
      _isDownloaded = false;
      _downloadProgress = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lugar.nombre),
        actions: [
          if (_isDownloaded)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _deleteDownloadedMap,
              tooltip: 'Eliminar mapa descargado',
            ),
        ],
      ),
      body: Stack(
        children: [
          if (_isDownloading)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                LinearProgressIndicator(value: _downloadProgress),
                Text(
                    'Descargando... ${(_downloadProgress * 100).toStringAsFixed(0)}%'),
              ],
            )
          else if (_isDownloaded)
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: LatLng(-11.20857695048312, -74.66021205752597),
                initialZoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                  tileProvider:
                      FMTCStore(widget.lugar.nombre).getTileProvider(),
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: widget.lugar.polyline,
                      color: Colors.blue,
                      strokeWidth: 7.0,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(-11.20857695048312, -74.66021205752597),
                      child: Column(
                        children: [
                          Icon(Icons.location_pin, color: Colors.red),
                          Text('Rio Negro'),
                        ],
                      ),
                    ),
                    if (_currentLocationMarker != null) _currentLocationMarker!,
                  ],
                ),
              ],
            ),
          Positioned(
            bottom: 50,
            right: 10,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              child: Icon(Icons.my_location),
              backgroundColor: Colors.blue,
              tooltip: 'Mi Ubicación',
            ),
          ),
          if (_isFetchingLocation)
            Center(
              child: AlertDialog(
                content: Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 15),
                    Text('Buscando su ubicación...'),
                  ],
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '© OpenStreetMap contributors',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
