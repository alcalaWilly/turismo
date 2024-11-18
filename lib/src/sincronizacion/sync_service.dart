import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';
import 'package:turismo/src/pages/home/visitas/datoVistas/visitasDB.dart';
import 'package:turismo/src/pages/login/entities/objectbox.dart';
import 'package:turismo/src/pages/login/entities/person.dart';
import 'package:turismo/src/pages/login/objectbox.g.dart';
import 'package:turismo/src/sincronizacion/mongo_service.dart';

/// Servicio de Sincronización
class SyncService {
  final Store store;

  SyncService({required this.store});

  /// Método principal para sincronizar con MongoDB
  Future<void> syncWithMongoDB() async {
    await MongoDBService.connect();

    // Obtener los datos de ObjectBox pendientes de sincronización
    List<Person> personasPendientes = obtenerPersonasPendientesDeSync();

    // Sincronizar personas pendientes
    for (var persona in personasPendientes) {
      await sincronizarPersona(persona);
    }

    print("Sincronización completada");
  }

  List<Person> obtenerPersonasPendientesDeSync() {
    final personBox = store.box<Person>();
    return personBox
        .query(Person_.syncPending.equals(true))
        .build()
        .find(); // Retorna solo las personas pendientes
  }

  /// Sincronizar cada persona verificando si ya existe en MongoDB
  Future<void> sincronizarPersona(Person persona) async {
    if (persona.mongoId != null) {
      // Verificar si la persona ya existe en MongoDB
      bool existeEnMongo =
          await MongoDBService.personaExisteEnMongo(persona.mongoId!);

      if (existeEnMongo) {
        await MongoDBService.updatePerson(persona.toJson());
      } else {
        var insertedPerson =
            await MongoDBService.insertPersona(persona.toJson());

        if (insertedPerson != null && insertedPerson.containsKey('_id')) {
          persona.mongoId = insertedPerson['_id'].toString();
        }
      }
    } else {
      var insertedPerson = await MongoDBService.insertPersona(persona.toJson());

      if (insertedPerson != null && insertedPerson.containsKey('_id')) {
        persona.mongoId = insertedPerson['_id'].toString();
      }
    }

    // Marcar como sincronizado en ObjectBox
    persona.syncPending = false;
    store.box<Person>().put(persona); // Guardar el cambio en ObjectBox
  }

  /// Obtener todas las personas desde ObjectBox
  List<Person> obtenerPersonasDeObjectBox() {
    final personBox = store.box<Person>();
    return personBox.getAll(); // Retorna todas las personas de la base de datos
  }

  /// Obtener todas las visitas desde ObjectBox
  List<Visita> obtenerVisitasDeObjectBox() {
    final visitaBox = store.box<Visita>();
    return visitaBox.getAll(); // Retorna todas las visitas de la base de datos
  }

  // Función para sincronizar categorías desde MongoDB a ObjectBox
  // Future<void> syncCategoriasToObjectBox() async {
  //   final categoriasData = await getCategorias();
  //   final boxCategorias = ObjectBox.store.box<Categorias>();

  //   // Almacenar cada categoría en ObjectBox
  //   boxCategorias.removeAll(); // Limpia datos antiguos en ObjectBox
  //   for (var categoria in categoriasData) {
  //     boxCategorias.put(categoria);
  //   }
  //   print("Sincronización con MongoDB completada.");
  // }
}
