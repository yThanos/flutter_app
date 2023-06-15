import 'package:app_flutter/dao/usuarioDAO.dart';
import 'package:app_flutter/model/usuario.dart';
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
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Email"
                    ),
                    controller: _emailLogin,
                  ),
                  TextField(
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
                      if(usuario.email == "emailNãosExistePuts"){
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Conta não existe"),
                            content: Text("O email informado não pertence a nenhuma conta"),
                          );
                        });
                      }else if(usuario.senha == _senhaLogin.text){
                        setState(() {
                          print("\n\nlogou\n\n");
                          _emailLogin.clear();
                          _senhaLogin.clear();
                        });
                      }else{
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Senha Errada"),
                            content: Text("A senha que você informou esta incoreta!"),
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
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Nome'),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                  ),
                  TextField(
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
            icon: Icon(Icons.login),
            label: "Login"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: "Cria conta"
          )
        ],
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



