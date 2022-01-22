import 'dart:convert';

import 'package:fluxo/modelo/bd/bd_core.dart';
import 'package:fluxo/modelo/beans/autenticacao.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String OP_USUARIOSENHA = "usuariosenha";
const String OP_SEMLOGIN = "semlogin";

class CAutenticacao {

  /**
   * Método que testa se existe algum usuário já cadastrado
   */
  Future<bool>existsUsuario()async{
    //busca string json persistida
    String jsonString = null;
    try {
      jsonString = await _getVariavelSharedPreferences(OP_USUARIOSENHA);
    }catch(e){
      print("erro ao veirificar variável");
    }
    //testa se tem usuário cadastrado
    if(jsonString == null)
      return false;
    else
      return true;
  }

  /**
   * Método que recebe usuário e senha e opção por não aparecer a tela
   * de login no próximo acesso. Responsável por fazer a autenticação
   */
  Future<bool>logar(Autenticacao autRequisicao, bool _semLogin)async{
    //busca string json persistida
    String jsonString = await _getVariavelSharedPreferences(OP_USUARIOSENHA);
    //transfomra string json em objeto
    Autenticacao autPersistido = Autenticacao.fromMap(json.decode(jsonString));

    //testa se o usuário e a senha conferem
    if(autRequisicao.usuario == autPersistido.usuario &&
        autRequisicao.senha == autPersistido.senha) {
      //verificação se vai eliminar ou não o login no proximo acesso
      if (_semLogin) _setSemLogin(); else _setComLogin();

      return true;
    }else
      return false;
  }

  /**
   * Método que cria o usuário,
   * zerando todos os dados anteriores do BD
   */
  Future<bool>criarUsuario(Autenticacao autRequisicao)async{
    try {
      //deleta todos os registros do banco
      await BdCore.instance.executeSQL("DELETE FROM ${BdCore.tableGasto};");
      await BdCore.instance.executeSQL("DELETE FROM ${BdCore.tableReceita};");
      await BdCore.instance.executeSQL("DELETE FROM ${BdCore.tableTipoGasto};");
      await BdCore.instance.executeSQL("DELETE FROM ${BdCore.tableTipoReceita};");
    }catch(e){}

    //converte o objeto de requisição em json
    String jsonString = json.encode(autRequisicao);
    print(jsonString);
    //substitui valor da chave usuariosenha
    _setVariavelSharedPreferences(OP_USUARIOSENHA, jsonString);
    //exige que a tela de login apareca
    _setComLogin();
    return true;
  }

  /**
   * método que seta que é pra não aparecer a tela de login
   */
  Future<bool>_setSemLogin()async{
    _setVariavelSharedPreferences(OP_SEMLOGIN, "no_login");
    return true;
  }
  Future<bool>_setComLogin()async{
    _setVariavelSharedPreferences(OP_SEMLOGIN, "ok_login");
    return true;
  }

  /**
   * Método que testa se é pra aparecer ou não a tela de login
   */
  Future<bool>getSeLogin()async{
    String string = "ok_login";
    try {
      //busca string json persistida
      string = await _getVariavelSharedPreferences(OP_SEMLOGIN);
    }catch(e){}

    //testa se está setadopara haver ou não login
    if( string == "ok_login")
      return true;
    else
      return false;
  }

  /**
   * String SharedPreferences
   * Método para recuperar o valor(string) da chave em questão
   */
  Future<String> _getVariavelSharedPreferences(String OPCAO) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString(OPCAO) ?? false);
  }

  /**
   * String SharedePreferences
   * Método para setar persistentemente o valor(string) da chave em questão
   */
  _setVariavelSharedPreferences(String OPCAO, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(OPCAO, value);
  }
}
