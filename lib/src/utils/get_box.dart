import 'package:currency_test/src/local_storage_model/history_currency_moodel.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<CurrencyLocalstorageModel> getHiveCurrency() =>
      Hive.box<CurrencyLocalstorageModel>('currency');
}
