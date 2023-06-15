import 'package:app_flutter/dao/produtoDAO.dart';
import 'package:app_flutter/model/produto.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class menu extends StatefulWidget {
  const menu({super.key});

  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {
  TextEditingController _nomePorduto = new TextEditingController();
  TextEditingController _valorProduto = new TextEditingController();
  TextEditingController _codigoLote = new TextEditingController();
  TextEditingController _idProdLote = new TextEditingController();
  TextEditingController _qntdLote = new TextEditingController();
  TextEditingController _validadeLote = new TextEditingController();

  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {

    List<Widget> _lista = [
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              controller: _nomePorduto,
              decoration: InputDecoration(
                label: Text("Nome"),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _valorProduto,
              decoration: InputDecoration(
                label: Text("Valor")
              ),
            ),
            ElevatedButton(
              onPressed: (){
                Produto prod = new Produto(valor: double.tryParse(_valorProduto.text)!, nome: _nomePorduto.text);
                new ProdutoDAO().adicionar(prod);
                _nomePorduto.clear();
                _valorProduto.clear();
              },
              child: Text("Criar"),
            )
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        padding: EdgeInsets.all(15),
        child: FutureBuilder<List<Produto>>(
          future: new ProdutoDAO().getProdutos(),
          initialData: [],
          builder: (context, snapshot){
            final List<Produto>? produtos = snapshot.data;
            return ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: produtos?.length,
              itemBuilder: (context, i){
              final Produto produto = produtos![i];
              return new ListTile(
                title: Text(produto.nome, style: TextStyle(fontSize: 24),),
                subtitle: Text("preço: R\$ ${produto.valor.toStringAsFixed(2)}"),
              );
            });
          },
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        padding: EdgeInsets.all(15),
        child: Text("fazer cadastro do lote")
      ),
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)
        ),
        padding: EdgeInsets.all(15),
        child: Text("view produtos lotes validades etc")
      )
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          InkWell(
            child: Container(
              padding: EdgeInsets.all(5),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>login()));
                },
                icon: Icon(Icons.exit_to_app),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.border_color_outlined),
            label: "Cadastrar",
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Listar",
              backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "Lote",
              backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: "Estoque",
              backgroundColor: Colors.blue
          )
        ],
          iconSize: 35,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });
          }
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey,
        padding: EdgeInsets.all(15),
        child: _lista[_selectedIndex],
      ),
    );
  }
}
