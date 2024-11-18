import 'package:turismo/src/pages/login/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  static Store? _store;

  // Obtiene la instancia del Store existente o crea una nueva
  static Future<Store> getStore() async {
    if (_store == null) {
      final dir = await getApplicationDocumentsDirectory();
      _store = await openStore(directory: p.join(dir.path, 'turismo'));
    }
    return _store!;
  }
}
