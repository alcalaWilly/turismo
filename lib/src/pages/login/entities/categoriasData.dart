// import 'package:objectbox/objectbox.dart';
// import 'package:latlong2/latlong.dart';

// @Entity()
// class Categorias {
//   @Id()
//   int id = 0; // Clave primaria autoincremental de ObjectBox

//   String name;
//   int icon;

//   // Relación de uno a muchos con Lugar
//   @Backlink()
//   final lugares = ToMany<Lugar>();

//   Categorias({
//     required this.name,
//     required this.icon,
//   });
// }

// @Entity()
// class Lugar {
//   @Id()
//   int id = 0; // Clave primaria autoincremental de ObjectBox

//   String nombre;
//   List<String> imagenes;
//   String descripcion;
//   String tiempoEstimado;
//   bool visitado;

//   // Almacenamos la región como un JSON String en lugar de LatLngBounds para ObjectBox
//   String regionJson;

//   // Almacenamos los puntos de la polilínea como JSON
//   List<String> polylineJson;

//   // Relación de muchos a uno con Categorias
//   final categorias = ToOne<Categorias>();

//   Lugar({
//     required this.nombre,
//     required this.imagenes,
//     required this.descripcion,
//     required this.tiempoEstimado,
//     this.visitado = false,
//     required this.regionJson,
//     required this.polylineJson,
//   });
// }
