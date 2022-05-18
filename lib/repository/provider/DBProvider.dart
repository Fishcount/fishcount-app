import 'package:fishcount_app/repository/provider/Queries.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  final int _versaoDB = 1;
  final String _nameDB = 'fishcount.db';

  Future<Database> init() async {
    var databasesPath = await getDatabasesPath();

    String path = join(databasesPath, _nameDB);
    return await openDatabase(
      path,
      version: _versaoDB,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int versao) async {
    for (String query in Querys.queries) {
      await db.execute(query);
    }
    int resultTaxaCrescimento = await db.rawInsert(
      Querys.insertTaxaCrescimento,
      [2.0, "CM", 20, "DIAS"],
    );
    if (resultTaxaCrescimento == 0){
      print("insert de taxa de crescimento");
    }

    int resultEspecie = await db.rawInsert(
      Querys.insertEspecie,
      ["Tilápia", 350.0, "GR", 20.0, "CM", 10, "KG", 250, 1],
    );
    if (resultEspecie == 0){
      print("insert de espécie");
    }
    int resultEspecie2 = await db.rawInsert(
      Querys.insertEspecie,
      ["Carpa", 350.0, "GR", 20.0, "CM", 10, "KG", 250, 1],
    );
    if (resultEspecie2 == 0){
      print("insert de espécie");
    }
  }
}
