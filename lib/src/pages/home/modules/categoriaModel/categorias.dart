import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';

class Lugar {
  final String nombre;
  final List<String> imagenes;
  final String descripcion;
  final String tiempoEstimado;
  final bool visitado;
  final LatLngBounds region; // Nueva propiedad para la región del lugar
  final List<LatLng> polyline; // Nueva propiedad para la polilínea

  Lugar({
    required this.nombre,
    required this.imagenes,
    required this.descripcion,
    required this.tiempoEstimado,
    required this.region,
    required this.polyline,
    this.visitado = false,
  });
}

class Categorias {
  final String name;
  // final String icon;
  final IconData icon;
  final List<Lugar> lugares;

  Categorias({
    required this.name,
    required this.icon,
    required this.lugares,
  });
}

// class Categorias {
//   String name;
//   IconData
//       icon; // Asegúrate de manejar el icono adecuadamente al convertir a un Map.
//   List<Lugar> lugares;

//   Categorias({required this.name, required this.icon, required this.lugares});

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'icon': icon.codePoint, // Solo almacena el código del icono
//       'lugares': lugares.map((lugar) => lugar.toMap()).toList(),
//     };
//   }

//   static Categorias fromMap(Map<String, dynamic> map) {
//     return Categorias(
//       name: map['name'],
//       icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
//       lugares: (map['lugares'] as List)
//           .map((lugarMap) => Lugar.fromMap(lugarMap))
//           .toList(),
//     );
//   }
// }

// class Lugar {
//   String nombre;
//   List<String> imagenes;
//   String descripcion;
//   String tiempoEstimado;
//   LatLngBounds region;
//   List<LatLng> polyline;

//   Lugar({
//     required this.nombre,
//     required this.imagenes,
//     required this.descripcion,
//     required this.tiempoEstimado,
//     required this.region,
//     required this.polyline,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'nombre': nombre,
//       'imagenes': imagenes,
//       'descripcion': descripcion,
//       'tiempoEstimado': tiempoEstimado,
//       'region': {
//         'southWest': {
//           'lat': region.southWest.latitude,
//           'lng': region.southWest.longitude
//         },
//         'northEast': {
//           'lat': region.northEast.latitude,
//           'lng': region.northEast.longitude
//         },
//       },
//       'polyline': polyline
//           .map((point) => {'lat': point.latitude, 'lng': point.longitude})
//           .toList(),
//     };
//   }

//   static Lugar fromMap(Map<String, dynamic> map) {
//     return Lugar(
//       nombre: map['nombre'],
//       imagenes: List<String>.from(map['imagenes']),
//       descripcion: map['descripcion'],
//       tiempoEstimado: map['tiempoEstimado'],
//       region: LatLngBounds(
//         LatLng(map['region']['southWest']['lat'],
//             map['region']['southWest']['lng']),
//         LatLng(map['region']['northEast']['lat'],
//             map['region']['northEast']['lng']),
//       ),
//       polyline: (map['polyline'] as List)
//           .map((point) => LatLng(point['lat'], point['lng']))
//           .toList(),
//     );
//   }
// }

List<Categorias> categoriaData = [
  Categorias(
    name: 'Naturalesa   ',
    // icon: Icons.nature_people,
    icon: Icons.wifi_channel_rounded,
    // icon: 'assets/iconos/naturaleza.webp',
    lugares: [
      Lugar(
        nombre: 'Catarata Tsomontonari',
        imagenes: [
          'assets/rioNegro/TSOMONTONARI/tsomontonari1.webp',
          'assets/rioNegro/TSOMONTONARI/tsomontonari2.webp',
          'assets/rioNegro/TSOMONTONARI/tsomontonari3.webp',
          'assets/rioNegro/TSOMONTONARI/tsomontonari4.webp',
          'assets/rioNegro/TSOMONTONARI/tsomontonari5.webp',
          'assets/rioNegro/TSOMONTONARI/tsomontonari6.webp',
          'assets/rioNegro/TSOMONTONARI/tsomontonari7.webp',
        ],
        descripcion:
            'Formada por dos torrenteras de agua cristalina. La primera presenta una caída aproximada de 70 metros y es conocida como "El Manto de la Virgen".'
            'La segunda, de menor tamaño pero de mayor caudal es la llamada Tsomontonari, tiene 40 m. de altura y tres niveles, la última de ellas y la'
            'principal presenta gradas naturales por donde se puede acceder a la parte alta de la catarata. El río formado por estas cataratas presenta pozas de gran tamaño'
            ' y profundidad (8 mt), en la que es posible bañarse. Las que se encuentran en la base de la catarata son las menos profundas, tienen un promedio de 6 m de ancho x 14 m de largo y 1 m de profundidad.',
        tiempoEstimado: 'A 1 hora y 20 minutos',
        region:
            LatLngBounds(LatLng(-11.009, -74.675), LatLng(-11.209, -74.659)),
        polyline: [
          LatLng(-11.20857695048312, -74.66021205752597),
          LatLng(-11.208179891588912, -74.66050527274929),
          LatLng(-11.208256410411309, -74.66053884512215),
          LatLng(-11.20159761528555, -74.66514763988471),
          LatLng(-11.200831830867827, -74.66532150827682),
          LatLng(-11.200231099757772, -74.66527293279522),
          LatLng(-11.18677475007047, -74.66205257712815),
          //LatLng(),
          LatLng(-11.186045369082265, -74.66153869306886),
          LatLng(-11.182625044000574, -74.65586234894447),
          LatLng(-11.182453445002068, -74.65517283034488),
          LatLng(-11.182374037385486, -74.65445509339779),
          LatLng(-11.1819623421748, -74.65399060843542),
          LatLng(-11.181044048577377, -74.65378212708488),
          LatLng(-11.180179169911057, -74.65425886301459),
          //balle azul:
          LatLng(-11.179897455473125, -74.65460755018661),
          //
          LatLng(-11.179776476016741, -74.65537498595666),
          LatLng(-11.17983596883505, -74.6560760681867),
          LatLng(-11.179740533592607, -74.65634011638751),
          LatLng(-11.179094751034867, -74.65659739645322),
          LatLng(-11.178723245453654, -74.65710102887864),
          LatLng(-11.178705707053695, -74.658172282545),
          LatLng(-11.178396317742454, -74.65853954295598),
          LatLng(-11.177141929562737, -74.65843218048998),
          LatLng(-11.173797553928011, -74.65903457034341),
          LatLng(-11.168853089222566, -74.66078266044741),
          LatLng(-11.147811277017894, -74.6648619097495),
          LatLng(-11.146170408764618, -74.66548743082232),
          //Villa Cpiri
          LatLng(-11.130454665364695, -74.67398335859723),
          LatLng(-11.125717709532523, -74.67641128919632),
          LatLng(-11.124931413043072, -74.67735465004085),
          LatLng(-11.12403609638855, -74.68007587390318),
          LatLng(-11.123110461805751, -74.68104887301706),
          LatLng(-11.117064144315009, -74.68367323152658),
          //Unión Capiri
          LatLng(-11.094972222290522, -74.70135809535316),
          //Yavirironi
          LatLng(-11.088049013305792, -74.70690188994469),
          LatLng(-11.075108692120153, -74.71723445101554),
          LatLng(-11.074246925893206, -74.71762642644943),
          LatLng(-11.068204453752614, -74.71878674414818),
          LatLng(-11.067560782294848, -74.71903248327939),
          LatLng(-11.066855547389096, -74.71942646468972),
          LatLng(-11.063696227201746, -74.72187320566304),
          LatLng(-11.063150762162849, -74.72280777724922),
          LatLng(-11.063231568085982, -74.72454770921513),
          LatLng(-11.06318014695131, -74.72505470432128),
          LatLng(-11.063070791028721, -74.72544908433197),
          LatLng(-11.062829992963799, -74.72584810836838),
          //Entrda a Sanjuan de Cheni
          LatLng(-11.062029542454368, -74.7266998727521),
          LatLng(-11.060774598020359, -74.72790577268702),
          LatLng(-11.059617227311463, -74.72952225533379),
          LatLng(-11.059291960858943, -74.73048129687592),
          LatLng(-11.058814666043148, -74.73363144485019),
          LatLng(-11.058675675048931, -74.73381797289262),
          LatLng(-11.058512959812646, -74.73395889014685),
          LatLng(-11.058286833100595, -74.7340780801637),
          LatLng(-11.05689704652707, -74.73444581264958),
          LatLng(-11.05602885041101, -74.73474786605148),
          LatLng(-11.055652229745604, -74.7350180429549),
          LatLng(-11.055652229745604, -74.73547169694282),
          LatLng(-11.055152238103545, -74.7356403975524),
          LatLng(-11.055122362880425, -74.73596840261031),
          LatLng(-11.05511101897882, -74.73768150923802),
          LatLng(-11.055065684222157, -74.73840744007815),
          LatLng(-11.05496241715879, -74.73867692543074),
          LatLng(-11.054809737825835, -74.73886903605175),
          LatLng(-11.05461186056776, -74.7390149669661),
          LatLng(-11.054380786108155, -74.73912275153513),
          LatLng(-11.052336407488923, -74.73968590587984),
          LatLng(-11.051978776802784, -74.73988802717928),
          LatLng(-11.051747266513544, -74.74010445515376),
          LatLng(-11.051518577004742, -74.74041068220706),
          LatLng(-11.04991484210943, -74.74281759050882),
          LatLng(-11.049684402821, -74.74306324706731),
          LatLng(-11.049474096578862, -74.74320919406217),
          LatLng(-11.049205593648551, -74.7433262410819),
          LatLng(-11.0478859570608, -74.74358285164571),
          LatLng(-11.047424542365576, -74.74376308275046),
          LatLng(-11.047022614399694, -74.7441003970107),
          //Boca del chenic
          LatLng(-11.045173060634951, -74.74607138322052),
          LatLng(-11.044823359198972, -74.74643439286577),
          LatLng(-11.044416065109772, -74.74671843006692),
          LatLng(-11.039399680118365, -74.74925789921713),
          LatLng(-11.037723919319546, -74.75067440041886),
          LatLng(-11.036966858499994, -74.75116658205904),
          LatLng(-11.036316337570952, -74.75122501140966),
          LatLng(-11.036316337570952, -74.7512898485348),
          LatLng(-11.035275733600827, -74.75165392636131),
          LatLng(-11.031162550700842, -74.75094341137208),
          LatLng(-11.029831617078358, -74.75085973988384),
          LatLng(-11.02468623914767, -74.75107779616567),
          LatLng(-11.023694818702367, -74.75132436302773),
          LatLng(-11.023297921113013, -74.75148089291966),
          LatLng(-11.02302500051691, -74.75152808637222),
          LatLng(-11.02287882794235, -74.75150826261647),
          LatLng(-11.022690768706866, -74.75144532328115),
          LatLng(-11.022560491932069, -74.75128489381238),
          LatLng(-11.021698519549787, -74.74991074813377),
          LatLng(-11.02156020269689, -74.74979219646933),
          //Puente IPOKI
          LatLng(-11.021446853377427, -74.74975092795037),
          LatLng(-11.02144483086876, -74.74965102098218),
          LatLng(-11.021326743294637, -74.7494904310465),
          LatLng(-11.020671408664782, -74.74898157675878),
          LatLng(-11.020195640432703, -74.74892555328975),
          LatLng(-11.019465085667164, -74.74882769855148),
          LatLng(-11.018487837208895, -74.74910614773947),
          LatLng(-11.018308610343112, -74.74908058706023),
          LatLng(-11.018261835744312, -74.74911168272875),
          LatLng(-11.018099885292827, -74.74930229274818),
          LatLng(-11.017994773020447, -74.7493905464042),
          LatLng(-11.017769043209015, -74.74952334958424),
          LatLng(-11.017537860715137, -74.74969563724348),
          LatLng(-11.017024442624717, -74.75021602405128),
          LatLng(-11.016855041056658, -74.75029535855337),
          LatLng(-11.016755981256722, -74.75028349321109),
          LatLng(-11.016678978525661, -74.75024098330712),
          LatLng(-11.01660678588135, -74.75017425233268),
          LatLng(-11.016285667957362, -74.74976531347625),
          LatLng(-11.015858654076354, -74.74934525810625),
          LatLng(-11.015678830169634, -74.74923473265574),
          LatLng(-11.0153617218852, -74.74897527404231),
          LatLng(-11.0153082922035, -74.74889475451806),
          LatLng(-11.015279377879608, -74.74881732432397),
          LatLng(-11.015241352269669, -74.74850153241796),
          LatLng(-11.01520210145624, -74.74844813914113),
          LatLng(-11.01505871020268, -74.74840937429292),
          LatLng(-11.014953660559073, -74.74831750826777),
          LatLng(-11.01488189578653, -74.74814890871681),
          LatLng(-11.014821726280786, -74.74789708486205),
          LatLng(-11.014755843091137, -74.7478108440217),
          LatLng(-11.014479793957335, -74.74768300035399),
          LatLng(-11.014374874357443, -74.74768266969805),
          LatLng(-11.014062760317742, -74.74775619109302),
          LatLng(-11.013996245466402, -74.7477335417897),
          LatLng(-11.01395803264279, -74.74770021589666),
          LatLng(-11.013896058563063, -74.74754341291934),
          LatLng(-11.013866839367267, -74.74750746092421),
          LatLng(-11.013799108484676, -74.74747578403384),
          LatLng(-11.01371913222492, -74.74747055018305),
          LatLng(-11.01352415514242, -74.74750752380467),
          LatLng(-11.01346663059995, -74.74747403149847),
          LatLng(-11.013324741160062, -74.74715250319394),
          LatLng(-11.013161730310827, -74.74699622976193),
          LatLng(-11.01314404150196, -74.74693543447268),
          LatLng(-11.013182917732934, -74.74671864549222),
          LatLng(-11.013235215651363, -74.74656531717926),
          LatLng(-11.013294784041562, -74.74648876623395),
          LatLng(-11.013412691724497, -74.74639848324362),
          LatLng(-11.013489502994418, -74.74636647165181),
          LatLng(-11.013698616258878, -74.74632632365838),
          LatLng(-11.013746820007327, -74.74630065258631),
          LatLng(-11.01381901372045, -74.74619716899068),
          LatLng(-11.013915015618664, -74.74594759334838),
          LatLng(-11.013991992359607, -74.74584478192126),
          LatLng(-11.014063026995217, -74.74579179850582),
          //LatLng(-74.74579179850582, -74.7457370999664),
          LatLng(-11.01438392737883, -74.74567290593248),
          LatLng(-11.014456174865003, -74.74557595338814),
          LatLng(-11.014519061966624, -74.74527645855437),
          LatLng(-11.014542815277068, -74.74521899542646),
          LatLng(-11.01459990038245, -74.74517349202053),
          LatLng(-11.015070122793446, -74.74496283353682),
          LatLng(-11.015097025995956, -74.7449177045526),
          LatLng(-11.015063012177961, -74.74456929422817),
          LatLng(-11.015070810297544, -74.7445286182606),
          LatLng(-11.015188400230443, -74.7443421237104),
          LatLng(-11.015191729020046, -74.74429773150776),
          LatLng(-11.015166475020521, -74.74421079143463),
          LatLng(-11.015155480546582, -74.74415311558091),
          LatLng(-11.015168456442012, -74.74404942787727),
          LatLng(-11.015244377065287, -74.74381960821647),
          LatLng(-11.015306128151892, -74.74371748854755),
          LatLng(-11.015392927230721, -74.74364353115048),
          LatLng(-11.0154199067792, -74.7436001255867),
          LatLng(-11.015440358170054, -74.74354296240097),
          LatLng(-11.015438415001086, -74.74348123286762),
          LatLng(-11.015463244166398, -74.74342313557862),
          LatLng(-11.015525756432254, -74.7433541812696),
          LatLng(-11.015814888038193, -74.74313294993603),
          LatLng(-11.015853713028605, -74.74306649345415),
          LatLng(-11.01590554053793, -74.74265494570034),
          LatLng(-11.016021229563762, -74.74238130847114),
          LatLng(-11.016010929317616, -74.7421858440643),
          LatLng(-11.016022304521627, -74.74213284909463),
          LatLng(-11.016052258923693, -74.7420827433894),
          LatLng(-11.01628080708187, -74.7418504823621),
          LatLng(-11.016448636735731, -74.74149352102852),
          LatLng(-11.016615181378313, -74.74121213694559),
          LatLng(-11.016889662233012, -74.74060060784683),
          LatLng(-11.016998650054077, -74.74039924707955),
          LatLng(-11.017033668357413, -74.74022669691564),
          LatLng(-11.017038090130484, -74.74001245931461),
          LatLng(-11.017217639023187, -74.73974514051825),
          LatLng(-11.017220822121601, -74.73966535509193),
          LatLng(-11.01709961332773, -74.7394682455728),
          LatLng(-11.017110436248828, -74.73936171315073),
          LatLng(-11.0171511441485, -74.73929264471974),
          LatLng(-11.017219865654425, -74.73903246771931),
          LatLng(-11.01726671994382, -74.73893194983872),
          LatLng(-11.017285752475985, -74.73860461864355),
          LatLng(-11.01739292097784, -74.73817528323856),
          LatLng(-11.017364676675939, -74.73800351803447),
          LatLng(-11.017345169838876, -74.737964597925),
          LatLng(-11.017302755393615, -74.73795214803201),
          LatLng(-11.017109368758852, -74.7379934773821),
          LatLng(-11.017017544066235, -74.73798590738558),
          LatLng(-11.016983968265706, -74.73797776803274),
          LatLng(-11.016931794814468, -74.73789498747162),
          LatLng(-11.016873452191675, -74.73760377708254),
          LatLng(-11.016878196163631, -74.73737655186545),
          LatLng(-11.016937736212157, -74.73716684729047),
          LatLng(-11.017026757034117, -74.73695437055504),
          LatLng(-11.01705283814475, -74.73676453210764),
          LatLng(-11.017051736775798, -74.73654384366388),
          LatLng(-11.017110711915919, -74.73633861310654),
          LatLng(-11.0175390029667, -74.73544964560912),
          LatLng(-11.017712983061728, -74.73533098434827),
          LatLng(-11.017761209417387, -74.73528167359208),
          LatLng(-11.017784743306294, -74.7352289394179),
          LatLng(-11.017805556103497, -74.73506044154705),
          LatLng(-11.01785791937617, -74.73495713023875),
          LatLng(-11.018409673388533, -74.73431133509159),
          LatLng(-11.0185034051769, -74.73415162412878),
          LatLng(-11.018850190682258, -74.73392233028193),
          LatLng(-11.01899005621162, -74.73378084588047),
          LatLng(-11.01915486088241, -74.73352611814465),
          LatLng(-11.01989820354784, -74.73262225791983),
          LatLng(-11.020298570350462, -74.73206677436875),
          LatLng(-11.02043860313239, -74.73180028014309),
          LatLng(-11.020524244133398, -74.73157932431612),
          LatLng(-11.020797502372659, -74.73061006538539),
          LatLng(-11.020922492858588, -74.72992122871455),
          LatLng(-11.020921966527908, -74.72978236801195),
          LatLng(-11.020820687510593, -74.7294133538801),
          LatLng(-11.020820968642099, -74.72933815164137),
          LatLng(-11.020876892808019, -74.72912414895605),
          LatLng(-11.020899113446887, -74.72899124398678),
          LatLng(-11.02083937700479, -74.72884907810393),
          LatLng(-11.020477729477378, -74.72860024008524),
          LatLng(-11.020391920500316, -74.72851696869839),
          LatLng(-11.02032932868444, -74.72840297489275),
          LatLng(-11.020288443109777, -74.72819453619225),
          LatLng(-11.020278594416723, -74.72797010886163),
          LatLng(-11.020361424973842, -74.72765931903159),
          LatLng(-11.020361424973842, -74.72765931903159),
          LatLng(-11.020553523770104, -74.7274623955977),
          LatLng(-11.020629673119146, -74.72744834844393),
          LatLng(-11.021102704509062, -74.72745999172997),
          LatLng(-11.021502290659129, -74.72740678944699),
          LatLng(-11.02166717183816, -74.72741564279198),
          LatLng(-11.021763039185714, -74.72738107284502),
          LatLng(-11.022037400706267, -74.72723797588854),
          LatLng(-11.022145960386155, -74.72721979278882),
          LatLng(-11.02239345190658, -74.72723801216702),
          LatLng(-11.022872730377202, -74.7273928633818),
          LatLng(-11.023365714469548, -74.72751163639995),
          LatLng(-11.023414403422265, -74.72749137551219),
          LatLng(-11.023451517769203, -74.72741143173818),
          LatLng(-11.023514767700433, -74.72696342253722),
          LatLng(-11.023584109498287, -74.72672578401043),
          LatLng(-11.023607479057674, -74.72667098831741),
          LatLng(-11.02378971100282, -74.7265080965181),
          LatLng(-11.023902878282684, -74.72644528607921),
          LatLng(-11.024122912759154, -74.72641046689519),
          LatLng(-11.024560601198417, -74.72648849350209),
          LatLng(-11.024813443234294, -74.72649702640553),
          LatLng(-11.025240916114797, -74.72641952788888),
          LatLng(-11.025471209346264, -74.72641209319569),
          LatLng(-11.026380685034297, -74.72615250366346),
          LatLng(-11.02730508703624, -74.72551952775797),
          LatLng(-11.027490377475942, -74.72541867969488),
          LatLng(-11.027630137169169, -74.72543734164775),
          LatLng(-11.02788078398477, -74.72558879092892),
          LatLng(-11.028241146396937, -74.72553097635681),
          LatLng(-11.028425698734083, -74.72535530709166),
          LatLng(-11.028577537733852, -74.72504780613626),
          LatLng(-11.028794399617865, -74.72474784797323),
          LatLng(-11.028858246818004, -74.72461682386125),
          LatLng(-11.028886925191117, -74.72444713412403),
          LatLng(-11.028867946117117, -74.72421334288846),
          LatLng(-11.02888272878073, -74.72412280997402),
          LatLng(-11.029057601028356, -74.7238704666103),
          LatLng(-11.029056537783703, -74.72380839267282),
          LatLng(-11.02891618489761, -74.72359593034189),
          LatLng(-11.028806671957966, -74.72328965009706),
          LatLng(-11.028757245300255, -74.72302665981256),
          LatLng(-11.02870181618816, -74.72294865759785),
          LatLng(-11.028439171429625, -74.72277946890495),
          LatLng(-11.028102157457369, -74.7225236883105),
          LatLng(-11.027930607883988, -74.72246579277997),
          LatLng(-11.02780174559004, -74.72246288626344),
          LatLng(-11.027586776884036, -74.72250567624728),
          LatLng(-11.027472344252502, -74.72250335331536),
          LatLng(-11.027360275740477, -74.72245357048125),
          LatLng(-11.027327359482726, -74.72239837660631),
          LatLng(-11.027256146088362, -74.7221692877986),
          LatLng(-11.027166502229122, -74.72203157714766),
          LatLng(-11.02713797278102, -74.72194810237619),
          LatLng(-11.027161721368358, -74.72133228384018),
          LatLng(-11.027065052244808, -74.72117311447778),
          LatLng(-11.027074962351392, -74.72095362692619),
          LatLng(-11.027047818042362, -74.72090631843072),
          LatLng(-11.026912634456977, -74.72079474014933),
          LatLng(-11.026865756383302, -74.7206749458347),
          LatLng(-11.026864396131714, -74.72051438924862),
          LatLng(-11.02689504365884, -74.72034371889897),
          LatLng(-11.02684245418095, -74.72017484568303),
          LatLng(-11.026844893854573, -74.72007727466898),
          LatLng(-11.02686137976562, -74.72000344155268),
          LatLng(-11.026908534839933, -74.71992245378544),
          LatLng(-11.027084984914637, -74.71969229748709),
          LatLng(-11.02711347308302, -74.71961719158834),
          LatLng(-11.027116541136508, -74.71956023099277),
          LatLng(-11.027074924061992, -74.71951313941314),
          LatLng(-11.026981674503261, -74.71948666541816),
          LatLng(-11.026572280124697, -74.71944890625872),
          LatLng(-11.02645243902046, -74.71941189678043),
          LatLng(-11.026414149026976, -74.71939021228933),
          LatLng(-11.026345171947511, -74.71921145542399),
          //Tsomontonari
          LatLng(-11.026093158010696, -74.71897013916256),
          LatLng(-11.026194255883254, -74.7187004033017),
          LatLng(-11.026170153347152, -74.71832534437944),
          LatLng(-11.026184967645293, -74.71811117857443),
          LatLng(-11.026162566212705, -74.71784018149586),
          LatLng(-11.02616187212449, -74.71761990271987),
          LatLng(-11.026210922868543, -74.71736670918457),
          LatLng(-11.026210233898013, -74.71706930015364),
          LatLng(-11.026146872880801, -74.71677688201441),
          LatLng(-11.02609230948272, -74.71665171288552),
          LatLng(-11.026072983492483, -74.71653105761496),
          LatLng(-11.02613571867741, -74.71630012964366),
          LatLng(-11.02617968549336, -74.71618828556832),
          LatLng(-11.026171684901968, -74.71605949662762),
          LatLng(-11.026097793678332, -74.71591983471046),
          LatLng(-11.025947318788354, -74.71579753327633),
          LatLng(-11.025800219420404, -74.71554288086129),
          LatLng(-11.025768764356698, -74.71540843890907),
          LatLng(-11.0257870481541, -74.7152573955822),
          LatLng(-11.025989485373884, -74.71460149568595),
          LatLng(-11.026034592242624, -74.71426902811214),
          LatLng(-11.026194382303075, -74.71347268552012),
          LatLng(-11.026348112228632, -74.71292714331607),
          LatLng(-11.026938173293843, -74.71212573134893),
          LatLng(-11.027091661681325, -74.71179788696753),
          LatLng(-11.027551872624755, -74.71129684206198),
          LatLng(-11.02787315692835, -74.71107307077203),
          LatLng(-11.028028691531574, -74.71099853390064),
          LatLng(-11.02876102540408, -74.71072543442658),
          LatLng(-11.02909842471972, -74.71062267420731),
          LatLng(-11.029497590381737, -74.71050760858513),
          LatLng(-11.0296981269057, -74.71042345249299),
          LatLng(-11.029860502622427, -74.71036829230499),
          LatLng(-11.03009532000668, -74.71033600252333),
          LatLng(-11.030502272279122, -74.71037083955913),
          LatLng(-11.03067130500908, -74.71035683944342),
          LatLng(-11.030873186292283, -74.7102968074815),
          LatLng(-11.031101248192783, -74.71015470352975),
          LatLng(-11.03127266188416, -74.71006633864395),
        ],
      ),
      Lugar(
        nombre: 'Cascada Inkani',
        imagenes: [
          'assets/rioNegro/CASCADA_INKANI_YAVIRIRONI/inkani1.webp',
          'assets/rioNegro/CASCADA_INKANI_YAVIRIRONI/inkani2.webp',
          'assets/rioNegro/CASCADA_INKANI_YAVIRIRONI/inkani3.webp',
          'assets/rioNegro/CASCADA_INKANI_YAVIRIRONI/inkani4.webp',
          'assets/rioNegro/CASCADA_INKANI_YAVIRIRONI/inkani5.webp',
          'assets/rioNegro/CASCADA_INKANI_YAVIRIRONI/inkani6.webp',
          'assets/rioNegro/CASCADA_INKANI_YAVIRIRONI/inkani7.webp',
        ],
        //imagen: 'assets/rioNegro/CASCADA_INKANI_YAVIRIRONI/inkani1.JPG',
        descripcion:
            'Formada por dos torrenteras de agua cristalina. La primera presenta una caída aproximada de 70 metros y es conocida como "El Manto de la Virgen".'
            'La segunda, de menor tamaño pero de mayor caudal es la llamada Tsomontonari, tiene 40 m. de altura y tres niveles, la última de ellas y la'
            'principal presenta gradas naturales por donde se puede acceder a la parte alta de la catarata. El río formado por estas cataratas presenta pozas de gran tamaño'
            ' y profundidad (8 mt), en la que es posible bañarse. Las que se encuentran en la base de la catarata son las menos profundas, tienen un promedio de 6 m de ancho x 14 m de largo y 1 m de profundidad.',
        tiempoEstimado: 'A 1 hora',
        region:
            LatLngBounds(LatLng(-11.009, -74.675), LatLng(-11.209, -74.659)),
        polyline: [
          LatLng(-11.20857695048312, -74.66021205752597),
          LatLng(-11.208179891588912, -74.66050527274929),
          LatLng(-11.208256410411309, -74.66053884512215),
          LatLng(-11.20159761528555, -74.66514763988471),
          LatLng(-11.200831830867827, -74.66532150827682),
          LatLng(-11.200231099757772, -74.66527293279522),
          LatLng(-11.18677475007047, -74.66205257712815),
          //LatLng(),
          LatLng(-11.186045369082265, -74.66153869306886),
          LatLng(-11.182625044000574, -74.65586234894447),
          LatLng(-11.182453445002068, -74.65517283034488),
          LatLng(-11.182374037385486, -74.65445509339779),
          LatLng(-11.1819623421748, -74.65399060843542),
          LatLng(-11.181044048577377, -74.65378212708488),
          LatLng(-11.180179169911057, -74.65425886301459),
          //balle azul:
          LatLng(-11.179897455473125, -74.65460755018661),
        ],
      ),
      Lugar(
        nombre: 'Catarata Canuja',
        imagenes: [
          'assets/rioNegro/CATARATA_CANUJA_LAGUNA _AZUL/canuja1.webp',
          'assets/rioNegro/CATARATA_CANUJA_LAGUNA _AZUL/canuja2.webp',
          'assets/rioNegro/CATARATA_CANUJA_LAGUNA _AZUL/canuja3.webp',
          'assets/rioNegro/CATARATA_CANUJA_LAGUNA _AZUL/canuja4.webp',
          'assets/rioNegro/CATARATA_CANUJA_LAGUNA _AZUL/canuja5.webp',
        ],
        //imagen: 'assets/rioNegro/CATARATA_CANUJA_LAGUNA _AZUL/canuja1.jpg',
        descripcion:
            'Formada por dos torrenteras de agua cristalina. La primera presenta una caída aproximada de 70 metros y es conocida como "El Manto de la Virgen".'
            'La segunda, de menor tamaño pero de mayor caudal es la llamada Tsomontonari, tiene 40 m. de altura y tres niveles, la última de ellas y la'
            'principal presenta gradas naturales por donde se puede acceder a la parte alta de la catarata. El río formado por estas cataratas presenta pozas de gran tamaño'
            ' y profundidad (8 mt), en la que es posible bañarse. Las que se encuentran en la base de la catarata son las menos profundas, tienen un promedio de 6 m de ancho x 14 m de largo y 1 m de profundidad.',

        tiempoEstimado: 'A 45 minutos',
        region:
            LatLngBounds(LatLng(-11.009, -74.675), LatLng(-11.209, -74.659)),
        polyline: [LatLng(-11.209, -74.659), LatLng(-11.201, -74.665)],
      ),
      // Lugar(
      //   nombre: 'Catarata Huahuari',
      //   imagenes: [
      //     'assets/rioNegro/CATARATA_HUAHUARI/huahuari1.webp',
      //     'assets/rioNegro/CATARATA_HUAHUARI/huahuari2.webp',
      //     'assets/rioNegro/CATARATA_HUAHUARI/huahuari3.webp',
      //     'assets/rioNegro/CATARATA_HUAHUARI/huahuari4.webp',
      //     'assets/rioNegro/CATARATA_HUAHUARI/huahuari5.webp',
      //   ],
      //   //imagen: 'assets/rioNegro/CATARATA_HUAHUARI/huahuari1.jpg',
      //   descripcion:
      //       'Formada por dos torrenteras de agua cristalina. La primera presenta una caída aproximada de 70 metros y es conocida como "El Manto de la Virgen".'
      //       'La segunda, de menor tamaño pero de mayor caudal es la llamada Tsomontonari, tiene 40 m. de altura y tres niveles, la última de ellas y la'
      //       'principal presenta gradas naturales por donde se puede acceder a la parte alta de la catarata. El río formado por estas cataratas presenta pozas de gran tamaño'
      //       ' y profundidad (8 mt), en la que es posible bañarse. Las que se encuentran en la base de la catarata son las menos profundas, tienen un promedio de 6 m de ancho x 14 m de largo y 1 m de profundidad.',

      //   tiempoEstimado: '1.5 horas',
      //   region:
      //       LatLngBounds(LatLng(-11.009, -74.675), LatLng(-11.209, -74.659)),
      //   polyline: [LatLng(-11.209, -74.659), LatLng(-11.201, -74.665)],
      // ),

      // Lugar(
      //   nombre: 'Caverna Ashaninka',
      //   imagenes: [
      //     //'assets/rioNegro/CAVERNA_ASHANINKA/caverna1.jpg',
      //     'assets/rioNegro/CAVERNA_ASHANINKA/caverna2.webp',
      //     'assets/rioNegro/CAVERNA_ASHANINKA/caverna3.webp',
      //     'assets/rioNegro/CAVERNA_ASHANINKA/caverna4.webp',
      //     'assets/rioNegro/CAVERNA_ASHANINKA/caverna5.webp',
      //     'assets/rioNegro/CAVERNA_ASHANINKA/caverna6.webp',
      //     'assets/rioNegro/CAVERNA_ASHANINKA/caverna7.webp',
      //   ],
      //   //imagen: 'assets/rioNegro/CAVERNA_ASHANINKA/caverna2.JPG',
      //   descripcion:
      //       'Formada por dos torrenteras de agua cristalina. La primera presenta una caída aproximada de 70 metros y es conocida como "El Manto de la Virgen".'
      //       'La segunda, de menor tamaño pero de mayor caudal es la llamada Tsomontonari, tiene 40 m. de altura y tres niveles, la última de ellas y la'
      //       'principal presenta gradas naturales por donde se puede acceder a la parte alta de la catarata. El río formado por estas cataratas presenta pozas de gran tamaño'
      //       ' y profundidad (8 mt), en la que es posible bañarse. Las que se encuentran en la base de la catarata son las menos profundas, tienen un promedio de 6 m de ancho x 14 m de largo y 1 m de profundidad.',

      //   tiempoEstimado: 'A 45 minutos',
      //   region:
      //       LatLngBounds(LatLng(-11.009, -74.675), LatLng(-11.209, -74.659)),
      //   polyline: [LatLng(-11.209, -74.659), LatLng(-11.201, -74.665)],
      // ),
      // Lugar(
      //   nombre: 'Caverna Nueva Italia',
      //   imagenes: [
      //     'assets/rioNegro/CAVERNA_NUEVA_ITALIA/italia1.webp',
      //     'assets/rioNegro/CAVERNA_NUEVA_ITALIA/italia2.webp',
      //     'assets/rioNegro/CAVERNA_NUEVA_ITALIA/italia3.webp',
      //     'assets/rioNegro/CAVERNA_NUEVA_ITALIA/italia4.webp',
      //     'assets/rioNegro/CAVERNA_NUEVA_ITALIA/italia5.webp',
      //     'assets/rioNegro/CAVERNA_NUEVA_ITALIA/italia6.webp',
      //     'assets/rioNegro/CAVERNA_NUEVA_ITALIA/italia7.webp',
      //     'assets/rioNegro/CAVERNA_NUEVA_ITALIA/italia8.webp',
      //     'assets/rioNegro/CAVERNA_NUEVA_ITALIA/italia9.webp',
      //     'assets/rioNegro/CAVERNA_NUEVA_ITALIA/italia10.webp',
      //   ],
      //   //imagen: 'assets/rioNegro/CAVERNA_NUEVA_ITALIA/italia1.jpeg',
      //   descripcion:
      //       'Formada por dos torrenteras de agua cristalina. La primera presenta una caída aproximada de 70 metros y es conocida como "El Manto de la Virgen".'
      //       'La segunda, de menor tamaño pero de mayor caudal es la llamada Tsomontonari, tiene 40 m. de altura y tres niveles, la última de ellas y la'
      //       'principal presenta gradas naturales por donde se puede acceder a la parte alta de la catarata. El río formado por estas cataratas presenta pozas de gran tamaño'
      //       ' y profundidad (8 mt), en la que es posible bañarse. Las que se encuentran en la base de la catarata son las menos profundas, tienen un promedio de 6 m de ancho x 14 m de largo y 1 m de profundidad.',

      //   tiempoEstimado: 'A 45 minutos',
      //   region:
      //       LatLngBounds(LatLng(-11.009, -74.675), LatLng(-11.209, -74.659)),
      //   polyline: [LatLng(-11.209, -74.659), LatLng(-11.201, -74.665)],
      // ),
      // Lugar(
      //   nombre: 'Cascada Nueva Italia',
      //   imagenes: [
      //     'assets/rioNegro/CAVERNA_NUEVA_ITALIA/CASCADA_NUEVA _ITALIA/cascadaitalia1.webp',
      //     'assets/rioNegro/CAVERNA_NUEVA_ITALIA/CASCADA_NUEVA _ITALIA/cascadaitalia2.webp',
      //   ],
      //   //imagen:
      //   //    'assets/rioNegro/CAVERNA_NUEVA_ITALIA/CASCADA_NUEVA _ITALIA/cascadaItalia1.JPG',
      //   descripcion:
      //       'Formada por dos torrenteras de agua cristalina. La primera presenta una caída aproximada de 70 metros y es conocida como "El Manto de la Virgen".'
      //       'La segunda, de menor tamaño pero de mayor caudal es la llamada Tsomontonari, tiene 40 m. de altura y tres niveles, la última de ellas y la'
      //       'principal presenta gradas naturales por donde se puede acceder a la parte alta de la catarata. El río formado por estas cataratas presenta pozas de gran tamaño'
      //       ' y profundidad (8 mt), en la que es posible bañarse. Las que se encuentran en la base de la catarata son las menos profundas, tienen un promedio de 6 m de ancho x 14 m de largo y 1 m de profundidad.',

      //   tiempoEstimado: '1.5 horas',
      //   region:
      //       LatLngBounds(LatLng(-11.009, -74.675), LatLng(-11.209, -74.659)),
      //   polyline: [LatLng(-11.209, -74.659), LatLng(-11.201, -74.665)],
      // ),
      // Lugar(
      //   nombre: 'Cueva Vanhellsing',
      //   imagenes: [
      //     'assets/rioNegro/CAVERNA_VANHELLSING_UNION_HUANCAYO_HUAHARI/vanhellsing1.webp',
      //     'assets/rioNegro/CAVERNA_VANHELLSING_UNION_HUANCAYO_HUAHARI/vanhellsing2.webp',
      //     'assets/rioNegro/CAVERNA_VANHELLSING_UNION_HUANCAYO_HUAHARI/vanhellsing3.webp',
      //     'assets/rioNegro/CAVERNA_VANHELLSING_UNION_HUANCAYO_HUAHARI/vanhellsing4.webp',
      //     'assets/rioNegro/CAVERNA_VANHELLSING_UNION_HUANCAYO_HUAHARI/vanhellsing5.webp',
      //   ],
      //   //imagen:
      //   //    'assets/rioNegro/CAVERNA_VANHELLSING_UNION_HUANCAYO_HUAHARI/vanhellsing1.jpg',
      //   descripcion:
      //       'Formada por dos torrenteras de agua cristalina. La primera presenta una caída aproximada de 70 metros y es conocida como "El Manto de la Virgen".'
      //       'La segunda, de menor tamaño pero de mayor caudal es la llamada Tsomontonari, tiene 40 m. de altura y tres niveles, la última de ellas y la'
      //       'principal presenta gradas naturales por donde se puede acceder a la parte alta de la catarata. El río formado por estas cataratas presenta pozas de gran tamaño'
      //       ' y profundidad (8 mt), en la que es posible bañarse. Las que se encuentran en la base de la catarata son las menos profundas, tienen un promedio de 6 m de ancho x 14 m de largo y 1 m de profundidad.',

      //   tiempoEstimado: '1.5 horas',
      //   region: LatLngBounds(LatLng(-11.178, -74.619),
      //       LatLng(-11.344, -74.554)), //superior derecho, inferior izquierdo
      //   polyline: [LatLng(-11.209, -74.659), LatLng(-11.329, -74.531)],
      // ),
      // Lugar(
      //   nombre: 'Catarata Ambitarini',
      //   imagenes: [
      //     'assets/rioNegro/CERRO_SOMBRERO_CATARATA_AMBITARINI/ambitarini1.webp',
      //     'assets/rioNegro/CERRO_SOMBRERO_CATARATA_AMBITARINI/ambitarini2.webp',
      //     'assets/rioNegro/CERRO_SOMBRERO_CATARATA_AMBITARINI/ambitarini3.webp',
      //     'assets/rioNegro/CERRO_SOMBRERO_CATARATA_AMBITARINI/ambitarini4.webp',
      //   ],
      //   //imagen:
      //   //    'assets/rioNegro/CERRO_SOMBRERO_CATARATA_AMBITARINI/ambitarini1.jpg',
      //   descripcion:
      //       'Formada por dos torrenteras de agua cristalina. La primera presenta una caída aproximada de 70 metros y es conocida como "El Manto de la Virgen".'
      //       'La segunda, de menor tamaño pero de mayor caudal es la llamada Tsomontonari, tiene 40 m. de altura y tres niveles, la última de ellas y la'
      //       'principal presenta gradas naturales por donde se puede acceder a la parte alta de la catarata. El río formado por estas cataratas presenta pozas de gran tamaño'
      //       ' y profundidad (8 mt), en la que es posible bañarse. Las que se encuentran en la base de la catarata son las menos profundas, tienen un promedio de 6 m de ancho x 14 m de largo y 1 m de profundidad.',

      //   tiempoEstimado: '1.5 horas',
      //   region:
      //       LatLngBounds(LatLng(-11.009, -74.675), LatLng(-11.209, -74.659)),
      //   polyline: [LatLng(-11.209, -74.659), LatLng(-11.201, -74.665)],
      // ),

      Lugar(
        nombre: 'Catarata Cunampiaro',
        imagenes: [
          'assets/rioNegro/CUNAMPIARO/cunampiaro1.webp',
          'assets/rioNegro/CUNAMPIARO/cunampiaro2.webp',
          'assets/rioNegro/CUNAMPIARO/cunampiaro3.webp',
        ],
        //imagen: 'assets/rioNegro/CUNAMPIARO/cunampiaro1.jpg',
        descripcion:
            'La cascada de Cunampiaro se precipita desde lo alto de un conglomerado rocoso de 23 m de altura por 7 m de ancho en la base y sus cristalinas y frescas aguas con una temperatura de 20ºC, de color aparente ambarino claro, caen con relativa suavidad en una pequeña fuente de escasa profundidad. El ambiente está rodeado por un pequeño bosque secundario y campos de cultivos de frutas y café. Los chorros de agua son usados por los visitantes para darse relajantes hidromasajes, siendo ese su principal motivo de visita así como la observación de las diferentes especies de flora que se encuentran en el lugar como el nogal (Juglans neotropica), varios podocarpus como el ulcumano (Podocarpus oleifolius), diablo fuerte (Podocarpus rospigliosii), etc.',

        tiempoEstimado: 'A 40 minutos',
        region:
            LatLngBounds(LatLng(-11.009, -74.675), LatLng(-11.209, -74.659)),
        polyline: [LatLng(-11.209, -74.659), LatLng(-11.201, -74.665)],
      ),
    ],
  ),
  Categorias(
    name: 'Manifestaciones   ',
    // icon: FontAwesomeIcons.mosque,
    icon: Icons.castle,
    // icon: 'assets/iconos/manifestacion.webp',
    lugares: [
      Lugar(
        nombre: 'Parque de la interculturalidad',
        imagenes: [
          'assets/rioNegro/PLAZA_INTERCULTURAL/plaza1.webp',
          'assets/rioNegro/PLAZA_INTERCULTURAL/plaza2.webp',
        ],
        //imagen: 'assets/image/lugares/rioNegro.jpeg',
        descripcion:
            'Se extiende en un área de los 10,005 m2, posee zona Wi-fi gratis y consta de una glorieta principal representada por una corona asháninka y un sombrero andin; además el arco y la flecha que simboliza la fuerza guerrera de los aborígenes, máxima expresión con un enfoque intercultural. Su remodelación se hizo en enero de año 2008, sintetizando al avance de la modernidad de los pisos en cerámica, sólidad bancas, fuentes, saltos y caidas de agua como una réplica de las cataratas de Tsomontonari en forma de cortinas y luces multicolores.',
        tiempoEstimado: 'Misma Plaza',
        region:
            LatLngBounds(LatLng(-11.009, -74.675), LatLng(-11.209, -74.659)),
        polyline: [LatLng(-11.209, -74.659), LatLng(-11.201, -74.665)],
      ),
      Lugar(
        nombre: 'Capilla "San Miguel Arcangel"',
        imagenes: [
          'assets/rioNegro/IGLESIA/iglesia.webp',
        ],
        //imagen: 'assets/rioNegro/IGLESIA/iglesia.JPG',
        descripcion:
            'En 1951, llegó el Santo Patrón "San Miguel Arcángel" que hoy es el guardián protector de la comunidad cristiana católica. La fiesta patronal se celebra el 29 de setiembre de cada año compartiendo la algarabía y alegría con un sentido más profundo de la fe católica. Actualmente, está acardo del Consejo Pastoral de la Capilla "San Miguel Arcángel" de la Parroquia San Francisco de Asis, por orden del Vicariato Apostólico de San Ramón.',
        tiempoEstimado: 'Misma Plaza',
        region:
            LatLngBounds(LatLng(-11.009, -74.675), LatLng(-11.209, -74.659)),
        polyline: [LatLng(-11.209, -74.659), LatLng(-11.201, -74.665)],
      ),
    ],
  ),
  Categorias(
    name: 'Comunidad   ',
    //cabin
    icon: Icons.food_bank,
    // icon: 'assets/iconos/mujer.webp',
    lugares: [
      Lugar(
        nombre: 'Comunidad Nativa Ashaninka Yavirironi',
        imagenes: [
          'assets/rioNegro/TSOMONTONARI/tsomontonari1.webp',
          'assets/rioNegro/TSOMONTONARI/tsomontonari2.webp',
          'assets/rioNegro/TSOMONTONARI/tsomontonari3.webp',
        ],
        //imagen: 'ruta/a/imagenC.png',
        descripcion: 'Museo que narra la historia local.',
        tiempoEstimado: '3 horas',
        region:
            LatLngBounds(LatLng(-11.009, -74.675), LatLng(-11.209, -74.659)),
        polyline: [
          LatLng(-11.20857695048312, -74.66021205752597),
          LatLng(-11.208179891588912, -74.66050527274929),
          LatLng(-11.208256410411309, -74.66053884512215),
          LatLng(-11.20159761528555, -74.66514763988471),
          LatLng(-11.200831830867827, -74.66532150827682),
          LatLng(-11.200231099757772, -74.66527293279522),
          LatLng(-11.18677475007047, -74.66205257712815),
          //LatLng(),
          LatLng(-11.186045369082265, -74.66153869306886),
          LatLng(-11.182625044000574, -74.65586234894447),
          LatLng(-11.182453445002068, -74.65517283034488),
          LatLng(-11.182374037385486, -74.65445509339779),
          LatLng(-11.1819623421748, -74.65399060843542),
          LatLng(-11.181044048577377, -74.65378212708488),
          LatLng(-11.180179169911057, -74.65425886301459),
          //balle azul:
          LatLng(-11.179897455473125, -74.65460755018661),
          //
          LatLng(-11.179776476016741, -74.65537498595666),
          LatLng(-11.17983596883505, -74.6560760681867),
          LatLng(-11.179740533592607, -74.65634011638751),
          LatLng(-11.179094751034867, -74.65659739645322),
          LatLng(-11.178723245453654, -74.65710102887864),
          LatLng(-11.178705707053695, -74.658172282545),
          LatLng(-11.178396317742454, -74.65853954295598),
          LatLng(-11.177141929562737, -74.65843218048998),
          LatLng(-11.173797553928011, -74.65903457034341),
          LatLng(-11.168853089222566, -74.66078266044741),
          LatLng(-11.147811277017894, -74.6648619097495),
          LatLng(-11.146170408764618, -74.66548743082232),
          //Villa Cpiri
          LatLng(-11.130454665364695, -74.67398335859723),
          LatLng(-11.125717709532523, -74.67641128919632),
          LatLng(-11.124931413043072, -74.67735465004085),
          LatLng(-11.12403609638855, -74.68007587390318),
          LatLng(-11.123110461805751, -74.68104887301706),
          LatLng(-11.117064144315009, -74.68367323152658),
          //Unión Capiri
          LatLng(-11.094972222290522, -74.70135809535316),
          //Yavirironi
          LatLng(-11.088049013305792, -74.70690188994469),
        ],
      ),
    ],
  ),
  // Categorias(
  //   name: 'Festival   ',
  //   icon: Icons.festival,
  //   // icon: 'assets/iconos/festival.webp',
  //   lugares: [
  //     Lugar(
  //       nombre: 'Festival Del Pescado',
  //       imagenes: [
  //         'assets/rioNegro/TSOMONTONARI/tsomontonari1.webp',
  //         'assets/rioNegro/TSOMONTONARI/tsomontonari2.webp',
  //         'assets/rioNegro/TSOMONTONARI/tsomontonari3.webp',
  //       ],
  //       //imagen: 'ruta/a/imagenC.png',
  //       descripcion: 'Museo que narra la historia local.',
  //       tiempoEstimado: '3 horas',
  //       region:
  //           LatLngBounds(LatLng(-11.009, -74.675), LatLng(-11.209, -74.659)),
  //       polyline: [LatLng(-11.209, -74.659), LatLng(-11.201, -74.665)],
  //     ),
  //   ],
  // ),
  // Categorias(
  //   name: 'Emprendimiento   ',
  //   // icon: FontAwesomeIcons.mountain,
  //   icon: Icons.real_estate_agent_rounded,
  //   // icon: 'assets/iconos/emprendimiento.webp',
  //   lugares: [
  //     Lugar(
  //       nombre: 'Café Misha-Fundo Santa Luzmila',
  //       imagenes: [
  //         'assets/rioNegro/TSOMONTONARI/tsomontonari1.webp',
  //         'assets/rioNegro/TSOMONTONARI/tsomontonari2.webp',
  //         'assets/rioNegro/TSOMONTONARI/tsomontonari3.webp',
  //       ],
  //       //imagen: 'ruta/a/imagenC.png',
  //       descripcion: 'Museo que narra la historia local.',
  //       tiempoEstimado: '3 horas',
  //       region:
  //           LatLngBounds(LatLng(-11.009, -74.675), LatLng(-11.209, -74.659)),
  //       polyline: [LatLng(-11.209, -74.659), LatLng(-11.201, -74.665)],
  //     ),
  //   ],
  // ),

  ////////////////////////////////////////
];
