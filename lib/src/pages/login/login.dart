import 'package:animated_switch/animated_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo/src/pages/home/explore/navbar.dart';
import 'package:turismo/src/pages/login/entities/objectbox.dart';
import 'package:turismo/src/pages/login/entities/person.dart';
import 'package:turismo/src/pages/sacarPerfil/motivoTurismo.dart';
import 'package:turismo/src/pages/login/registro.dart';
import 'package:turismo/src/widgets/pregunta.dart';
//import 'package:turismo/src/models/person.dart';
import 'package:turismo/src/pages/login/objectbox.g.dart';
import 'package:video_player/video_player.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final Box<Person> personBox;
  bool _rememberMe = true;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    // Inicializar el controlador de video
    _videoController = VideoPlayerController.asset('assets/video/video.mp4')
      ..initialize().then((_) {
        _videoController.setLooping(true);
        _videoController.play();
        setState(() {});
      });
    // Obtener la instancia de Store y la caja de Person
    ObjectBox.getStore().then((store) {
      setState(() {
        personBox = store.box<Person>();
        _loadSavedCredentials(); // Cargar credenciales guardadas si "Guardar sesión" está activado.
      });
    });
  }

  @override
  void dispose() {
    _usuarioController.dispose();
    _passwordController.dispose();
    _videoController.dispose(); // Liberar recursos del video
    super.dispose();
  }

  void _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool('rememberMe') ?? false;

    if (rememberMe) {
      setState(() {
        _rememberMe = true;
        _usuarioController.text = prefs.getString('usuario') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
      });
    }
  }

  void _login() async {
    String usuario = _usuarioController.text.trim();
    String password = _passwordController.text.trim();

    if (usuario.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor, ingrese usuario y contraseña')),
      );
      return;
    }

    final query = personBox
        .query(
          Person_.usuario.equals(usuario) & Person_.password.equals(password),
        )
        .build();

    final person = query.findFirst();

    if (person != null) {
      if (_rememberMe) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('usuario', usuario);
        await prefs.setString('password', password);
        await prefs.setBool('rememberMe', true);
      }

      if ((person.lugarVista == null || person.lugarVista!.isEmpty) &&
          (person.motivos == null || person.motivos!.isEmpty)) {
        Navigator.pushReplacementNamed(context, 'Perfilturista',
            arguments: person);
      } else {
        Navigator.pushReplacementNamed(context, 'Navbar');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario o contraseña incorrectos')),
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
          // Video de fondo
          if (_videoController.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController.value.size.width,
                  height: _videoController.value.size.height,
                  child: VideoPlayer(_videoController),
                ),
              ),
            ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.6),
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.2)
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
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
                    Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(30, 23, 23, 0.58),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image(
                                image:
                                    AssetImage('assets/image/logoBlanco.webp')),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: _usuarioController,
                              decoration: InputDecoration(
                                hintText: 'Ingrese su Usuario',
                                label: Text('Usuario'),
                                fillColor: Color(0XffD8D8DD),
                                filled: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                              controller: _passwordController,
                              obscureText:
                                  !_passwordVisible, // Ocultar o mostrar la contraseña
                              decoration: InputDecoration(
                                hintText: 'Cree su Contraseña',
                                labelText: 'Contraseña',
                                fillColor: Color(0XffD8D8DD),
                                filled: true,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off, // Cambiar ícono
                                  ),
                                  onPressed: () {
                                    // Cambiar el estado de visibilidad al hacer clic
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 10.0 : 20.0,
                                vertical: 8.0),
                            child: Row(
                              children: [
                                AnimatedSwitch(
                                  value: _rememberMe,
                                  colorOff: Color(0XffA09F99),
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Guardar sesión',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap:
                                _login, // Acción cuando se hace clic en cualquier parte del container
                            child: Container(
                              height: 60,
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: Color(0xff0ACF83),
                              ),
                              child: Center(
                                child: const Text(
                                  'Ingresar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          pregunta(context,
                              titulo: '¿No tienes cuenta?',
                              link: 'Regístrate',
                              pagina: const Registro())
                        ],
                      ),
                    ),
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
