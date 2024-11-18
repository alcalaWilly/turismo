import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';
import 'package:turismo/src/pages/home/visitas/datoVistas/visitasDB.dart';
import 'package:turismo/src/pages/login/entities/objectbox.dart';

class Visitados extends StatefulWidget {
  const Visitados({super.key});

  @override
  State<Visitados> createState() => _VisitadosState();
}

class _VisitadosState extends State<Visitados> {
  List<Visita> _visitas = [];

  @override
  void initState() {
    super.initState();
    _loadVisitas(); // Cargar visitas al iniciar
  }

  Future<void> _loadVisitas() async {
    final store = await ObjectBox.getStore();
    final visitaBox = store.box<Visita>();

    final visitas = visitaBox.getAll(); // Obtener todas las visitas

    setState(() {
      _visitas = visitas;
    });
  }

  Future<void> _eliminarVisita(Visita visita) async {
    final store = await ObjectBox.getStore();
    final visitaBox = store.box<Visita>();

    visitaBox.remove(visita.ide); // Eliminar la visita de ObjectBox
    _loadVisitas(); // Recargar la lista de visitas
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      color: Color.fromRGBO(241, 241, 241, 1.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text(
            "MIS VISITAS",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(5, 41, 55, 1.0),
              fontSize: width * 0.05, // Tamaño de texto adaptable
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: height * 0.02),
          child: _visitas.isEmpty
              ? Center(
                  child: Text('No hay visitas registradas.',
                      style: TextStyle(fontSize: width * 0.04)))
              : ListView.builder(
                  itemCount: _visitas.length,
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04, vertical: height * 0.01),
                  itemBuilder: (BuildContext context, int index) {
                    final visita = _visitas[index];

                    String fechaFormateada =
                        DateFormat('dd/MM/yyyy').format(visita.fechaVisita);

                    Lugar? lugarVisitado;
                    for (var categoria in categoriaData) {
                      for (var lugar in categoria.lugares) {
                        if (lugar.nombre == visita.nombreLugar) {
                          lugarVisitado = lugar;
                          break;
                        }
                      }
                      if (lugarVisitado != null) break;
                    }

                    if (lugarVisitado == null) {
                      return SizedBox.shrink();
                    }

                    final primeraImagen = lugarVisitado.imagenes[0];

                    return Dismissible(
                      key: Key(visita.ide.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete,
                          color: Color.fromRGBO(225, 47, 97, 1.0),
                          size: width * 0.12,
                        ),
                      ),
                      onDismissed: (direction) {
                        _eliminarVisita(visita);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: height * 0.01),
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            height: height * 0.15,
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.04,
                              vertical: height * 0.015,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: width * 0.18,
                                      height: width * 0.18,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          image: AssetImage(primeraImagen),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: width * 0.04),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: width *
                                              0.4, // Ajustar ancho para evitar desbordamiento
                                          child: Text(
                                            visita.nombreLugar,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: width * 0.045,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        SizedBox(height: height * 0.005),
                                        Text(
                                          fechaFormateada,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: width * 0.04,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // Íconos ajustados para que no se desborden
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_back,
                                      color: Color.fromRGBO(5, 41, 55, 1.0),
                                      size: width * 0.06,
                                    ),
                                    SizedBox(height: height * 0.01),
                                    Icon(
                                      Icons.delete,
                                      color: Color.fromRGBO(5, 41, 55, 1.0),
                                      size: width * 0.06,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
