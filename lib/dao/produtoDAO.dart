import 'dart:convert';

import 'package:app_flutter/dao/token.dart';
import 'package:http/http.dart' as http;
import '../model/produto.dart';

class ProdutoDAO{

  final _headers = {'Content-Type': 'application/json','Authorization': 'Bearer ${TokenDao().getToken()}'};
  final _url = Uri.parse("http://10.0.2.2:6969/flutter/produto");

  adicionar(Produto p) async{
    await http.post(_url,headers: _headers, body: jsonEncode(p.toMap()));
  }

  Future<List<Produto>> getProdutos() async {
    var response = await http.get(_url,headers: _headers);

    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

    return jsonResponse.map<Produto>((json)=> Produto.fromMap(json)).toList();
  }

  Future<Produto> getProdutoById(int id) async {
    print("teste2");
    var response = await http.get(Uri.parse("http://10.0.2.2:6969/flutter/produto/${id}"), headers: _headers);

    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
    print(jsonResponse);
    return Produto.fromMap(jsonResponse);
  }
}