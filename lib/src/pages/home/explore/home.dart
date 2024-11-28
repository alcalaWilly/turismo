import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:turismo/src/pages/home/explore/categorias/aprogramado.dart';
import 'package:turismo/src/pages/home/explore/categorias/rtecnicas.dart';
import 'package:turismo/src/pages/home/explore/categorias/floclore.dart';
import 'package:turismo/src/pages/home/explore/categorias/manifestaciones.dart';
import 'package:turismo/src/pages/home/explore/categorias/naturales.dart';
import 'package:turismo/src/pages/home/explore/configuracion.dart';
import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  var heigth, width;

  // Variable para rastrear la pestaña seleccionada
  int selectedIndex = 0;

  // List of TabBarView contents (pages for each category)
  final List<Widget> tabsContent = [
    Naturales(categoria: categoriaData[0]),
    Manifestaciones(categoria: categoriaData[1]),
    Floclore(categoria: categoriaData[2]),
    // Aprogramado(categoria: categoriaData[3]),
    // Rtecnicas(categoria: categoriaData[4]),
  ];

  @override
  Widget build(BuildContext context) {
    heigth = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(241, 241, 241, 1.0),
      ),
      child: DefaultTabController(
        length: categoriaData
            .length, // Asegúrate de que haya un DefaultTabController
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 23.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/logoHome.webp',
                    height: 50,
                  ),
                  // InkWell(
                  //   // onTap: () {
                  //   //   Navigator.push(
                  //   //     context,
                  //   //     MaterialPageRoute(
                  //   //       builder: (context) => Configuracion(),
                  //   //     ),
                  //   //   );
                  //   // },
                  //   borderRadius: BorderRadius.circular(10),
                  //   child: Container(
                  //     height: 34,
                  //     width: 34,
                  //     decoration: BoxDecoration(
                  //       color: Colors.transparent,
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: ClipRRect(
                  //       child: Image.asset(
                  //         'assets/iconos/configuraciones.webp',
                  //         color: Colors.black87,
                  //         height: 50,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: Column(
                children: [
                  const SizedBox(height: 3),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0), // Ajusta el padding aquí
                    child: Transform.translate(
                      offset: Offset(-35, 0),
                      child: TabBar(
                        // isScrollable: true,
                        // labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                        onTap: (index) {
                          setState(() {
                            selectedIndex =
                                index; // Actualiza el índice seleccionado
                          });
                        },
                        indicator:
                            const BoxDecoration(), // Elimina el indicador predeterminado
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        isScrollable:
                            true, // Para que las pestañas se puedan desplazar si son muchas
                        tabs: categoriaData.asMap().entries.map((entry) {
                          int index = entry.key;
                          var categoria = entry.value;

                          return Tab(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? Color.fromRGBO(5, 41, 55,
                                        1.0) // Color de fondo cuando está seleccionada
                                    : Colors
                                        .white, // Color de fondo cuando no está seleccionada
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    categoria.icon,
                                    size: 30, // Ajusta el tamaño del icono
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Color.fromRGBO(5, 41, 55,
                                            1.0), // Cambia el color según si está seleccionada
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    categoria.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: selectedIndex == index
                                          ? Colors.white
                                          : Color.fromRGBO(5, 41, 55,
                                              1.0), // Cambia el color del texto según si está seleccionada
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          body: TabBarView(
            children: tabsContent,
          ),
        ),
      ),
    );
  }
}
