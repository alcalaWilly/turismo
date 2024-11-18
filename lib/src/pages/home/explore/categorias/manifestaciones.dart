import 'package:flutter/material.dart';
import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Manifestaciones extends StatefulWidget {
  final Categorias categoria;

  Manifestaciones({required this.categoria, Key? key}) : super(key: key);

  @override
  _ManifestacionesState createState() => _ManifestacionesState();
}

class _ManifestacionesState extends State<Manifestaciones> {
  bool _isClicked = false;

  void _toggleClick() {
    setState(() {
      _isClicked = !_isClicked;
    });
  }

  // int _currentPage = 0;
  // final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(25.0),
      shrinkWrap: true,
      itemCount: widget.categoria.lugares.length,
      itemBuilder: (context, index) {
        final lugar = widget.categoria.lugares[index];
        final PageController pageController = PageController();
        int currentPage = 0;
        return GestureDetector(
//           onTap: () {
//             // Navegar a la página correspondiente según el lugar seleccionado
//             if (lugar.nombre == 'Catarata Tsomontonari') {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Tsomontonari(lugar: lugar),
//                 ),
//               );
//             } else if (lugar.nombre == 'Cueva Vanhellsing') {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Cuevavanhellsing(
//                       lugar: lugar), // Cambia a la clase correcta para la cueva
//                 ),
//               );
// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
//             } else {
//               // Puedes agregar más condiciones aquí para otros lugares o usar una lógica más dinámica
//               //Navigator.push(
//               //context
//               //MaterialPageRoute(
//               //builder: (context) => LugarDefault(lugar: lugar), // Una pantalla por defecto si no hay un caso específico
//               //),
//               //);
//             }
//           },
          child: Container(
            margin: EdgeInsets.only(bottom: 20.0),
            height: 420,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 350,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: pageController,
                        itemCount: lugar.imagenes.length,
                        onPageChanged: (int pageIndex) {
                          setState(() {
                            currentPage = pageIndex;
                          });
                        },
                        itemBuilder: (context, imageIndex) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: AssetImage(lugar.imagenes[imageIndex]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: 320,
                        // top: 170,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: lugar.imagenes.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: Colors.white,
                              dotColor: Colors.grey,
                              dotHeight: 8,
                              dotWidth: 8,
                              spacing: 8,
                            ),
                          ),
                        ),
                      ),
                      // Positioned(
                      //   top: 8,
                      //   right: 8,
                      //   child: AnimatedContainer(
                      //     duration: Duration(milliseconds: 300),
                      //     width: 40,
                      //     height: 40,
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       color: lugar.visitado ? Colors.black : Colors.white,
                      //     ),
                      //     child: Center(
                      //       child: Icon(
                      //         Icons.check,
                      //         color:
                      //             lugar.visitado ? Colors.green : Colors.black,
                      //         size: 24,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // SizedBox(height: 16),
                // Text(
                //   lugar.nombre,
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(lugar.descripcion),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(lugar.nombre,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4E342E),
                          )),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.star,
                      //       color: Colors.grey,
                      //       size: 24,
                      //     ),
                      //     Text(
                      //       '2.1',
                      //       style: TextStyle(fontSize: 17, color: Colors.grey),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 0.1 / 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.directions_car,
                        color: const Color.fromARGB(255, 1, 116, 5),
                        size: 24,
                      ),
                      SizedBox(width: 5),
                      Text('Ubicado: ',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 1, 116, 5))),
                      SizedBox(width: 2),
                      Text(
                        lugar.tiempoEstimado,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),

                  // child: Text(
                  //   'Tiempo estimado: ${lugar.tiempoEstimado}',
                  //   style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  // ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
