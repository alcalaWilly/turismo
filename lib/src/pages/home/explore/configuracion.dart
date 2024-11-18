// import 'package:flutter/material.dart';
// import 'package:turismo/src/pages/login/entities/objectbox.dart';
// import 'package:turismo/src/pages/login/entities/person.dart';

// class Configuracion extends StatefulWidget {
//   const Configuracion({super.key});

//   @override
//   State<Configuracion> createState() => _ConfiguracionState();
// }

// class _ConfiguracionState extends State<Configuracion> {
//   Person? _person;

//   // Función para cargar la persona desde la base de datos
//   Future<void> _loadPerson() async {
//     final store = await ObjectBox.getStore(); // Obtener el store de ObjectBox
//     final personBox = store.box<Person>();

//     // Si hay personas, cargar la primera
//     final person = personBox.getAll().first;

//     setState(() {
//       _person = person;
//     });
//   }

//   // Función para actualizar la persona en la base de datos
//   Future<void> _updatePerson(Person updatedPerson) async {
//     final store = await ObjectBox.getStore();
//     final personBox = store.box<Person>();

//     personBox.put(updatedPerson); // Actualizar los datos en la base de datos
//     setState(() {
//       _person = updatedPerson;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadPerson(); // Cargar los datos cuando inicie la vista
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;
//     final isPortrait = mediaQuery.orientation == Orientation.portrait;

//     final List<Map<String, dynamic>> configItems = [
//       {
//         'titulo': 'DNI',
//         'subtitle': _person?.dni ?? '',
//         'iconData': Icons.perm_identity,
//         'field': 'dni',
//       },
//       {
//         'titulo': 'Pasaporte',
//         'subtitle': _person?.pasaporte ?? '',
//         'iconData': Icons.book,
//         'field': 'pasaporte',
//       },
//       {
//         'titulo': 'Celular',
//         'subtitle': _person?.celular ?? '',
//         'iconData': Icons.phone,
//         'field': 'celular',
//       },
//       {
//         'titulo': 'Usuario',
//         'subtitle': _person?.usuario ?? '',
//         'iconData': Icons.person,
//         'field': 'usuario',
//       },
//       {
//         'titulo': 'Contraseña',
//         'subtitle': _person?.password ?? '',
//         'iconData': Icons.key,
//         'field': 'password',
//       },
//       {
//         'titulo': 'País',
//         'subtitle': (_person!.lugarVista?.length ?? 0) > 0
//             ? _person!.lugarVista![0]
//             : "No especificado",
//         'iconData': Icons.location_on,
//         'field': 'pais',
//       },
//       {
//         'titulo': 'Departamento',
//         'subtitle': (_person!.lugarVista?.length ?? 0) > 1
//             ? _person!.lugarVista![1]
//             : "No especificado",
//         'iconData': Icons.location_city,
//         'field': 'departamento',
//       },
//       {
//         'titulo': 'Provincia',
//         'subtitle': (_person!.lugarVista?.length ?? 0) > 2
//             ? _person!.lugarVista![2]
//             : "No especificado",
//         'iconData': Icons.home_work,
//         'field': 'provincia',
//       },
//       {
//         'titulo': 'Motivos',
//         'subtitle': _person!.motivos?.isNotEmpty ?? false
//             ? _person!.motivos?.join(", ")
//             : "No especificado",
//         'iconData': Icons.check_circle,
//         'field': 'motivos',
//       },
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Configuración"),
//       ),
//       body: _person == null
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: EdgeInsets.all(isPortrait ? 20.0 : 40.0),
//               child: ListView.builder(
//                 itemCount:
//                     configItems.length + 1, // Añadido +1 para el CircleAvatar
//                 itemBuilder: (context, index) {
//                   if (index == 0) {
//                     // Renderiza el CircleAvatar en la primera posición
//                     return SizedBox(
//                       height: MediaQuery.of(context).size.height *
//                           0.2, // Ajustar según el diseño
//                       width: double.infinity,
//                       child: Center(
//                         child: CircleAvatar(
//                           radius: 70, // Ajusta el radio según el diseño
//                           child: Icon(
//                             Icons.person, // Cambia el ícono si prefieres otro
//                             size:
//                                 70, // Ajusta el tamaño del ícono si es necesario
//                             color: Colors
//                                 .white, // Ajusta el color del ícono si es necesario
//                           ),
//                           backgroundColor: Colors.indigo[
//                               300], // Cambia el color de fondo si lo deseas
//                         ),
//                       ),
//                     );
//                   }

//                   // Renderiza los demás elementos de la lista
//                   final item = configItems[index -
//                       1]; // Ajusta el índice para acceder a los elementos de configItems
//                   return itemPerfil(
//                     context,
//                     titulo: item['titulo'],
//                     subtitle: item['subtitle'],
//                     iconData: item['iconData'],
//                     onTap: () => _showEditDialog(
//                       context,
//                       item['titulo'],
//                       item['subtitle'],
//                       (value) {
//                         switch (item['field']) {
//                           case 'dni':
//                             _person!.dni = value;
//                             break;
//                           case 'pasaporte':
//                             _person!.pasaporte = value;
//                             break;
//                           case 'celular':
//                             _person!.celular = value;
//                             break;
//                           case 'usuario':
//                             _person!.usuario = value;
//                             break;
//                           case 'password':
//                             _person!.password = value;
//                             break;
//                           case 'pais':
//                             _person!.lugarVista?[0] = value;
//                             break;
//                           case 'departamento':
//                             _person!.lugarVista?[1] = value;
//                             break;
//                           case 'provincia':
//                             _person!.lugarVista?[2] = value;
//                             break;
//                           case 'motivos':
//                             _person!.motivos = value.split(", ");
//                             break;
//                         }
//                         _updatePerson(_person!);
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//     );
//   }

//   // Item del perfil que muestra los datos y permite editarlos
//   Widget itemPerfil(BuildContext context,
//       {required String titulo,
//       required String subtitle,
//       required IconData iconData,
//       required Function onTap}) {
//     final mediaQuery = MediaQuery.of(context);
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: mediaQuery.size.height * 0.01),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             offset: const Offset(0, 5),
//             color: Colors.deepOrange.withOpacity(.2),
//             spreadRadius: 2,
//             blurRadius: 10,
//           ),
//         ],
//       ),
//       child: ListTile(
//         title: Text(titulo),
//         subtitle: Text(subtitle),
//         leading: Icon(iconData),
//         trailing: const Icon(Icons.edit, color: Colors.grey),
//         tileColor: Colors.white,
//         onTap: () => onTap(),
//       ),
//     );
//   }

//   // Diálogo de edición para actualizar el perfil
//   void _showEditDialog(BuildContext context, String campo, String valorActual,
//       Function(String) onSave) {
//     final _controller = TextEditingController(text: valorActual);

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Editar $campo"),
//           content: SingleChildScrollView(
//             child: TextField(
//               controller: _controller,
//               decoration: InputDecoration(labelText: "Nuevo $campo"),
//               keyboardType: TextInputType.text,
//             ),
//           ),
//           actions: [
//             TextButton(
//               child: const Text("Cancelar"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text("Guardar"),
//               onPressed: () {
//                 onSave(_controller.text);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
