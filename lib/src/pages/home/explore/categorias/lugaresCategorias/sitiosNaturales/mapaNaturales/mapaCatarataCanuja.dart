import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';
import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';

class Mapacataratacanuja extends StatefulWidget {
  final Lugar lugar; // Recibe el lugar seleccionado

  const Mapacataratacanuja({required this.lugar, Key? key}) : super(key: key);

  @override
  State<Mapacataratacanuja> createState() => _MapacataratacanujaState();
}

class _MapacataratacanujaState extends State<Mapacataratacanuja> {
  bool _isDownloading = false;
  bool _isDownloaded = false;
  late final Stream<DownloadProgress> _progressStream;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _checkAndDownloadMap(widget.lugar);
  }

  void _checkAndDownloadMap(Lugar lugar) async {
    final store = FMTCStore(
        lugar.nombre); // Usar el nombre del lugar como identificador único
    final mgmt = store.manage;

    if (!(await mgmt.ready)) {
      await mgmt.create();
    }

    bool tilesCached = await mgmt.ready;

    if (!tilesCached) {
      _startDownloadForLugar(lugar);
    } else {
      setState(() {
        _isDownloaded = true;
      });
    }
  }

  void _startDownloadForLugar(Lugar lugar) {
    final region = RectangleRegion(lugar.region);
    final downloadableRegion = region.toDownloadable(
      minZoom: 1,
      maxZoom: 18,
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

    _progressStream.listen((progress) {
      print(
          'Download Progress for ${lugar.nombre}: ${progress.percentageProgress * 100}%');
      if (progress.percentageProgress >= 1.0) {
        setState(() {
          _isDownloading = false;
          _isDownloaded = true;
        });
        print('Download for ${lugar.nombre} completed!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lugar.nombre),
      ),
      body: _isDownloading
          ? Center(child: CircularProgressIndicator())
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
