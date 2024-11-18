import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';

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
    // Mostrar el mapa
    _showMapForLugar(lugar);
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

  final progressStream = FMTCStore(lugar.nombre).download.startForeground(
        region: downloadableRegion,
        skipExistingTiles: true,
        skipSeaTiles: true,
      );

  progressStream.listen((progress) {
    if (progress.percentageProgress >= 1.0) {
      print('Download for ${lugar.nombre} completed!');
      _showMapForLugar(
          lugar); // Mostrar el mapa una vez que se complete la descarga
    }
  });
}

void _showMapForLugar(Lugar lugar) {
  // Aquí navegas a la pantalla que muestra el mapa para ese lugar
}
