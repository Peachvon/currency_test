import 'package:currency_test/src/local_storage_model/history_currency_moodel.dart';
import 'package:currency_test/src/repo/history_repo.dart';
import 'package:flutter/foundation.dart';

class HistoryVM extends ChangeNotifier {
  final List<CurrencyLocalstorageModel> Historydata =
      []; // ignore: non_constant_identifier_names
  final HistoryRepo _historyRepo = HistoryRepo();

  // CurrentPriceModel get fetchApi => null;

  void _setHistory(List<CurrencyLocalstorageModel> response) {
    Historydata.addAll(response);
    notifyListeners();
  }

  void fetchHistory() async {
    await _historyRepo.getHiveHistory().then(
      (value) {
        _setHistory(
          value,
        );
      },
    );
  }
}
