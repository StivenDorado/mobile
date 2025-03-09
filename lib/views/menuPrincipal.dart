import 'package:flutter/material.dart';
import 'package:flutter_alquiler_autos/controllers/autos_controller.dart';
import 'package:flutter_alquiler_autos/views/detalleVehiculo.dart';
import 'package:flutter_alquiler_autos/views/menuDrawerPerfil.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key});

  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  final AutosController autosController = AutosController();
  List<Map<String, dynamic>> listaDeAutos = []; //En ésta lista se almacenan los autos que viene de la API
  bool isLoading = true; //Indicador de progreso de carga

  @override
  void initState(){ //llamar al método de cargarAutos() cada vez que la pantalla se crea
    super.initState();
    // Cargar los autos desde la API
    cargarAutos();
  }

  void cargarAutos() async {
    try {
      final autos = await autosController.obtenerAutosDisponibles();
      setState(() {
        listaDeAutos = autos;
        isLoading = false;
      });
    }catch (e) {
      setState(() {
        isLoading = false;
      });
      print('error al cargar autos: $e');
    }

  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      drawer: const MenuDrawerPerfil(),
      appBar: AppBar(
        title: const Text('Alquiler de Vehículos'),
        backgroundColor: Colors.red[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Cuadro de búsqueda con icono
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Buscar vehículo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16.0),
            // Lista de vehículos
            Expanded(
              child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : listaDeAutos.isEmpty
              ? const Center(child: Text("No hay vehículos disponibles"))
              :ListView.builder(
                itemCount: listaDeAutos.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.network(
                      listaDeAutos[index]['imageUrl'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text('${listaDeAutos[index]['marca']} ${listaDeAutos[index]['modelo']}'),
                    subtitle: Text('año: ${listaDeAutos[index]['anio']} - ${listaDeAutos[index]['ValorAlquiler']}'),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.red[300]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalleVehiculoScreen(
                            imageUrl: listaDeAutos[index]['imageUrl'],
                            marca: listaDeAutos[index]['marca'],
                            modelo: listaDeAutos[index]['modelo'],
                            anio: listaDeAutos[index]['anio'],
                            disponibilidad: listaDeAutos[index]['disponibilidad'],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red[300],
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Alquiler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Usuario',
          ),
        ],
      ),
    );
  }
}
