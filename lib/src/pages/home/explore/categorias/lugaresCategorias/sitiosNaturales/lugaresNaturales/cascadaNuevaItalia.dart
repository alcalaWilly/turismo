import 'dart:async';

import 'package:flutter/material.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/mapaNaturales/mapaCascadaNuevaItalia.dart';
import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:turismo/src/pages/home/visitas/datoVistas/visitasDB.dart';
import 'package:turismo/src/pages/home/visitas/guardar/guardar.dart';
import 'package:turismo/src/pages/login/entities/objectbox.dart';

class Cascadanuevaitalia extends StatefulWidget {
  final Lugar lugar;

  Cascadanuevaitalia({required this.lugar, Key? key}) : super(key: key);

  @override
  _CascadanuevaitaliaState createState() => _CascadanuevaitaliaState();
}

class _CascadanuevaitaliaState extends State<Cascadanuevaitalia> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Iniciar un temporizador que registre una visita cada 1 minuto
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      registerVisit(widget.lugar);
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancelar el temporizador al salir de la página
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // SliverAppBar(
              //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              //   elevation: 0,
              //   pinned: true,
              //   centerTitle: false,
              //   expandedHeight: 500.0,
              //   flexibleSpace: FlexibleSpaceBar(
              //     background: Image.asset(
              //       widget.lugar.imagen,
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              //   leading: Padding(
              //     padding: const EdgeInsets.all(
              //         5.0), // Padding alrededor del círculo
              //     child: Container(
              //       padding: EdgeInsets.all(4), // Padding interno para el icono
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: Colors.white, // Color del círculo
              //       ),
              //       child: IconButton(
              //         icon: Icon(
              //           Icons.arrow_back,
              //           color:
              //               Colors.black, // Color del icono dentro del círculo
              //         ),
              //         onPressed: () {
              //           Navigator.pop(context); // Volver a la página anterior
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                pinned: true,
                centerTitle: false,
                expandedHeight: 500.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      // El PageView para el carrusel de imágenes
                      PageView.builder(
                        controller: _pageController,
                        itemCount: widget.lugar.imagenes
                            .length, // Número de imágenes del lugar
                        onPageChanged: (int pageIndex) {
                          setState(() {
                            _currentPage = pageIndex;
                          });
                        },
                        itemBuilder: (context, imageIndex) {
                          return Image.asset(
                            widget.lugar.imagenes[imageIndex],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        },
                      ),
                      // Puntos indicadores en la parte superior centrada
                      Positioned(
                        top: 500,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: widget.lugar.imagenes.length,
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
                    ],
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(
                      5.0), // Padding alrededor del círculo
                  child: Container(
                    padding: EdgeInsets.all(4), // Padding interno para el icono
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white, // Color del círculo
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color:
                            Colors.black, // Color del icono dentro del círculo
                      ),
                      onPressed: () {
                        Navigator.pop(context); // Volver a la página anterior
                      },
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.lugar.nombre,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Text(
                      'Este lugar ofrece',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    // Primer Row
                    Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Alinear todo el contenido al centro horizontalmente
                      children: [
                        // Primer Row
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0), // Agregar padding horizontal
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Centrar los elementos horizontalmente
                            crossAxisAlignment: CrossAxisAlignment
                                .center, // Alinear ícono y texto verticalmente en el centro
                            children: [
                              Icon(Icons.visibility),
                              SizedBox(
                                  width:
                                      16), // Espacio fijo entre el ícono y el texto
                              Expanded(
                                child: Align(
                                  alignment: Alignment
                                      .centerLeft, // Alinear el texto a la izquierda
                                  child: Text('Observación de aves'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16), // Espacio entre las filas

                        // Segundo Row
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0), // Agregar padding horizontal
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.pets),
                              SizedBox(
                                  width:
                                      16), // Espacio fijo entre el ícono y el texto
                              Expanded(
                                child: Align(
                                  alignment: Alignment
                                      .centerLeft, // Alinear el texto a la izquierda
                                  child: Text('Observación de fauna'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16), // Espacio entre las filas

                        // Tercer Row
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0), // Agregar padding horizontal
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.local_florist),
                              SizedBox(
                                  width:
                                      16), // Espacio fijo entre el ícono y el texto
                              Expanded(
                                child: Align(
                                  alignment: Alignment
                                      .centerLeft, // Alinear el texto a la izquierda
                                  child: Text('Observación de flora'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16), // Espacio entre las filas

                        // Cuarto Row
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0), // Agregar padding horizontal
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.directions_walk),
                              SizedBox(
                                  width:
                                      16), // Espacio fijo entre el ícono y el texto
                              Expanded(
                                child: Align(
                                  alignment: Alignment
                                      .centerLeft, // Alinear el texto a la izquierda
                                  child: Text('Caminata'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Texto largo con botón Leer más basado en widget.lugar.descripcion
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Centra el contenido en la columna
                        children: [
                          // Título
                          Text(
                            'Descripción',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center, // Centrar el título
                          ),
                          SizedBox(
                              height: 8), // Espacio entre el título y el texto

                          // Texto truncado
                          Text(
                            widget.lugar.descripcion.length > 171
                                ? widget.lugar.descripcion.substring(0, 171) +
                                    '...'
                                : widget.lugar.descripcion,
                            style: TextStyle(fontSize: 16),
                            textAlign:
                                TextAlign.start, // Centrar el texto truncado
                          ),
                          SizedBox(
                              height:
                                  8), // Espacio entre el texto truncado y el botón

                          // Botón de "Leer más" alineado a la izquierda
                          Align(
                            alignment: Alignment
                                .centerLeft, // Alinear el botón a la izquierda
                            child: widget.lugar.descripcion.length > 100
                                ? InkWell(
                                    onTap: () {
                                      _showFullTextModal(
                                          context,
                                          widget.lugar
                                              .descripcion); // Abre el modal con la descripción completa
                                    },
                                    child: Text(
                                      'Leer más',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : Container(), // No mostrar el botón si la descripción no es larga
                          ),
                        ],
                      ),
                    ),

                    //SizedBox(height: 3),

                    // Texto largo con botón Leer más basado en widget.lugar.descripcion
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Centra el contenido en la columna
                        children: [
                          Text(
                            'Precausiones',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          // Primer Row
                          Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .center, // Alinear todo el contenido al centro horizontalmente
                            children: [
                              // Primer Row
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        24.0), // Agregar padding horizontal
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Centrar los elementos horizontalmente
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center, // Alinear ícono y texto verticalmente en el centro
                                  children: [
                                    Icon(Icons.timer),
                                    SizedBox(
                                        width:
                                            16), // Espacio fijo entre el ícono y el texto
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment
                                            .centerLeft, // Alinear el texto a la izquierda
                                        child: Text(
                                            'Hora de visita (de 8AM - 4:30PM)'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16), // Espacio entre las filas

                              // Segundo Row
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        24.0), // Agregar padding horizontal
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.money),
                                    SizedBox(
                                        width:
                                            16), // Espacio fijo entre el ícono y el texto
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment
                                            .centerLeft, // Alinear el texto a la izquierda
                                        child: Text(
                                            'Ingreso con boletín o ticket'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                          // Título
                        ],
                      ),
                    ),

                    SizedBox(height: 50),
                  ],
                ),
              )
              // Aquí puedes agregar más Slivers si lo necesitas
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.indigo, // Color del contenedor
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Mapacascadanuevaitalia(lugar: widget.lugar),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .min, // Ajusta el tamaño del Row al contenido
                      children: [
                        Text(
                          'Quiero ir', // Texto dentro del contenedor
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.map_sharp, // Icono de mapa
                          color: Colors.white,
                          size: 18,
                        ), // Espacio entre el icono y el texto
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Función para mostrar el modal con la descripción completa
void _showFullTextModal(BuildContext context, String fullText) {
  showModalBottomSheet(
    context: context,
    isScrollControlled:
        true, // Permite que el modal ocupe más espacio en pantalla
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                fullText,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Cierra el modal
                },
                child: Text('Cerrar'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
