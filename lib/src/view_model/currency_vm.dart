import 'dart:ffi';

import 'package:currency_test/src/models/currentPriceModel.dart';
import 'package:currency_test/src/repo/currency_repo.dart';
import 'package:currency_test/src/utils/response/api_response.dart';
import 'package:flutter/material.dart';

class CurrencyVM extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  ApiResponse<CurrentPriceModel> CurrencyData = ApiResponse.loading();
  final CurrencyRepo _currencyRepo = CurrencyRepo();
  final amontController = TextEditingController();
  double btc = 0;
  String dropDown = "USD";
  List<int> primeNumber = [];

  void fetchPrimeNumber(int num) {
    List<int> res = _currencyRepo.generatorPrimeNumber(num);
    _setPrimeNumber(res);
  }

  void _setPrimeNumber(List<int> val) {
    primeNumber = val;
    notifyListeners();
  }

  void _setCurrency(ApiResponse<CurrentPriceModel> response) {
    CurrencyData = response;

    notifyListeners();
  }

  void _setDropDown(String val) {
    dropDown = val;
    notifyListeners();
  }

  void _setBTC(double val) {
    btc = val;
    notifyListeners();
  }

  _setAmontController(String val) {
    amontController.text = val;
    notifyListeners();
  }

  void switchDropDown(String val) {
    _setDropDown(val);
    calculateBTC(val);
  }

  void calculateBTC(String code) {
    try {
      double.parse(amontController.value.text);
    } catch (e) {
      _setAmontController("");
    }
    if (amontController.value.text == "") {
      _setBTC(0);
    }

    double data = 0;
    switch (code) {
      case "USD":
        data = _currencyRepo.changToBTC(CurrencyData.data!.bpi.usd.rateFloat,
            double.parse(amontController.value.text));
        break;
      case "GBP":
        data = _currencyRepo.changToBTC(CurrencyData.data!.bpi.gbp.rateFloat,
            double.parse(amontController.value.text));
        break;
      case "EUR":
        data = _currencyRepo.changToBTC(CurrencyData.data!.bpi.eur.rateFloat,
            double.parse(amontController.value.text));
        break;
      default:
    }
    _setBTC(data);
  }

  void fetchCurrency() async {
    await _currencyRepo.fetchApi().then(
      (value) {
        _setCurrency(
          ApiResponse.completed(value),
        );
        _currencyRepo.addLocalstorage(value);
      },
    );
  }
}
