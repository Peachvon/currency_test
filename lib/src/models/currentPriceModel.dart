import 'dart:convert';

CurrentPriceModel currentPriceModelFromJson(String str) =>
    CurrentPriceModel.fromJson(json.decode(str));

class CurrentPriceModel {
  Time time;
  String disclaimer;
  String chartName;
  Bpi bpi;

  CurrentPriceModel({
    required this.time,
    required this.disclaimer,
    required this.chartName,
    required this.bpi,
  });

  factory CurrentPriceModel.fromJson(Map<String, dynamic> json) =>
      CurrentPriceModel(
        time: Time.fromJson(json["time"]),
        disclaimer: json["disclaimer"],
        chartName: json["chartName"],
        bpi: Bpi.fromJson(json["bpi"]),
      );
}

class Bpi {
  Eur usd;
  Eur gbp;
  Eur eur;

  Bpi({
    required this.usd,
    required this.gbp,
    required this.eur,
  });

  factory Bpi.fromJson(Map<String, dynamic> json) => Bpi(
        usd: Eur.fromJson(json["USD"]),
        gbp: Eur.fromJson(json["GBP"]),
        eur: Eur.fromJson(json["EUR"]),
      );
}

class Eur {
  String code;
  String symbol;
  String rate;
  String description;
  double rateFloat;

  Eur({
    required this.code,
    required this.symbol,
    required this.rate,
    required this.description,
    required this.rateFloat,
  });

  factory Eur.fromJson(Map<String, dynamic> json) => Eur(
        code: json["code"],
        symbol: json["symbol"],
        rate: json["rate"],
        description: json["description"],
        rateFloat: json["rate_float"]?.toDouble(),
      );
}

class Time {
  String updated;
  DateTime updatedIso;
  String updateduk;

  Time({
    required this.updated,
    required this.updatedIso,
    required this.updateduk,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        updated: json["updated"],
        updatedIso: DateTime.parse(json["updatedISO"]),
        updateduk: json["updateduk"],
      );
}
