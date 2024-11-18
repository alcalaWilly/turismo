// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';
// import 'package:turismo/src/pages/login/entities/objectbox.dart';
// import 'package:turismo/src/sincronizacion/mongo_service.dart';

// Future<void> checkAndSyncData() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   // Verificar si ya se ha sincronizado antes
//   bool isDataSynced = prefs.getBool('dataSynced') ?? false;

//   if (!isDataSynced) {
//     await syncCategoriasToObjectBox();

//     // Marcar la sincronización como completada
//     await prefs.setBool('dataSynced', true);
//   }
// }

// Future<void> syncCategoriasToObjectBox() async {
//   // Recuperar las categorías desde MongoDB
//   final categoriasData = await MongoDBService.getCategorias();
//   final boxCategorias = ObjectBox.store.box<Categorias>();

//   // Limpiar datos antiguos de ObjectBox
//   boxCategorias.removeAll();

//   // Insertar nuevos datos desde MongoDB a ObjectBox
//   for (var categoria in categoriasData) {
//     boxCategorias.put(categoria);
//   }

//   print("Sincronización con MongoDB completada.");
// }
