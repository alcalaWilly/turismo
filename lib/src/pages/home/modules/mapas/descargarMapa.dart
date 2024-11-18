import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';

class MapDownloadManager {
  final Lugar lugar;

  MapDownloadManager(this.lugar);

  // Verificar si el mapa está descargado
  Future<bool> isMapDownloaded() async {
    final store = FMTCStore(lugar.nombre);
    final mgmt = store.manage;

    if (!(await mgmt.ready)) {
      await mgmt.create();
    }
    return mgmt.ready;
  }

  // Iniciar la descarga del mapa para una región específica
  Stream<DownloadProgress> startMapDownload() {
    // Define la región usando LatLngBounds
    final region = RectangleRegion(lugar.region);
    final downloadableRegion = region.toDownloadable(
      minZoom: 10, // Vista moderada para la región
      maxZoom: 16, // Detalles precisos dentro de la región
      options: TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.app', // Cambia según tu paquete
        tileProvider: FMTCStore(lugar.nombre).getTileProvider(),
      ),
    );

    // Inicia la descarga
    return FMTCStore(lugar.nombre).download.startForeground(
          region: downloadableRegion,
          skipExistingTiles: true,
          skipSeaTiles: true,
        );
  }

  // Método para eliminar el mapa descargado
  Future<void> deleteDownloadedMap() async {
    final store = FMTCStore(lugar.nombre);
    await store.manage.delete();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('downloadProgress_${lugar.nombre}');
  }
}
