// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxo/login.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'controle/CAutenticacao.dart';
import 'modelo/beans/autenticacao.dart';

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
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
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple[600], Colors.orange])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
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
                          "Cadastre-se para usar o aplicativo",
                          style: styleTexto,
                        ),
                      ],
                    ),
                    const Divider(),
                    TextField(
                        autofocus: true,
                        controller: _user,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 25),
                        decoration: InputDecoration(
                          fillColor: Colors.pink[50],
                          filled: true,
                          labelText: "Usuario",
                          labelStyle: TextStyle(color: Colors.black),
                        )),
                    const Divider(),
                    ButtonTheme(
                      height: 60.0,
                      child: RaisedButton(
                          onPressed: scan,
                          shape: new UnderlineInputBorder(
                            borderRadius: new BorderRadius.circular(0.0),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          child: Text(
                            "Escanear QR code",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          color: Colors.blue[400]),
                    ),
                    const Divider(),
                    TextField(
                        autofocus: true,
                        obscureText: true,
                        controller: _password,
                        keyboardType: TextInputType.text,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 25),
                        decoration: InputDecoration(
                          labelText: "Senha",
                          labelStyle: TextStyle(color: Colors.black),
                          fillColor: Colors.pink[50],
                          filled: true,
                        )),
                    const Divider(),
                    ButtonTheme(
                      height: 60.0,
                      child: RaisedButton(
                        onPressed: _fazRegistro,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0)),
                        child: const Text(
                          "Cadastrar",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ))));
  }

  TextEditingController _user = new TextEditingController();
  TextEditingController _password = TextEditingController();

  Future _fazRegistro() async {
    try {
      Autenticacao a = new Autenticacao(_user.text, _password.text);
      if (await new CAutenticacao().criarUsuario(a)) {
        try {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
        } catch (_) {}
      } else {
        print('não criado');
        print("Falha ao criar, verifique seu usuário e senha.");
      }
    } catch (_) {
      print("Falha ao criar, Verifique sua conexão, usuário e senha.");
    }
  }

  String _codigo = "";
  Future scan() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", false, ScanMode.DEFAULT);
    setState(() => this._user.text = barcodeScanRes);
  }
}
