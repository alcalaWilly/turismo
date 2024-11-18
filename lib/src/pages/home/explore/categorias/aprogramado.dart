import 'package:flutter/material.dart';
import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';

class Aprogramado extends StatelessWidget {
  const Aprogramado({super.key, required Categorias categoria});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('ACONTECIMIENTOS PROGRAMADOS'),
    );
  }
}
