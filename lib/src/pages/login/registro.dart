import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo/main.dart';
import 'package:turismo/src/pages/login/entities/objectbox.dart';
import 'package:turismo/src/pages/login/entities/person.dart';
import 'package:turismo/src/pages/login/login.dart';
import 'package:turismo/src/sincronizacion/mongo_service.dart';
import 'package:turismo/src/widgets/pregunta.dart';
import 'package:turismo/src/pages/login/objectbox.g.dart';
import 'package:flutter/services.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  late final Box<Person> personBox;
  String? _selectedDocumentType;
  final TextEditingController _selectionController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ObjectBox.getStore().then((store) {
      setState(() {
        personBox = store.box<Person>();
      });
    }).catchError((error) {
      // Manejo de errores
      print('Error al obtener el store: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar el registro')),
      );
    });
  }

  void _registerUser() async {
    if (_selectedDocumentType != null &&
        _selectionController.text.isNotEmpty &&
        _celularController.text.isNotEmpty &&
        _usuarioController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      final newPerson = Person.createNewPerson(
        dni: _selectedDocumentType == 'DNI' ? _selectionController.text : '',
        pasaporte: _selectedDocumentType == 'Pasaporte'
            ? _selectionController.text
            : '',
        celular: _celularController.text,
        usuario: _usuarioController.text,
        password: _passwordController.text,
        lugarVista: [],
        motivos: [],
      );

      try {
        var insertedPerson =
            await MongoDBService.insertPersona(newPerson.toJson());
        if (insertedPerson != null && insertedPerson.containsKey('_id')) {
          newPerson.mongoId = insertedPerson['_id'].toString();
          newPerson.syncPending = false;
          personBox.put(newPerson);
        }

        personBox.put(newPerson);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario registrado con éxito')),
        );

        // Guardar las credenciales en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('usuario', _usuarioController.text);
        await prefs.setString('password', _passwordController.text);
        await prefs.setBool('rememberMe', true);

        // Redirigir a la pantalla de Login después del registro exitoso
        Navigator.pushReplacementNamed(context, 'Login');
      } catch (e) {
        newPerson.syncPending = true;
        personBox.put(newPerson);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Sin conexión. Usuario registrado localmente')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos')),
      );
    }
  }

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 400;

    return Scaffold(
      body: Stack(
        children: [
          const Image(
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            image: AssetImage('assets/image/inicio.webp'),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.10),
                  Colors.black.withOpacity(0.5)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Align(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 10.0 : 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'REGÍSTRATE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmallScreen ? 24 : 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Tipo de Documento',
                            fillColor: Color(0XffD8D8DD),
                            filled: true,
                          ),
                          value: _selectedDocumentType,
                          items:
                              <String>['DNI', 'Pasaporte'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedDocumentType = newValue;
                              _selectionController.text = '';
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _selectionController,
                        enabled: _selectedDocumentType !=
                            null, // Campo habilitado solo si se selecciona un tipo de documento
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(
                            _selectedDocumentType == 'DNI' ? 8 : 20,
                          ),
                        ],
                        decoration: InputDecoration(
                          hintText: _selectedDocumentType == 'DNI'
                              ? 'Ingrese su DNI'
                              : 'Ingrese su Pasaporte',
                          labelText: _selectedDocumentType == 'DNI'
                              ? 'DNI'
                              : 'Pasaporte',
                          fillColor: Color(0xFFD8D8DD),
                          filled: true,
                          suffixIcon: Icon(Icons.perm_identity),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _celularController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(15),
                        ],
                        decoration: InputDecoration(
                          hintText: 'Ingrese su número de celular',
                          labelText: 'N° Celular',
                          suffixIcon: Icon(Icons.phone),
                          fillColor: Color(0xFFD8D8DD),
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _usuarioController,
                        decoration: InputDecoration(
                          hintText: 'Cree su Usuario',
                          label: Text('Usuario'),
                          suffixIcon: Icon(Icons.person),
                          fillColor: Color(0XffD8D8DD),
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          hintText: 'Cree su Contraseña',
                          labelText: 'Contraseña',
                          fillColor: Color(0XffD8D8DD),
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: _registerUser,
                      child: Container(
                        height: 50,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Color(0xff0ACF83),
                        ),
                        child: Center(
                          child: Text(
                            'Registrarme',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    pregunta(context,
                        titulo: 'Tengo una cuenta',
                        link: 'Iniciar Sesion',
                        pagina: const Login())
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
