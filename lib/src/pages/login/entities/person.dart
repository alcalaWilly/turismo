import 'package:objectbox/objectbox.dart';

@Entity()
class Person {
  @Id(assignable: false)
  int id; // Este es el ID de ObjectBox
  String? mongoId; // ID de MongoDB
  String dni;
  String pasaporte;
  String celular;
  String usuario;
  String password;
  List<String>? lugarVista; // Permitir null
  List<String>? motivos; // Permitir null
  DateTime updatedAt;
  bool syncPending; // Campo que indica si está pendiente de sincronización

  // Constructor
  Person({
    this.id = 0, // Asignable, por defecto 0
    this.mongoId, // El ID de MongoDB será opcional al inicio
    required this.dni,
    required this.pasaporte,
    required this.celular,
    required this.usuario,
    required this.password,
    this.lugarVista, // Permitir que sea null
    this.motivos, // Permitir que sea null
    required this.updatedAt,
    this.syncPending = true, // Por defecto, pendiente de sincronización
  });

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id, // ID de ObjectBox
      'mongoId': mongoId, // ID de MongoDB
      'dni': dni,
      'pasaporte': pasaporte,
      'celular': celular,
      'usuario': usuario,
      'password': password,
      'lugarVista':
          lugarVista ?? [], // Convertir null a lista vacía para evitar errores
      'motivos':
          motivos ?? [], // Convertir null a lista vacía para evitar errores
      'updatedAt': updatedAt.toIso8601String(),
      'syncPending': syncPending, // Incluir campo syncPending en JSON
    };
  }

  // Método para crear un objeto Person desde JSON
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] ?? 0,
      mongoId: json['mongoId'], // ID de MongoDB
      dni: json['dni'] ?? '',
      pasaporte: json['pasaporte'] ?? '',
      celular: json['celular'] ?? '',
      usuario: json['usuario'] ?? '',
      password: json['password'] ?? '',
      lugarVista: json['lugarVista'] != null
          ? List<String>.from(json['lugarVista'])
          : null, // Manejar caso null
      motivos: json['motivos'] != null
          ? List<String>.from(json['motivos'])
          : null, // Manejar caso null
      updatedAt: DateTime.parse(json['updatedAt']),
      syncPending: json['syncPending'] ?? true,
    );
  }

  static Person createNewPerson({
    required String dni,
    required String pasaporte,
    required String celular,
    required String usuario,
    required String password,
    List<String>? lugarVista,
    List<String>? motivos,
  }) {
    return Person(
      dni: dni,
      pasaporte: pasaporte,
      celular: celular,
      usuario: usuario,
      password: password,
      lugarVista: lugarVista, // Permitir null en lugar de lista vacía
      motivos: motivos, // Permitir null en lugar de lista vacía
      updatedAt: DateTime.now(),
    );
  }
}
