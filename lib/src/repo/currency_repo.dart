import 'package:currency_test/src/local_storage_model/history_currency_moodel.dart';
import 'package:currency_test/src/models/currentPriceModel.dart';
import 'package:currency_test/src/utils/base_api_service.dart';
import 'package:currency_test/src/utils/get_box.dart';
import 'package:currency_test/src/utils/network_api_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CurrencyRepo {
  final BaseApiService _apiService = NetworkApiService();

  Future<CurrentPriceModel> fetchApi() async {
    var respons = await _apiService.getResponse("v1/bpi/currentprice.json");
    CurrentPriceModel data = currentPriceModelFromJson(respons);

    return data;
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

  double changToBTC(double price, double amont) {
    double val = amont * (1 / price);
    return val;
  }

  List<int> generatorPrimeNumber(int num) {
    List<int> res = [];
    for (int i = 2; i <= num; i++) {
      int m = 0, flag = 0;
      m = i ~/ 2;

      for (int j = 2; j <= m; j++) {
        if (i % j == 0) {
          flag = 1;
          break;
        }
      }
      if (flag == 0) {
        res.add(i);
      }
    }

    return res;
  }
}
