import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/usuario.dart';
import 'OpenDatabase.dart';
class Login{
  Future<bool> logar(Usuario user) async{
    var url = Uri.parse("http://10.0.2.2:8080/login");
    var response = await http.post(url, body: jsonEncode(user.toMap()), headers: {'Content-Type': 'application/json'});
    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      Usuario usuario = Usuario.fromMap(jsonResponse);
      await saveToken(usuario.token!);
      return true;
    } else {
      return false;
    }
  }
  
  Future<bool> criarConta(Usuario user) async{
    final header = {'Content-Type': 'application/json'};
    var response = await http.post(Uri.parse("http://10.0.2.2:8080/criarConta"), headers: header, body: jsonEncode(user.toMap()));
    return response.statusCode == 200;
  }
}