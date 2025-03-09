import 'package:flutter/material.dart';

class MenuDrawerPerfil extends StatefulWidget {
  const MenuDrawerPerfil({super.key});

  @override
  _MenuDrawerPerfilState createState() => _MenuDrawerPerfilState();
}

class _MenuDrawerPerfilState extends State<MenuDrawerPerfil> {
  // Controlador para el campo de texto de revisión de alquileres
  final TextEditingController _rentalController = TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador al salir de la pantalla
    _rentalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.red[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto de perfil
            const Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage:
                    AssetImage('assets/profile_pic.jpg'), // Imagen de ejemplo
              ),
            ),
            const SizedBox(height: 16.0),
            // Nombre y correo
            Center(
              child: Column(
                children: [
                  const Text(
                    "Nombre de Usuario",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "correo@ejemplo.com",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            // Información de perfil
            ListTile(
              leading: Icon(Icons.badge, color: Colors.grey[700]),
              title: const Text("Número de licencia"),
              subtitle: const Text("123456789"),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.lock, color: Colors.grey[700]),
              title: const Text("Cambiar contraseña"),
              onTap: () {
                // Acción para cambiar contraseña
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.search_rounded, color: Colors.red[700]),
              title: const Text("Revisar Alquileres"),
              onTap: () {
                // Acción para revisar alquileres
              },
            ),
            const SizedBox(height: 16.0),
            // Campo de texto para revisar alquileres
          ],
        ),
      ),
    );
  }
}
