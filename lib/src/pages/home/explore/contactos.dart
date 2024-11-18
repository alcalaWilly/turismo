import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa url_launcher para realizar llamadas

class Contactos extends StatefulWidget {
  const Contactos({super.key});

  @override
  State<Contactos> createState() => _ContactosState();
}

class _ContactosState extends State<Contactos> {
  List contacts = [
    "Policia Nacional del Perú",
    "Bomberos Voluntarios del Perú",
    "Centro de Salud Posta",
    "Serenazgo de Rio Negro",
    "Defensa Civil Nacional"
  ];

  List celular = [
    "999999999",
    "999999999",
    "999999999",
    "999999999",
    "999999999"
  ];

  // Lista de rutas de imágenes para cada contacto
  List<String> imagePaths = [
    "assets/iconos/contactos/policia.png", // Ruta para "Policia Nacional del Perú"
    "assets/iconos/contactos/bombero.png", // Ruta para "Bomberos Voluntarios del Perú"
    "assets/iconos/contactos/salud.png", // Ruta para "Centro de Salud Posta"
    "assets/iconos/contactos/serenazgo.png", // Ruta para "Serenazgo de Rio Negro"
    "assets/iconos/contactos/civil.png" // Ruta para "Defensa Civil Nacional"
  ];

  // Función para realizar llamadas
  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo iniciar la llamada')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(241, 241, 241, 1.0),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text(
            "CONTACTOS DE EMERGENCIA",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(5, 41, 55, 1.0),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Container(
            child: ListView.builder(
              itemCount: contacts.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) => Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child: Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // Imagen del contacto dentro del CircleAvatar
                            Container(
                              width: 55.0,
                              height: 55.0,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(imagePaths[
                                    index]), // Cargar la imagen correspondiente
                                backgroundColor: Colors
                                    .transparent, // Fondo transparente si no hay imagen
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            // Expande el espacio del texto para que no interfiera con el botón
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.4, // Limita el ancho del texto
                                  child: Text(
                                    contacts[index],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow
                                        .ellipsis, // Añade puntos suspensivos si es largo
                                    maxLines:
                                        2, // Máximo 2 líneas para los contactos largos
                                  ),
                                ),
                                Text(
                                  celular[index],
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () => _makePhoneCall(celular[index]),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(5, 41, 55, 1.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text(
                            "Llamar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
