class Autenticacao{
  String usuario;
  String senha;

  // criando um construtor
  Autenticacao(this.usuario, this.senha);

  Autenticacao.map(dynamic obj) {
    this.usuario = obj['usuario'];
    this.senha = obj['senha'];
  }

  Map<String, dynamic> toMap() {
    var mapa = new Map<String, dynamic>();
    mapa["usuario"] = usuario;
    mapa["senha"] = senha;
    return mapa;
  }

  Autenticacao.fromMap(Map<String, dynamic> mapa) {
    this.usuario = mapa['usuario'];
    this.senha = mapa['senha'];
  }

  Autenticacao.fromJson(Map<String, dynamic> json)
      : this.usuario = json['usuario'],
        this.senha = json['senha'];

  Map<String, dynamic> toJson() {
    return {
      'usuario': usuario,
      'senha': senha,
    };
  }
}