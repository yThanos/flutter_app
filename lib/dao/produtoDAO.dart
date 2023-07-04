import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/produto.dart';

class ProdutoDAO{

  var _headers = {'Content-Type': 'application/json'};
  var _url = Uri.parse("http://10.0.2.2:6969/flutter/produto");

  adicionar(Produto p) async{
    await http.post(_url,headers: _headers, body: jsonEncode(p.toMap()));
  }

  Future<List<Produto>> getProdutos() async {
    var response = await http.get(_url,headers: _headers);

    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

    return jsonResponse.map<Produto>((json)=> Produto.fromMap(json)).toList();
  }

  Future<Produto> getProdutoById(int? id) async {
    var response = await http.get(_url, headers: _headers);

    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

    return Produto.fromMap(jsonResponse);
  }
}