import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';

class Floclore extends StatefulWidget {
  final Categorias categoria;

  Floclore({required this.categoria, Key? key}) : super(key: key);

  @override
  State<Floclore> createState() => _FlocloreState();
}

class _FlocloreState extends State<Floclore> {
  bool _isClicked = false;

  void _toggleClick() {
    setState(() {
      _isClicked = !_isClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: widget.categoria.lugares.length,
      itemBuilder: (context, index) {
        final lugar = widget.categoria.lugares[index];
        return Container(
          margin: EdgeInsets.only(bottom: 16.0),
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  // image: DecorationImage(
                  //   image: AssetImage(lugar.imagen),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isClicked
                            ? Colors.white
                            : Color.fromARGB(255, 0, 0, 0),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: _isClicked ? Colors.green : Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lugar.nombre,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 24,
                        ),
                        Text(
                          '2.1',
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Tiempo estimado: ${lugar.tiempoEstimado}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
