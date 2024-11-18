import 'package:objectbox/objectbox.dart';

@Entity()
class Visita {
  @Id()
  int ide;
  String? mongoId; // Campo para guardar el _id de MongoDB
  String nombreLugar;
  DateTime fechaVisita;
  bool syncPending; // Campo para indicar si está pendiente de sincronización

  Visita({
    this.ide = 0,
    this.mongoId, // Inicialmente es null
    required this.nombreLugar,
    required this.fechaVisita,
    this.syncPending = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'ide': ide,
      'nombreLugar': nombreLugar,
      'fechaVisita': fechaVisita.toIso8601String(),
      'syncPending': syncPending,
      '_id': mongoId, // Incluye el _id si existe
    };
  }

  factory Visita.fromJson(Map<String, dynamic> json) {
    return Visita(
      ide: json['ide'],
      mongoId: json['_id'], // Carga el _id desde MongoDB
      nombreLugar: json['nombreLugar'],
      fechaVisita: DateTime.parse(json['fechaVisita']),
      syncPending: json['syncPending'] ?? true,
    );
  }
}
