import 'dart:convert';
import 'package:http/http.dart' as http;

class AutosController {
  final String baseUrl = "https://backendprojectflutter.onrender.com";

  // Método para obtener los vehículos disponibles
  Future<List<Map<String, dynamic>>> obtenerAutosDisponibles() async { 
    //Retornando una lista de mapas
    try {
      //Utilizar el método con las funciones para detectar errores
      final url = Uri.parse('$baseUrl/');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        // Convertir los datos a una lista de mapas
        return data.map((auto) { //Me permite mapear los datos que los recorre de la vista de Autos
          return {
            'marca': auto["marca"],
            'modelo': auto["modelo"],
            'imageUrl': auto["imagen"] ?? 'http://autos.placeholder.com/21',
            'ValorAlquiler': auto["valorAlquiler"], // Verifica el nombre en la API
            'Anio': auto["anio"], 
            'disponibilidad': auto["disponibilidad"],
          };
        }).toList();
      } else {
        throw Exception("Error al obtener los autos: ${response.statusCode}");
      }
    } catch (e) {
      print("Error al obtener Autos: $e");
      return [];
    }
  }
}
