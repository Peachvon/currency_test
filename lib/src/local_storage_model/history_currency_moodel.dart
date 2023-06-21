import 'package:hive/hive.dart';
part 'history_currency_moodel.g.dart';

@HiveType(typeId: 0)
class CurrencyLocalstorageModel extends HiveObject {
  @HiveField(0)
  late DateTime time;

  @HiveField(1)
  late String usdCode;

  @HiveField(2)
  late String usdRate;

  @HiveField(3)
  late String gbpCode;

  @HiveField(4)
  late String gbpRate;

  @HiveField(5)
  late String eurCode;

  @HiveField(6)
  late String eurRate;
}
