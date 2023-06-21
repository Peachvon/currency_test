import 'package:currency_test/src/local_storage_model/history_currency_moodel.dart';
import 'package:currency_test/src/models/currentPriceModel.dart';
import 'package:currency_test/src/utils/get_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryRepo {
  Future<List<CurrencyLocalstorageModel>> getHiveHistory() async {
    await Hive.openBox<CurrencyLocalstorageModel>('currency');
    final Box<CurrencyLocalstorageModel> box = Boxes.getHiveCurrency();
    return box.values.toList();
  }

  void addLocalstorage(CurrentPriceModel data) async {
    final model = CurrencyLocalstorageModel()
      ..time = data.time.updatedIso
      ..usdCode = data.bpi.usd.code
      ..usdRate = data.bpi.usd.rate
      ..gbpCode = data.bpi.gbp.code
      ..gbpRate = data.bpi.gbp.rate
      ..eurCode = data.bpi.eur.code
      ..eurRate = data.bpi.eur.rate;
    await Hive.openBox<CurrencyLocalstorageModel>('currency');
    final Box<CurrencyLocalstorageModel> box = Boxes.getHiveCurrency();
    //box.clear();
    if (box.values.isEmpty || box.values.last.time != data.time.updatedIso) {
      await box.add(model);
    }
  }
}
