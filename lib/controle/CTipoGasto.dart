import 'package:fluxo/modelo/bd/bd_core.dart';
import 'package:fluxo/modelo/beans/gasto.dart';
import 'package:fluxo/modelo/beans/tipoGasto.dart';

class CTipoGastos{

  Future<int> insert(TipoGasto g) async {
    int id = await BdCore.instance.insert(g.toMap(),BdCore.tableTipoGasto);
    print('linha inserida id: $id');
    return id;
  }
  Future<int> update(TipoGasto g) async {
    final linhasAfetadas = await BdCore.instance.update(g.toMap(),BdCore.tableTipoGasto);
    print('atualizadas $linhasAfetadas linha(s)');
    return linhasAfetadas;
  }
  Future<int> deletar(int id) async {
    final linhaDeletada = await BdCore.instance.delete(id, BdCore.tableTipoGasto);
    print('Deletada(s) $linhaDeletada linha(s): linha $id');
    return linhaDeletada;
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final todasLinhas = await BdCore.instance.queryAllRows(BdCore.tableTipoGasto);
    print('Consulta todas as linhas:');
    todasLinhas.forEach((row) => print(row));
    return todasLinhas;
  }

  Future<List<TipoGasto>> getAllList() async {
    final todasLinhas = await BdCore.instance.queryAllRows(BdCore.tableTipoGasto);
    List<TipoGasto> lg = List.generate(todasLinhas.length, (i) {
      return TipoGasto(
          todasLinhas[i]['id'],
          todasLinhas[i]['nome'],
          todasLinhas[i]['descricao']
      );
    });
    return lg;
  }

  Future<TipoGasto> get(int id) async {
    String sql = ""
        "SELECT * "
        "FROM tipogasto "
        "WHERE id = $id;";
    final todasLinhas = await BdCore.instance.querySQL(sql);
    List<TipoGasto> lg = List.generate(todasLinhas.length, (i) {
      return TipoGasto(
          todasLinhas[i]['id'],
          todasLinhas[i]['nome'],
          todasLinhas[i]['descricao'],
      );
    });
    TipoGasto c = null;
    try {
      c = lg.elementAt(0);
    }catch(_){}
    return c;
  }
}
