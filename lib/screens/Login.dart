import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_muestra/screens/Registro.dart';
import 'package:app_muestra/screens/Series.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  const Login({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
       body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Gmail(),
                SizedBox(height: 20),
                Contrasenia(),
                SizedBox(height: 20),
                BotonLogin(context),
                SizedBox(height: 20),
                BotonRegistro(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final TextEditingController _gmail = TextEditingController();
Widget Gmail() {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(20),
        child: TextField(
          controller: _gmail,
          decoration: InputDecoration(
            hintText: 'Ingrese su Gmail',
            fillColor: Colors.grey,
            filled: true,
          ),
        ),
      )
    ],
  );
}

final TextEditingController _contrasenia = TextEditingController();
Widget Contrasenia() {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(20),
        child: TextField(
          controller: _contrasenia,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Ingrese Contraseña',
            fillColor: Colors.grey,
            filled: true,
          ),
        ),
      )
    ],
  );
}

Widget BotonLogin(context) {
  return ElevatedButton(
    onPressed: () {
      login(context);
    },
    child: Text("Login"),
  );
}

Widget BotonRegistro(context) {
  return TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Registro()),
      );
    },
    child: Text("Registro"),
  );
}

Future<void> login(context) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _gmail.text,
      password: _contrasenia.text,
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Series()),
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No se encontró usuario con ese correo.');
    } else if (e.code == 'wrong-password') {
      print('Contraseña incorrecta para ese usuario.');
    }
  }
}