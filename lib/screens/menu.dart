import 'package:app_flutter/dao/loteDAO.dart';
import 'package:app_flutter/dao/produtoDAO.dart';
import 'package:app_flutter/model/lote.dart';
import 'package:app_flutter/model/produto.dart';
import 'package:app_flutter/screens/lotesView.dart';
import 'package:app_flutter/screens/qrcode.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class menu extends StatefulWidget {
  const menu({super.key});

  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {
  final TextEditingController _nomePorduto = TextEditingController();
  final TextEditingController _valorProduto = TextEditingController();
  final TextEditingController _idLote = TextEditingController();
  int _idProdLote = 1;
  final TextEditingController _qntdLote = TextEditingController();
  final TextEditingController _validadeLote = TextEditingController();

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
                Produto prod = Produto(valor: double.tryParse(_valorProduto.text)!, nome: _nomePorduto.text);
                ProdutoDAO().adicionar(prod);
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
          future: ProdutoDAO().getProdutos(),
          initialData: [],
          builder: (context, snapshot){
            final List<Produto>? produtos = snapshot.data;
            return ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: produtos?.length,
                itemBuilder: (context, i){
                  final Produto produto = produtos![i];
                  return ListTile(
                    title: Text(produto.nome!, style: TextStyle(fontSize: 24),),
                    subtitle: Text("preço: R\$ ${produto.valor?.toStringAsFixed(2)}"),
                  );
                });
          },
        ),
      ),
      SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
          ),
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              FutureBuilder<List<Produto>>(
                  future: ProdutoDAO().getProdutos(),
                  initialData: [],
                  builder: (context, snapshot){
                    final List<Produto>? produtos = snapshot.data;
                    return DropdownButton<int>(
                      value: _idProdLote,
                      onChanged: (change){
                        setState(() {
                          _idProdLote = change!;
                        });
                      },
                      items: produtos?.map((fc) =>
                          DropdownMenuItem<int>(
                            child: Text(fc.nome!),
                            value: fc.codigo,
                          )
                      ).toList(),
                    );
                  }
              ),
              TextFormField(
                controller: _idLote,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(label: Text("Lote")),
              ),
              TextFormField(
                controller: _validadeLote,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(label: Text("Validade")),
              ),
              TextFormField(
                controller: _qntdLote,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(label: Text("Quantidade")),
              ),
              ElevatedButton(
                onPressed: ()async{
                  Produto prod = await ProdutoDAO().getProdutoById(_idProdLote);
                  await LoteDAO().adicionar(Lote(
                      lote: int.tryParse(_idLote.text),
                      produto: prod,
                      qntd: int.tryParse(_qntdLote.text),
                      validade: _validadeLote.text
                  ));
                  setState(() {

                  });
                },
                child: Text("Cadastrar"),
              ),
              FloatingActionButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> qrcode()));
                },
                child: Icon(Icons.qr_code_2),

              )
            ],
          ),
        ),
      ),
      LoteView()
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
        items: const [
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
