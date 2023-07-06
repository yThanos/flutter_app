import 'dart:convert';

import 'package:app_flutter/dao/token.dart';
import 'package:http/http.dart' as http;

import '../model/usuario.dart';
class Login{
  Future<bool> logar(Usuario user) async{
    var url = Uri.parse("http://10.0.2.2:6969/flutter/login");
    var response = await http.post(url, body: jsonEncode(user.toMap()), headers: {'Content-Type': 'application/json'});

    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      Usuario usuario = Usuario.fromMap(jsonResponse);
      TokenDao().saveToken(usuario.token!);

      return true;
    } else {
      return false;
    }
  }
}