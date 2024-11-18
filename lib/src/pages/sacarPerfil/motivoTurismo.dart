import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:turismo/src/pages/home/explore/navbar.dart';
import 'package:turismo/src/pages/login/entities/objectbox.dart';
import 'package:turismo/src/pages/login/entities/person.dart';
import 'package:turismo/src/sincronizacion/mongo_service.dart';

class Perfilturista extends StatefulWidget {
  final Person person;

  const Perfilturista({Key? key, required this.person}) : super(key: key);

  @override
  _PerfilturistaState createState() => _PerfilturistaState();
}

class _PerfilturistaState extends State<Perfilturista> {
  var height, width;

  String selectedCountry = "";
  String selectedState = "";
  String selectedCity = "";

  List<String> imgData = [
    "assets/image/perfilLogo/aventura.webp",
    "assets/image/perfilLogo/negocio.webp",
    "assets/image/perfilLogo/festival.webp",
    "assets/image/perfilLogo/relajacion.webp",
    "assets/image/perfilLogo/comida.webp",
    "assets/image/perfilLogo/cultura.webp",
  ];

  List<String> titles = [
    "Aventuras",
    "Negocios",
    "Eventos y festivales",
    "Descanso y relajación",
    "Gastronomías",
    "Explorar nuevas culturas",
  ];

  List<bool> selected = List.generate(6, (index) => false);

  @override
  void initState() {
    super.initState();
    if (widget.person.lugarVista != null &&
        widget.person.lugarVista!.isNotEmpty) {
      selectedCountry = widget.person.lugarVista![0];
      selectedState = widget.person.lugarVista!.length > 1
          ? widget.person.lugarVista![1]
          : '';
      selectedCity = widget.person.lugarVista!.length > 2
          ? widget.person.lugarVista![2]
          : '';
    }
    if (widget.person.motivos != null && widget.person.motivos!.isNotEmpty) {
      for (int i = 0; i < titles.length; i++) {
        if (widget.person.motivos!.contains(titles[i])) {
          selected[i] = true;
        }
      }
    }
  }

  void toggleSelection(int index) {
    setState(() {
      selected[index] = !selected[index];
    });
  }

  void updatePersonData() async {
    if (selectedCountry.isEmpty ||
        selectedState.isEmpty ||
        selectedCity.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Por favor, selecciona País, Departamento y Provincia.')),
      );
      return;
    }

    bool hasSelectedMotivo = selected.contains(true);
    if (!hasSelectedMotivo) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Por favor, selecciona al menos un motivo de turismo.')),
      );
      return;
    }

    final store = await ObjectBox.getStore();
    final personBox = store.box<Person>();
    final person = widget.person;

    person.lugarVista = [selectedCountry, selectedState, selectedCity];
    List<String> selectedMotivos = [];

    for (int i = 0; i < selected.length; i++) {
      if (selected[i]) {
        selectedMotivos.add(titles[i]);
      }
    }
    person.motivos = selectedMotivos;

    try {
      if (person.mongoId != null && person.mongoId!.isNotEmpty) {
        await MongoDBService.updatePerson(person.toJson());
        person.syncPending = false;
      } else {
        var insertedPerson =
            await MongoDBService.insertPersona(person.toJson());
        if (insertedPerson != null && insertedPerson.containsKey('_id')) {
          person.mongoId = insertedPerson['_id'].toString();
          person.syncPending = false;
        }
      }

      personBox.put(person);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Datos actualizados correctamente')),
      );
      Navigator.pushReplacementNamed(context, 'Navbar');
    } catch (e) {
      person.syncPending = true;
      personBox.put(person);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Sin conexión. Los datos se guardaron localmente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: Text(
          'COMPLETE Y SELECCIONE',
          style: TextStyle(
            color: Colors.white,
            fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Colors.indigo,
        child: Column(
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¿De qué lugar nos visita?',
                      style: TextStyle(
                        fontSize: width * 0.045,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    CSCPicker(
                      showStates: true,
                      showCities: true,
                      flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                      ),
                      countryDropdownLabel: "País",
                      stateDropdownLabel: "Departamento",
                      cityDropdownLabel: "Provincia",
                      selectedItemStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      onCountryChanged: (value) {
                        setState(() {
                          selectedCountry = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          selectedState = value ?? "";
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          selectedCity = value ?? "";
                        });
                      },
                      defaultCountry: CscCountry.Peru,
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      '¿Por qué motivo haces turismo?',
                      style: TextStyle(
                        fontSize: width * 0.045,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: EdgeInsets.only(bottom: 80),
                child: GridView.builder(
                  padding: EdgeInsets.all(width * 0.05),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (width / 200).floor(),
                    crossAxisSpacing: width * 0.03,
                    mainAxisSpacing: width * 0.03,
                    childAspectRatio: 1,
                  ),
                  itemCount: imgData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        toggleSelection(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                imgData[index],
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (selected[index])
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.red.withOpacity(0.5),
                                ),
                              ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  titles[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: width * 0.04,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: updatePersonData,
        backgroundColor: Colors.blue,
        child: Icon(Icons.navigate_next),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
