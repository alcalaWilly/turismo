import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';

class Mapacapilla extends StatefulWidget {
  final Lugar lugar;

  const Mapacapilla({required this.lugar, Key? key}) : super(key: key);

  @override
  State<Mapacapilla> createState() => _MapacapillaState();
}

class _MapacapillaState extends State<Mapacapilla> {
  bool _isDownloading = false;
  bool _isDownloaded = false;
  double _downloadProgress = 0.0;
  late final Stream<DownloadProgress> _progressStream;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _checkIfMapDownloaded(
        widget.lugar); // Solo verifica si el mapa ya fue descargado
  }

  // Verifica si ya se ha descargado el mapa
  void _checkIfMapDownloaded(Lugar lugar) async {
    final store = FMTCStore(lugar.nombre);
    final mgmt = store.manage;

    if (!(await mgmt.ready)) {
      await mgmt.create();
    }

    bool tilesCached = await mgmt.ready;

    if (tilesCached) {
      setState(() {
        _isDownloaded = true;
      });
    } else {
      // Si no está descargado, mostrar diálogo
      Future.delayed(Duration.zero, () => _showDownloadDialog());
    }
  }

  // Muestra el diálogo para confirmar si desea descargar el mapa
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
                Navigator.of(context).pop(); // Cierra el diálogo sin descargar
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Cierra el diálogo y comienza la descarga
                _startDownloadForLugar(widget.lugar);
              },
              child: Text('Descargar'),
            ),
          ],
        );
      },
    );
  }

  // Inicia la descarga del mapa
  void _startDownloadForLugar(Lugar lugar) {
    final region = RectangleRegion(lugar.region);
    final downloadableRegion = region.toDownloadable(
      minZoom: 1,
      maxZoom: 16,
      options: TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.app',
        tileProvider: FMTCStore(lugar.nombre).getTileProvider(),
      ),
    );

    setState(() {
      _isDownloading = true;
    });

    _progressStream = FMTCStore(lugar.nombre).download.startForeground(
          region: downloadableRegion,
          skipExistingTiles: true,
          skipSeaTiles: true,
        );

    _progressStream.listen((progress) async {
      setState(() {
        _downloadProgress = progress.percentageProgress;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setDouble('downloadProgress_${lugar.nombre}', _downloadProgress);

      if (progress.percentageProgress >= 1.0) {
        setState(() {
          _isDownloading = false;
          _isDownloaded = true;
        });
        prefs.remove('downloadProgress_${lugar.nombre}');
        print('Download for ${lugar.nombre} completed!');
      }
    });
  }

  // Elimina el mapa descargado
  void _deleteDownloadedMap(Lugar lugar) async {
    final store = FMTCStore(lugar.nombre);
    await store.manage.delete();
    setState(() {
      _isDownloaded = false;
      _downloadProgress = 0.0;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('downloadProgress_${lugar.nombre}');
    print('Map data for ${lugar.nombre} deleted');
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
              onPressed: () => _deleteDownloadedMap(widget.lugar),
              tooltip: 'Eliminar mapa descargado',
            ),
        ],
      ),
      body: _isDownloading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                LinearProgressIndicator(value: _downloadProgress),
                Text(
                    'Descargando... ${(_downloadProgress * 100).toStringAsFixed(0)}%'),
              ],
            )
          : _isDownloaded
              ? FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: LatLng(
                      (widget.lugar.region.southWest.latitude +
                              widget.lugar.region.northEast.latitude) /
                          2,
                      (widget.lugar.region.southWest.longitude +
                              widget.lugar.region.northEast.longitude) /
                          2,
                    ),
                    initialZoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                      tileProvider:
                          FMTCStore(widget.lugar.nombre).getTileProvider(),
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: widget.lugar.polyline,
                          color: Colors.blue,
                          strokeWidth: 4.0,
                        ),
                      ],
                    ),
                  ],
                )
              : Center(
                  child: ElevatedButton(
                    onPressed: () => _startDownloadForLugar(widget.lugar),
                    child: Text('Descargar mapa'),
                  ),
                ),
    );
  }
}
