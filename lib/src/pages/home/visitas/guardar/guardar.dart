// import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';
// import 'package:turismo/src/pages/home/visitas/datoVistas/visitasDB.dart';
// import 'package:turismo/src/pages/login/entities/objectbox.dart';
// import 'package:turismo/src/pages/login/objectbox.g.dart';
// import 'package:turismo/src/sincronizacion/mongo_service.dart';

// Future<void> registerVisit(Lugar lugar) async {
//   final store = await ObjectBox.getStore();
//   final visitaBox = store.box<Visita>();

//   // Registrar la visita en ObjectBox sin verificar visitas previas
//   final nuevaVisita = Visita(
//     nombreLugar: lugar.nombre,
//     fechaVisita: DateTime.now(),
//     syncPending: true, // Pendiente de sincronización con MongoDB
//   );

//   // Guardar la visita en ObjectBox
//   visitaBox.put(nuevaVisita);

//   // Llamar a la función de sincronización con MongoDB
//   await sincronizarConMongo();
// }

// Future<void> sincronizarConMongo() async {
//   final store = await ObjectBox.getStore();
//   final visitaBox = store.box<Visita>();

//   // Buscar visitas pendientes de sincronización
//   final visitasPendientes =
//       visitaBox.query(Visita_.syncPending.equals(true)).build().find();

//   if (visitasPendientes.isEmpty) {
//     print('No hay visitas pendientes de sincronizar.');
//     return;
//   }

//   try {
//     for (var visita in visitasPendientes) {
//       final visitaJson = visita.toJson();

//       // Verificar si la visita ya existe en MongoDB
//       final existeEnMongo =
//           await MongoDBService.visitaExisteEnMongo(visitaJson);

//       if (!existeEnMongo) {
//         final mongoId = await MongoDBService.insertVisita(visitaJson);

//         if (mongoId != null) {
//           visita.syncPending = false;
//           visita.mongoId = mongoId;

//           // Actualizar la visita dentro de una transacción
//           store.runInTransaction(TxMode.write, () {
//             visitaBox.put(visita);
//           });
//         }
//       } else {
//         print('La visita ya existe en MongoDB: ${visita.nombreLugar}');
//       }
//     }
//   } catch (e) {
//     print('Error durante la sincronización: $e');
//     // Implementar reintentos o manejo adicional si es necesario
//   }
// }

// // Función para sincronizar las visitas con MongoDB
// // Future<void> sincronizarConMongo() async {
// //   final store = await ObjectBox.getStore();
// //   final visitaBox = store.box<Visita>();

// //   // Buscar las visitas pendientes de sincronización
// //   final visitasPendientes =
// //       visitaBox.query(Visita_.syncPending.equals(true)).build().find();

// //   for (var visita in visitasPendientes) {
// //     final visitaJson = visita.toJson();

// //     // Verificar si la visita ya existe en MongoDB
// //     final existeEnMongo = await MongoDBService.visitaExisteEnMongo(visitaJson);

// //     if (!existeEnMongo) {
// //       // Insertar la visita en MongoDB y obtener el _id generado
// //       final mongoId = await MongoDBService.insertVisita(visitaJson);

// //       if (mongoId != null) {
// //         // Marcar la visita como sincronizada y guardar el _id de MongoDB
// //         visita.syncPending = false;
// //         visita.mongoId = mongoId;

// //         // Actualizar la visita en ObjectBox
// //         visitaBox.put(visita);
// //       }
// //     } else {
// //       print('Visita ya existe en MongoDB.');
// //     }
// //   }
// //}

import 'package:objectbox/objectbox.dart';
import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';
import 'package:turismo/src/pages/home/visitas/datoVistas/visitasDB.dart';
import 'package:turismo/src/pages/login/entities/objectbox.dart';
import 'package:turismo/src/pages/login/objectbox.g.dart';
import 'package:turismo/src/sincronizacion/mongo_service.dart';

class ObjectBoxService {
  static Future<Box<Visita>> getVisitaBox() async {
    final store = await ObjectBox.getStore();
    return store.box<Visita>();
  }

  static Future<void> guardarVisita(Visita visita) async {
    final visitaBox = await getVisitaBox();
    visitaBox.put(visita);
  }

  static Future<List<Visita>> obtenerVisitasPendientes() async {
    final visitaBox = await getVisitaBox();
    return visitaBox.query(Visita_.syncPending.equals(true)).build().find();
  }

  static Future<void> actualizarVisita(Visita visita) async {
    final visitaBox = await getVisitaBox();
    visitaBox.put(visita);
  }
}

class MongoService {
  static Future<bool> visitaExisteEnMongo(
      Map<String, dynamic> visitaJson) async {
    return await MongoDBService.visitaExisteEnMongo(visitaJson);
  }

  static Future<String?> insertarVisitaEnMongo(
      Map<String, dynamic> visitaJson) async {
    return await MongoDBService.insertVisita(visitaJson);
  }
}

class VisitaRepository {
  static Future<void> sincronizarVisitasConMongo() async {
    final visitasPendientes = await ObjectBoxService.obtenerVisitasPendientes();

    if (visitasPendientes.isEmpty) {
      print('No hay visitas pendientes de sincronizar.');
      return;
    }

    try {
      for (var visita in visitasPendientes) {
        final visitaJson = visita.toJson();

        // Verificar si la visita ya existe en MongoDB
        final existeEnMongo =
            await MongoService.visitaExisteEnMongo(visitaJson);

        if (!existeEnMongo) {
          final mongoId = await MongoService.insertarVisitaEnMongo(visitaJson);

          if (mongoId != null) {
            visita.syncPending = false;
            visita.mongoId = mongoId;

            // Actualizar en ObjectBox
            await ObjectBoxService.actualizarVisita(visita);
          }
        } else {
          print('La visita ya existe en MongoDB: ${visita.nombreLugar}');
        }
      }
    } catch (e) {
      print('Error durante la sincronización: $e');
    }
  }
}

Future<void> registerVisit(Lugar lugar) async {
  final nuevaVisita = Visita(
    nombreLugar: lugar.nombre,
    fechaVisita: DateTime.now(),
    syncPending: true, // Pendiente de sincronización
  );

  // Guardar la visita en ObjectBox
  await ObjectBoxService.guardarVisita(nuevaVisita);

  // Sincronizar con MongoDB
  await VisitaRepository.sincronizarVisitasConMongo();
}
