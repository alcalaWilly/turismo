// import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';
// import 'package:turismo/src/pages/home/visitas/datoVistas/visitasDB.dart';
// import 'package:turismo/src/pages/login/entities/objectbox.dart';
// import 'package:turismo/src/pages/login/objectbox.g.dart';
// import 'package:turismo/src/sincronizacion/mongo_service.dart';

// void registrarVisita(String nombreLugar) async {
//   final store = await ObjectBox.getStore();
//   final visitaBox = store.box<Visita>();

//   // Buscar visitas por nombre del lugar en ObjectBox
//   final visitasExistentes =
//       visitaBox.query(Visita_.nombreLugar.equals(nombreLugar)).build().find();

//   if (visitasExistentes.isEmpty) {
//     final nuevaVisita = Visita(
//       nombreLugar: nombreLugar,
//       fechaVisita: DateTime.now(),
//       syncPending: true, // Marca como pendiente de sincronización
//     );

//     // Guardar la visita en ObjectBox
//     visitaBox.put(nuevaVisita);

//     // Sincronizar con MongoDB después de guardar
//     sincronizarConMongo();
//   } else {
//     print('Visita ya registrada en ObjectBox.');
//   }
// }

// // void sincronizarConMongo() async {
// //   final store = await ObjectBox.getStore();
// //   final visitaBox = store.box<Visita>();

// //   // Buscar las visitas pendientes de sincronización (sin mongoId)
// //   final visitasPendientes = visitaBox
// //       .query(Visita_.syncPending.equals(true).and(Visita_.mongoId.isNull()))
// //       .build()
// //       .find();

// //   for (var visita in visitasPendientes) {
// //     // Convertir la visita a JSON
// //     final visitaJson = visita.toJson();

// //     // Verificar si la visita ya existe en MongoDB por nombre y fecha
// //     final existeEnMongo = await MongoDBService.visitaExisteEnMongo(visitaJson);

// //     if (!existeEnMongo) {
// //       // Insertar la visita en MongoDB y obtener el _id generado
// //       final mongoId = await MongoDBService.insertVisita(visitaJson);

// //       if (mongoId != null) {
// //         // Si MongoDB devuelve un _id, actualizamos la visita en ObjectBox
// //         visita.syncPending = false; // Ya no está pendiente de sincronización
// //         visita.mongoId = mongoId; // Almacena el _id de MongoDB

// //         // Actualizar la visita en ObjectBox con el _id de MongoDB
// //         visitaBox.put(visita);
// //       }
// //     } else {
// //       print('Visita ya existe en MongoDB, no se sincronizará nuevamente.');
// //       // Puedes considerar marcar la visita como sincronizada
// //       // para que no vuelva a intentarse sincronizar en cada carga
// //       visita.syncPending = false;
// //       visitaBox.put(visita);
// //     }
// //   }
// // }

// // Función para registrar la visita en ObjectBox
// // Future<void> RegisterVisit(Lugar lugar) async {
// //   final store = await ObjectBox.getStore();
// //   final visitaBox = store.box<Visita>();

// //   // Verificar si la visita ya fue registrada en ObjectBox
// //   final visitasExistentes =
// //       visitaBox.query(Visita_.nombreLugar.equals(lugar.nombre)).build().find();

// //   if (visitasExistentes.isEmpty) {
// //     // Registrar la visita en ObjectBox si no existe
// //     final nuevaVisita = Visita(
// //       nombreLugar: lugar.nombre,
// //       fechaVisita: DateTime.now(),
// //       syncPending: true, // Pendiente de sincronización con MongoDB
// //     );

// //     // Guardar la visita en ObjectBox
// //     visitaBox.put(nuevaVisita);

// //     // Llamar a la función de sincronización con MongoDB
// //     await sincronizarConMongo();
// //   } else {
// //     print('Visita ya registrada en ObjectBox para este lugar.');
// //   }
// // }

// // Función para sincronizar las visitas con MongoDB
// void sincronizarConMongo() async {
//   final store = await ObjectBox.getStore();
//   final visitaBox = store.box<Visita>();

//   // Buscar las visitas que ya están sincronizadas (syncPending: false)
//   final visitasSincronizadas =
//       visitaBox.query(Visita_.syncPending.equals(false)).build().find();

//   for (var visita in visitasSincronizadas) {
//     // Convertir la visita a JSON
//     final visitaJson = visita.toJson();

//     // Verificar si la visita ya existe en MongoDB
//     final existeEnMongo = await MongoDBService.visitaExisteEnMongo(visitaJson);

//     if (!existeEnMongo) {
//       // Insertar la visita en MongoDB
//       await MongoDBService.insertVisita(visitaJson);
//       print("Visita sincronizada con MongoDB.");
//     } else {
//       print('Visita ya existe en MongoDB, no se sincronizará nuevamente.');
//     }
//   }
// }

// Función para registrar la visita en ObjectBox
import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';
import 'package:turismo/src/pages/home/visitas/datoVistas/visitasDB.dart';
import 'package:turismo/src/pages/login/entities/objectbox.dart';
import 'package:turismo/src/pages/login/objectbox.g.dart';
import 'package:turismo/src/sincronizacion/mongo_service.dart';

Future<void> registerVisit(Lugar lugar) async {
  final store = await ObjectBox.getStore();
  final visitaBox = store.box<Visita>();

  // Registrar la visita en ObjectBox sin verificar visitas previas
  final nuevaVisita = Visita(
    nombreLugar: lugar.nombre,
    fechaVisita: DateTime.now(),
    syncPending: true, // Pendiente de sincronización con MongoDB
  );

  // Guardar la visita en ObjectBox
  visitaBox.put(nuevaVisita);

  // Llamar a la función de sincronización con MongoDB
  await sincronizarConMongo();
}

// Función para sincronizar las visitas con MongoDB
Future<void> sincronizarConMongo() async {
  final store = await ObjectBox.getStore();
  final visitaBox = store.box<Visita>();

  // Buscar las visitas pendientes de sincronización
  final visitasPendientes =
      visitaBox.query(Visita_.syncPending.equals(true)).build().find();

  for (var visita in visitasPendientes) {
    final visitaJson = visita.toJson();

    // Verificar si la visita ya existe en MongoDB
    final existeEnMongo = await MongoDBService.visitaExisteEnMongo(visitaJson);

    if (!existeEnMongo) {
      // Insertar la visita en MongoDB y obtener el _id generado
      final mongoId = await MongoDBService.insertVisita(visitaJson);

      if (mongoId != null) {
        // Marcar la visita como sincronizada y guardar el _id de MongoDB
        visita.syncPending = false;
        visita.mongoId = mongoId;

        // Actualizar la visita en ObjectBox
        visitaBox.put(visita);
      }
    } else {
      print('Visita ya existe en MongoDB.');
    }
  }
}
