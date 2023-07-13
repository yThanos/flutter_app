import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/produto.dart';
import 'OpenDatabase.dart';

class ProdutoDAO{

  adicionar(Produto p) async{
    String token = await getToken();
    final header = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    await http.post(Uri.parse("http://10.0.2.2:8080/produtos"),headers: header, body: jsonEncode(p.toMap()));
  }

  Future<List<Produto>> getProdutos() async {
    String token = await getToken();
    final header = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    var response = await http.get(Uri.parse("http://10.0.2.2:8080/produtos"), headers: header);
    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
    return jsonResponse.map<Produto>((json)=> Produto.fromMap(json)).toList();
  }

  Future<Produto> getProdutoById(int id) async {
    String token = await getToken();
    final header = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    var response = await http.get(Uri.parse("http://10.0.2.2:8080/produtos/$id"), headers: header);
    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
    return Produto.fromMap(jsonResponse);
  }
}