import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/lote.dart';
import 'OpenDatabase.dart';

class LoteDAO{
  adicionar(Lote l) async{
    String token = await getToken();
    final header = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    await http.post(Uri.parse("http://10.0.2.2:8080/lotes"),headers: header, body: jsonEncode(l.toMap()));
  }

  Future<List<Lote>> getLotes() async {
    String token = await getToken();
    final header = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    final response = await http.post(Uri.parse("http://10.0.2.2:8080/lotes"),headers: header);
    final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
    return jsonResponse.map<Lote>((json)=> Lote.fromMap(json)).toList();
  }
}