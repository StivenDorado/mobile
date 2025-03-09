import 'package:flutter/material.dart';
import 'package:flutter_alquiler_autos/controllers/cliente_controller.dart';
import 'package:flutter_alquiler_autos/views/menuPrincipal.dart';
import 'package:flutter_alquiler_autos/views/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ClienteService clienteService = ClienteService();

  void iniciarSession() async {
    final correo = _emailController.text;
    final password = _passwordController.text;

    final result = await clienteService.loginCliente(correo, password);
    if (result['success'] && result.containsKey('cliente')) {
      //verificar que el resultado tiene datos válidos antes de ir a iniciar sesón
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Inicio de sesión exitoso')));
    Future.delayed(const Duration(seconds: 1), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MenuPrincipal()),);
    });
    }else{
      ScaffoldMessenger.of(context)
         .showSnackBar(const SnackBar(content: Text('Credenciales incorrectas')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Icono en la parte superior
            Icon(
              Icons.person,
              size: 80,
              color: Colors.red[300],
            ),
            const SizedBox(height: 16.0),
            // Texto de bienvenida
            Text(
              "Bienvenido",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red[300],
              ),
            ),
            const SizedBox(height: 8.0),
            // Subtítulo
            const Text(
              "Inicia sesión para continuar",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32.0),

            // Campo de correo electrónico
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email, color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            // Campo de contraseña
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock, color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32.0),
            // Botón de inicio de sesión
            ElevatedButton(
              onPressed: () {
                iniciarSession();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[300],
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            // Texto para recuperar contraseña
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                    child: Text(
                  "¿Olvidaste tu contraseña? ",
                  textAlign: TextAlign.center,
                )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuPrincipal()));
                  },
                  child: Text(
                    "Recuperar",
                    style: TextStyle(
                      color: Colors.red[300],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            // Texto para registrarse
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("¿No tienes una cuenta? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()));
                  },
                  child: Text(
                    "Regístrate",
                    style: TextStyle(
                      color: Colors.red[300],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
