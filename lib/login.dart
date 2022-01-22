//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxo/controle/CAutenticacao.dart';
import 'package:fluxo/modelo/beans/autenticacao.dart';
import 'package:fluxo/registro.dart';
import 'package:fluxo/splash2.dart';
import 'package:toast/toast.dart';

final styleTextField = TextStyle(
  color: Colors.black,
  fontSize: 18,
);
final styleTexto = TextStyle(
  color: Colors.white,
  fontSize: 22,
);

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  /// bloqueia a rotação, para somente portrait
  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    Color getColor(Set<MaterialState> states) {
      return Colors.white;
    }

    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple[600], Colors.orange])),
        child: Scaffold(
            // widget padrão material
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 250,
                        height: 200,
                        child: Image.asset(
                          "imgs/logo.png",
                          width: 150,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Bem Vindo ao Fluxo de Caixa",
                          style: styleTexto,
                        ),
                      ],
                    ),
                    Divider(),
                    TextField(
                        //autofocus: true,
                        autofocus: true,
                        controller: _tecUsuario,
                        keyboardType: TextInputType.emailAddress,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 25),
                        decoration: InputDecoration(
                          fillColor: Colors.pink[50],
                          filled: true,
                          labelText: "Usuario",
                          labelStyle: TextStyle(color: Colors.black87),
                        )),
                    Divider(),
                    TextField(
                      //autofocus: true,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      style: const TextStyle(color: Colors.black, fontSize: 25),
                      decoration: InputDecoration(
                        //icon: Icon(Icons.attach_money),
                        filled: true,
                        fillColor: Colors.pink[50],
                        labelText: "Senha",
                        //                  hintText: 'secret',
                        border: UnderlineInputBorder(),
                      ),
                      controller: _tecSenha,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Checkbox(
                            value: _checkSeNaoLogin,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            activeColor: Colors.green,
                            checkColor: Colors.green,
                            onChanged: (bool newValue) {
                              setState(() {
                                _checkSeNaoLogin = newValue;
                              });
                            }),
                        Text(
                          'Não solicitar mais login',
                          style: styleTexto,
                        )
                      ],
                    ),
                    ButtonTheme(
                      height: 60.0,
                      child: RaisedButton(
                          onPressed: _onClickLogin,
                          shape: new UnderlineInputBorder(
                            borderRadius: new BorderRadius.circular(0.0),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          child: Text(
                            "Entrar",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          color: Colors.blue[400]),
                    ),
                    Divider(),
                    ButtonTheme(
                      height: 60.0,
                      child: RaisedButton(
                          onPressed: _onCadUser,
                          shape: new UnderlineInputBorder(
                            borderRadius: new BorderRadius.circular(0.0),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          child: Text(
                            "Cadastrar Usuário",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          color: Colors.green),
                    ),
                  ],
                ),
              ),
            ))));
  }

  //chama interface de cadastro de usuário
  void _onCadUser() {
    Toast.show("Em construção...", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    //Navigator.push(context, MaterialPageRoute(builder: (context) => CadastrarUsuario()));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Registro()));
  }

  bool _checkSeNaoLogin = false;
  TextEditingController _tecUsuario = new TextEditingController();
  TextEditingController _tecSenha = new TextEditingController();

  void _onClickLogin() {
    setState(() {
      login();
    });
  }

  Future login() async {
    //currentLocationThis = await currentLocationThis;

    try {
      //CAutenticacao c = new CAutenticacao();
      Autenticacao a = new Autenticacao(_tecUsuario.text, _tecSenha.text);

      if (await new CAutenticacao().logar(a, _checkSeNaoLogin)) {
        print('logado');
        //usuarioLogado = c;
        try {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Splash2()));
        } catch (_) {}
      } else {
        print('não logado');
        _msg("Falha ao logar, verifique seu usuário e senha.");
      }
    } catch (_) {
      _msg("Falha ao logar, Verifique sua conexão, usuário e senha.");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  _msg(String msg) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }
}
