//permite codigficar y decodificar datos en formato JSON
import 'dart:convert';
import 'package:http/http.dart' as http;

// definir en una clase para poder trabajar a cliente

class ClienteService {
  final String baseUrl = 'https://bakendalquilerautos.onrender.com/api/clientes'; //enlace de render aqui

//Metodo registrar cliente
  Future<http.Response> registrarCliente(
      String nombre, String correo, String numLic, password) async {
    final url = Uri.parse('$baseUrl/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombre,
        'correo': correo,
        'numLic': numLic,
        'password': password,
      }),
    );
    return response;
//Future indica que es un metodo asincrono y devuelve un objeto http.Response
//Uri.parse contruir la URL para la solicitud POST
//http.post metodo para enviar datos al servidor
//JsonEscode convierte le objeto de dart en json
  }

  Future<Map<String, dynamic>> loginCliente(
      String correo, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'correo': correo,
        'password': password,
      }),
    );

    final responseData = jsonDecode(response.body);
    if(response.statusCode == 200){
      return{
        'success':true,
        'menasaje': responseData['mensaje'],
        'cliente': responseData['cliente'],
      };
      }else{
        return{
         'success':false,
         'mensaje': responseData['mensaje'] ?? 'Crendeciales son incrrectas'
        };
    }
  }
}
