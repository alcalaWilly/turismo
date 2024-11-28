import 'package:flutter/material.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/manifestacionesCulturales/lugaresManifestaciones/capilla.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/manifestacionesCulturales/lugaresManifestaciones/parque.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/manifestacionesCulturales/mapaManifestaciones/mapaCapilla.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/manifestacionesCulturales/mapaManifestaciones/mapaParque.dart';
import 'package:turismo/src/pages/home/visitas/Visitados.dart';
import 'package:turismo/src/pages/home/explore/categorias/aprogramado.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/lugaresNaturales/CavernaNuevaItalia.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/lugaresNaturales/cascadaInkani.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/lugaresNaturales/cascadaNuevaItalia.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/lugaresNaturales/catarataAmbitarin.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/lugaresNaturales/catarataCanuja.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/lugaresNaturales/catarataCunampiaro.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/lugaresNaturales/catarataHuahuari.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/lugaresNaturales/cavernaAshaninka.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/lugaresNaturales/cuevaVanhellsing.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/lugaresNaturales/tsomontonari.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/mapaNaturales/mapaCascadaInkani.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/mapaNaturales/mapaCascadaNuevaItalia.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/mapaNaturales/mapaCatarataAmbitarin.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/mapaNaturales/mapaCatarataCanuja.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/mapaNaturales/mapaCatarataCunampiaro.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/mapaNaturales/mapaCatarataHuahuari.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/mapaNaturales/mapaCavernaAshaninka.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/mapaNaturales/mapaCavernaNuevaItalia.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/mapaNaturales/mapaTsomontonari.dart';
import 'package:turismo/src/pages/home/explore/categorias/lugaresCategorias/sitiosNaturales/mapaNaturales/mapaVanhellsing.dart';
import 'package:turismo/src/pages/home/explore/categorias/rtecnicas.dart';
import 'package:turismo/src/pages/home/explore/categorias/floclore.dart';
import 'package:turismo/src/pages/home/explore/categorias/manifestaciones.dart';
import 'package:turismo/src/pages/home/explore/categorias/naturales.dart';
import 'package:turismo/src/pages/home/explore/configuracion.dart';
import 'package:turismo/src/pages/home/explore/contactos.dart';
import 'package:turismo/src/pages/home/explore/home.dart';

import 'package:turismo/src/pages/home/explore/navbar.dart';
import 'package:turismo/src/pages/home/modules/categoriaModel/categorias.dart';
import 'package:turismo/src/pages/login/entities/person.dart';

import 'package:turismo/src/pages/sacarPerfil/motivoTurismo.dart';
import 'package:turismo/src/pages/login/registro.dart';
import 'package:turismo/src/pages/login/login.dart';

Map<String, WidgetBuilder> rutas = {
  'Login': (context) => const Login(),
  'Registro': (context) => const Registro(),
  'Perfilturista': (context) {
    final person = ModalRoute.of(context)!.settings.arguments as Person;
    return Perfilturista(
      person: person, // Aquí se pasa el objeto Person directamente
    );
  },
  //'Home': (context) => Home(),
  'Principal': (context) => Principal(),
  'Navbar': (context) => Navbar(),
  'Visitados': (context) => Visitados(),
  'Contactos': (context) => Contactos(),
  // 'Configuracion': (context) => Configuracion(),
  'Floclore': (context) => Floclore(
      categoria: ModalRoute.of(context)!.settings.arguments as Categorias),
  'Naturales': (context) => Naturales(
      categoria: ModalRoute.of(context)!.settings.arguments as Categorias),
  'Rtecnicas': (context) => Rtecnicas(
      categoria: ModalRoute.of(context)!.settings.arguments as Categorias),
  'Aprogramado': (context) => Aprogramado(
      categoria: ModalRoute.of(context)!.settings.arguments as Categorias),
  'Manifestaciones': (context) => Manifestaciones(
      categoria: ModalRoute.of(context)!.settings.arguments as Categorias),
  ///////////////////////////
  ///LOS LUAGRES///////
  'Tsomontonari': (context) => Tsomontonari(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Cuevavanhellsing': (context) => Cuevavanhellsing(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'CascadaIncani': (context) => CascadaIncani(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Cascadanuevaitalia': (context) => Cascadanuevaitalia(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Catarataambitarini': (context) => Catarataambitarini(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Cataratacanuja': (context) => Cataratacanuja(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Cataratacunampiaro': (context) => Cataratacunampiaro(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Cataratahuahuari': (context) => Cataratahuahuari(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Cavernaashaninka': (context) => Cavernaashaninka(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Cavernanuevaitalia': (context) => Cavernanuevaitalia(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  ////////////////////////////////////

  'Mapatsomontonari': (context) => Mapatsomontonari(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Mapavanhellsing': (context) => Mapavanhellsing(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Mapacascadainkani': (context) => Mapacascadainkani(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Mapacascadanuevaitalia': (context) => Mapacascadanuevaitalia(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Mapacatarataambitarini': (context) => Mapacatarataambitarini(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Mapacataratacanuja': (context) => Mapacataratacanuja(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Mapacataratacunampiaro': (context) => Mapacataratacunampiaro(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Mapacataratahuahuari': (context) => Mapacataratahuahuari(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Mapacavernaashaninka': (context) => Mapacavernaashaninka(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Mapacavernanuevaitalia': (context) => Mapacavernanuevaitalia(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),

  /////////////////////////////////MANIFESTACIONES:
  'Parque': (context) => Parque(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Capilla': (context) => Capilla(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  ///////////////////////////////MAPA
  'MapaParque': (context) => MapaParque(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
  'Mapacapilla': (context) => Mapacapilla(
        lugar: ModalRoute.of(context)!.settings.arguments as Lugar,
      ),
};
