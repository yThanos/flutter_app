import 'package:app_flutter/dao/usuarioDAO.dart';
import 'package:app_flutter/model/usuario.dart';
import 'package:app_flutter/screens/menu.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailLogin = TextEditingController();
  final TextEditingController _senhaLogin = TextEditingController();
  int _selectedIndex = 0;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    List<Widget> _lista = [
      Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Column(
                children: [
                  Text("Logar",style: TextStyle(fontSize: 30),),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Email"
                    ),
                    controller: _emailLogin,
                  ),
                  TextFormField(
                    controller: _senhaLogin,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      String email = _emailLogin.text;
                      Usuario usuario = await new UsuarioDAO().getUser(email);
                      if(usuario.senha == _senhaLogin.text){
                        setState(() {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> menu()));
                          _emailLogin.clear();
                          _senhaLogin.clear();
                        });
                      }else{
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Credencias incorretas"),
                            content: Text("As credencias que você informou estão incorretas!"),
                          );
                        });
                      }
                    },
                    icon: Icon(Icons.login),
                    label: Text("Logar")
                  )
                ],
              ),
            )
          ],
        ),
      ),
      //divisoria
      Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  Text("Criar Conta",style: TextStyle(fontSize: 30),),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Nome'),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Telefone'),
                    keyboardType: TextInputType.phone,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Implemente a lógica para processar os dados do formulário
                      String name = _nameController.text;
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      String phone = _phoneController.text;

                      Usuario user = Usuario(email: email, senha: password, nome: name, telefone: phone);
                      new UsuarioDAO().adicionar(user);

                      _phoneController.clear();
                      _passwordController.clear();
                      _emailController.clear();
                      _nameController.clear();

                      setState(() {
                        _selectedIndex = 0;
                      });

                    },
                    icon: Icon(Icons.create),
                    label: Text("Criar Conta")
                  ),
                ],
              ),
            )
          ],
        ),
      )
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: "t",
            icon: Icon(Icons.login),

          ),
          BottomNavigationBarItem(
            label: "t",
            icon: Icon(Icons.create),

          )
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 35,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _lista[_selectedIndex],
    );
  }
}

Widget telaLogin(BuildContext context){
  return Container(
    height: MediaQuery.of(context).size.height,
    color: Colors.red,
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Column(
            children: [
              Text("Login")
            ],
          ),
        )
      ],
    ),
  );
}



