import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

Padding pregunta(BuildContext context,
    {required String titulo, required String link, required Widget pagina}) {
  return Padding(
    padding: const EdgeInsets.only(left: 30.0, top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          titulo, //'¿No tienes cuenta?',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        // const SizedBox(
        //     width: 1.3), // Espacio entre el texto y el botón
        CupertinoButton(
          child: Text(
            link, //'Regístrate',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              decoration: TextDecoration.underline,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => pagina),
            );
          },
        ),
      ],
    ),
  );
}
