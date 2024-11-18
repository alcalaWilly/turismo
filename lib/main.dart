import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:objectbox/objectbox.dart';
import 'package:turismo/src/pages/login/entities/objectbox.dart';
import 'package:turismo/src/routes/routes.dart';

late Store store;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa ObjectBox y obtiene la instancia de Store
  final objectBox = await ObjectBox.getStore();
  store = objectBox;
  // Inicializa FMTC para manejo de mapas
  await FMTCObjectBoxBackend().initialise();
  await FMTCStore('mapStore').manage.create();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turismo',
      initialRoute: 'Login',
      routes: rutas,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
    );
  }
}
