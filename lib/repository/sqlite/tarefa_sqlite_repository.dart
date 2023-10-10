import 'package:dioapp/model/tarefa_sqlite_model.dart';
import 'package:dioapp/repository/sqlite/database.dart';

class TarefaSQLiteRepository {
  Future<List<TarefaSQLiteModel>> obterDados(bool apenasNaoConcluidos) async {
    List<TarefaSQLiteModel> tarefas = [];
    var db = await SQLiteDatabase().getDatabase();
    var result = await db.rawQuery(apenasNaoConcluidos
        ? 'SELECT id, descricao, concluido FROM tarefas WHERE concluido = 0'
        : 'SELECT id, descricao, concluido FROM tarefas');
    for (var element in result) {
      tarefas.add(TarefaSQLiteModel(int.parse(element["id"].toString()),
          element["descricao"].toString(), element["concluido"] == 1));
    }

    return tarefas;
  }

  Future<void> salvar(TarefaSQLiteModel tarefaSQLiteModel) async {
    var db = await SQLiteDatabase().getDatabase();

    await db.rawInsert('INSERT INTO tarefas (descricao, concluido) values(?,?)',
        [tarefaSQLiteModel.descricao, tarefaSQLiteModel.concluido]);
  }

  Future<void> atualizar(TarefaSQLiteModel tarefaSQLiteModel) async {
    var db = await SQLiteDatabase().getDatabase();

    await db.rawInsert(
        'UPDATE tarefas SET descricao = ?, concluido = ? WHERE id = ?', [
      tarefaSQLiteModel.descricao,
      tarefaSQLiteModel.concluido,
      tarefaSQLiteModel.id
    ]);
  }

  Future<void> remover(int id) async {
    var db = await SQLiteDatabase().getDatabase();

    await db.rawInsert('DELETE FROM tarefas WHERE id = ?', [id]);
  }
}
