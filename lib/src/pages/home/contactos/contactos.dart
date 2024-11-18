// import 'package:flutter/material.dart';

// class Contactos extends StatefulWidget {
//   const Contactos({super.key});

//   @override
//   State<Contactos> createState() => _ContactosState();
// }

// class _ContactosState extends State<Contactos> {
//   List contactos = [
//     "Policia nacional del peru",
//     "Bomberos",
//     "posta",
//     "cerenazgo",
//     "Defenza civil"
//   ];
//   List celular = [
//     "965326598",
//     "965326598",
//     "965326598",
//     "965326598",
//     "965326598"
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 10,
//       shrinkWrap: true,
//       itemBuilder: (BuildContext context, int index) => Container(
//         width: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//         child: Card(
//           elevation: 5.0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(0.0),
//           ),
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       width: 55.0,
//                       height: 55.0,
//                       color: Colors.green,
//                       child: CircleAvatar(
//                         backgroundColor: Colors.green,
//                         foregroundColor: Colors.green,
//                         //link de imagen
//                       ),
//                     ),
//                     SizedBox(
//                       width: 5.0,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           contactos[index],
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           celular[index],
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//                 // Container(
//                 //   alignment: Alignment.center,
//                 //   padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//                 //   child: FlatButton(
//                 //     onPressed: (){},
//                 //     color: Colors.red[200],
//                 //     shape: RoundedRectangleBorder(
//                 //       borderRadius: BorderRadius.circular(20.0)
//                 //     ),
//                 //     child: Text("Llamar", style: TextStyle(
//                 //       color: Colors.white
//                 //     ),)
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
