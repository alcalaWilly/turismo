import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turismo/main.dart';
import 'package:turismo/src/pages/home/visitas/Visitados.dart';
import 'package:turismo/src/pages/home/explore/configuracion.dart';
import 'package:turismo/src/pages/home/explore/contactos.dart';
import 'package:turismo/src/pages/home/explore/home.dart';
import 'package:turismo/src/pages/login/entities/objectbox.dart';
import 'package:turismo/src/sincronizacion/mongo_service.dart';
import 'package:turismo/src/sincronizacion/sync_service.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late SyncService syncService;

  ///PARA SINCRONIZAR
  int _currentIndex = 0;

  ////PARA SINCRONOZAR////////////////////
  @override
  void initState() {
    super.initState();
    //syncCategoriasToMongoDB(); ////se agregaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    // Asegúrate de que store esté correctamente inicializado
    ObjectBox.getStore().then((store) {
      syncService = SyncService(store: store);

      // Sincroniza los datos al detectar conexión a internet
      syncService.syncWithMongoDB();
      print('Estamos en PERFIL NAAAAAV BAAAAAAAAAAR');
    });
  }
  //////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   title: const Text('prueba',
      //       style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      //   centerTitle: true,
      // ),
      //cuerpo
      body: _Paginas(_currentIndex),
      //botones
      bottomNavigationBar: BotonesNavegacion(
        onTabChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        // backgroundColor: Color.fromRGBO(255, 0, 137, 1.0),
        backgroundColor: Color.fromRGBO(225, 47, 97, 1.0),

        items: [
          Icon(
            Icons.home,
            color: Colors.white,
            size: 30.0,
          ),
          Icon(
            Icons.file_download_done_rounded,
            color: Colors.white,
            size: 30.0,
          ),
          Icon(
            Icons.contact_phone_rounded,
            color: Colors.white,
            size: 30.0,
          ),
        ],
        key: null,
      ),
    );
  }

  Widget _Paginas(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return const Principal();
      case 1:
        return const Visitados();
      case 2:
        return const Contactos();
      // case 3:
      //   return const Configuracion();
      default:
        return const Principal();
    }
  }
}

const _movement = 50.0;

class BotonesNavegacion extends StatefulWidget {
  const BotonesNavegacion({
    Key? key,
    this.backgroundColor = Colors.black,
    required this.items,
    required this.onTabChanged,
    this.initialIndex = 0,
  }) : super(key: key);
  final Color backgroundColor;
  //
  // final List<String> texts;
  // final List<IconData> items;
  final List<Widget> items;
  final ValueChanged<int> onTabChanged;
  final int initialIndex;

  @override
  _BotonesNavegacionState createState() => _BotonesNavegacionState();
}

class _BotonesNavegacionState extends State<BotonesNavegacion>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animTabBarIn;
  late Animation _animTabBarOut;
  late Animation _animCircle;
  late Animation _animElevationIn;
  late Animation _animElevationOut;

  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    //duración de la animación
    _currentIndex = widget.initialIndex ?? 0;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 600,
      ),
    );
    _animTabBarIn = CurveTween(
      curve: Interval(0.1, 0.6, curve: Curves.decelerate),
    ).animate(_controller);

    _animTabBarOut = CurveTween(
      curve: Interval(0.6, 1.0, curve: Curves.bounceOut),
    ).animate(_controller);
    //animación para el circulo
    _animCircle = CurveTween(
      curve: Interval(0.0, 0.5),
    ).animate(_controller);

    //para que el icono suba
    _animElevationIn = CurveTween(
      curve: Interval(0.3, 0.5, curve: Curves.decelerate),
    ).animate(_controller);

    _animElevationOut = CurveTween(
      curve: Interval(0.45, 1.0, curve: Curves.bounceOut),
    ).animate(_controller);

    _controller.forward(from: 1.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //tamaño de navegacion
    //kToolbarHeight -> barras arriba
    //kBottomNavigationBarHeight -> navbar
    final width = MediaQuery.of(context).size.width;
    double currentWidth = width;
    double currentElevation = 0.0;

    return SizedBox(
        height: kBottomNavigationBarHeight,
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              //restando medidas al navba para la animación
              currentWidth = width -
                  (_movement * _animTabBarIn.value) +
                  (_movement * _animTabBarOut.value);

              currentElevation = -_movement * _animElevationIn.value +
                  (_movement - kBottomNavigationBarHeight / 4) *
                      _animElevationOut.value;

              return Center(
                child: Container(
                  width: currentWidth,
                  decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      )),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        widget.items.length,
                        (index) {
                          final child = widget.items[index];
                          final innerWidget = CircleAvatar(
                            radius: 30.0,
                            backgroundColor: widget.backgroundColor,
                            child: child,
                          );
                          if (index == _currentIndex) {
                            return Expanded(
                              child: CustomPaint(
                                foregroundPainter:
                                    _CircleItemPainter(_animCircle.value),
                                child: Transform.translate(
                                  offset: Offset(0.0, currentElevation),
                                  child: innerWidget,
                                ),
                              ),
                            );
                          } else {
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  widget.onTabChanged(index);
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                  _controller.forward(from: 0.0);
                                },
                                child: innerWidget,
                              ),
                            );
                          }
                        },
                      )),
                ),
              );
            }));
  }
}

class _CircleItemPainter extends CustomPainter {
  final double progress;
  _CircleItemPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = 20.0 * progress;
    final strokeWidth = 10.0;
    final currentStrokeWidth = strokeWidth * (1 - progress);
    if (progress < 1.0) {
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = currentStrokeWidth,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
