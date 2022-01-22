import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluxo/controle/CAutenticacao.dart';
import 'package:fluxo/controle/CSincronia.dart';
import 'package:fluxo/login.dart';
import 'package:fluxo/modelo/beans/autenticacao.dart';
import 'package:fluxo/splash2.dart';

class Splash1 extends StatefulWidget {
  @override
  _Splash1State createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  bool _login = false;
  _criaUsuarioTeste() async {
    //se não existir o usuário, ele é criado
    Autenticacao a = new Autenticacao("fera", "link");
    if (!await CAutenticacao().existsUsuario())
      await CAutenticacao().criarUsuario(a);

    //verifica se pode ter login ou se deve pular
    _login = await CAutenticacao().getSeLogin();
  }

  @override
  void initState() {
    super.initState();
    _criaUsuarioTeste();
    //espera 3 segundos do splash
    Future.delayed(Duration(seconds: 3)).then((_) {
      //muda para a proxima tela
      if (_login)
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      else
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Splash2()));
    });
  }

  //constroe a tela do splash
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple[600], Colors.orange])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "imgs/logo.png",
                    width: 250,
                    color: Colors.green,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Carregando o Aplicativo",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  )
                ],
              ),
            )));
  }
}
