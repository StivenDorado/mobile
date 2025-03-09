import 'package:flutter/material.dart';
import 'package:flutter_alquiler_autos/controllers/cliente_controller.dart';
import 'package:flutter_alquiler_autos/views/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _numLicController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordControllervalida =
      TextEditingController();
  final ClienteService clienteService = ClienteService();

  void registrarCliente() async {
    final nombre = _nombreController.text;
    final numLic = _numLicController.text;
    final correo = _correoController.text;
    final password = _passwordController.text;
    final passwordValida = _passwordControllervalida.text;

    // Validación de contraseñas
    if (password != passwordValida) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    try {
      final response = await clienteService.registrarCliente(
          nombre, correo, numLic, password);

      print('Status codigo: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro exitoso')),
        );

        // Limpiar los campos dentro de setState para reflejar los cambios
        setState(() {
          _nombreController.clear();
          _correoController.clear();
          _numLicController.clear();
          _passwordController.clear();
          _passwordControllervalida.clear();
        });

        // Navegar a la pantalla de login
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error al registrar, intente más tarde')),
        );
      }
    } catch (e) {
      print("Error en el registro: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al conectar con el servidor')),
      );
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
              Icons.person_add,
              size: 80,
              color: Colors.red[300],
            ),
            const SizedBox(height: 16.0),
            // Texto "Empecemos"
            Text(
              "Empecemos",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red[300],
              ),
            ),
            const SizedBox(height: 8.0),
            // Texto "Crear una nueva cuenta"
            const Text(
              "Crear una nueva cuenta",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32.0),
            // Campo de nombre completo
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                prefixIcon: Icon(Icons.person, color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            // Campo de correo electrónico
            TextField(
              controller: _correoController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email, color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            // Campo de número de licencia
            TextField(
              controller: _numLicController,
              decoration: const InputDecoration(
                labelText: 'Número de licencia',
                prefixIcon:
                    Icon(Icons.account_balance_rounded, color: Colors.grey),
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
            const SizedBox(height: 16.0),
            // Campo de confirmación de contraseña
            TextField(
              controller: _passwordControllervalida,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmar contraseña',
                prefixIcon: Icon(Icons.lock, color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32.0),
            // Botón de registro
            ElevatedButton(
              onPressed: () {
                registrarCliente();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[300],
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text(
                'Registrarse',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16.0),
            // Texto para iniciar sesión
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("¿Ya tienes una cuenta? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Iniciar sesión",
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
