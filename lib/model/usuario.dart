class Usuario{
  int? codigo;
  String email;
  String senha;
  String? nome;
  String? telefone;
  Usuario({required this.email, required this.senha, this.telefone, this.nome, this.codigo});

  Map<String, dynamic> toMap(){
    return {
      'email': email,
      'senha': senha,
      'nome': nome,
      'telefone': telefone
    };
  }

  Usuario.fromMap(Map<String, dynamic> map):
    email = map['email'],
    senha = map['senha'],
    codigo = map['codigo'],
    nome = map['nome'],
    telefone = map['telefone'];
}