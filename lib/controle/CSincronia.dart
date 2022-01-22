import 'package:fluxo/controle/CGastos.dart';
import 'package:fluxo/controle/CReceitas.dart';
import 'package:fluxo/controle/CTipoGasto.dart';
import 'package:fluxo/controle/CTipoReceita.dart';
import 'package:fluxo/modelo/beans/gasto.dart';
import 'package:fluxo/modelo/beans/receita.dart';
import 'package:fluxo/modelo/beans/tipoGasto.dart';
import 'package:fluxo/modelo/beans/tipoReceita.dart';
import 'package:fluxo/modelo/sync/sincroniza.dart';

class CSincronia {
  Future sincronizaDados() async {
    //TODO fazer aqui o controle de data e hora da ultima atualização
    //TODO fazer em todos os controles de alteração do BD atualizar a data local da Ultima Atualização
    bool tipogasto = await _uploadTipoGasto();
    bool tiporeceita = await _uploadTipoReceita();
    bool gasto = await _uploadGasto();
    bool receita = await _uploadReceita();

    print(tipogasto);
    print(tiporeceita);
    print(gasto);
    print(receita);
  }

  Future<bool> _uploadTipoGasto() async {
    try {
      List<TipoGasto> tgs = await CTipoGastos().getAllList();
      Sincroniza().delAllTipoGasto();
      Sincroniza().addTipoGasto(tgs);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> _uploadGasto() async {
    try {
      List<Gasto> tgs = await CGastos().getAllList();
      Sincroniza().delAllGasto();
      Sincroniza().addGasto(tgs);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> _uploadTipoReceita() async {
    try {
      List<TipoReceita> tgs = await CTipoReceitas().getAllList();
      Sincroniza().delAllTipoReceita();
      Sincroniza().addTipoReceita(tgs);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> _uploadReceita() async {
    try {
      List<Receita> tgs = await CReceitas().getAllList();
      Sincroniza().delAllReceita();
      Sincroniza().addReceita(tgs);
    } catch (e) {
      return false;
    }
    return true;
  }
}
