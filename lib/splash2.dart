import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluxo/controle/CSincronia.dart';
import 'package:fluxo/visao/menu.dart';
import 'package:toast/toast.dart';

class Splash2 extends StatefulWidget {
  @override
  _Splash2State createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  //método responsável por realizar a sincronização dos dados
  sincronizacao() async {
    await CSincronia().sincronizaDados();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Navegar(0)));
  }

  @override
  void initState() {
    super.initState();
    sincronizacao();
    //espera 3 segundos do splash
    Future.delayed(Duration(seconds: 10)).then((_) {
      Toast.show("não sincronizado", context, duration: 1);
      //muda para a proxima tela
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Navegar(0)));
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
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
