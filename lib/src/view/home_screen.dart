import 'dart:async';
import 'package:cron/cron.dart';
import 'package:currency_test/src/local_storage_model/history_currency_moodel.dart';
import 'package:currency_test/src/models/currentPriceModel.dart';
import 'package:currency_test/src/utils/response/status.dart';
import 'package:currency_test/src/view_model/currency_vm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CurrencyVM viewModel = CurrencyVM();
  final cron = Cron();

  late final Box<CurrencyLocalstorageModel> box;

  @override
  void initState() {
    viewModel.fetchCurrency();
    const oneSec = Duration(seconds: 60);
    Timer.periodic(oneSec, (Timer timer) {
      viewModel.fetchCurrency();
    });
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    viewModel.dispose();
    super.dispose();
  }

  List<String> list = <String>["USD", "GBP", "EUR"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GestureDetector(
              onTap: () {
                context.push("/history");
              },
              child: const Icon(
                Icons.history,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.pink.shade200,
        title: const Text("Currency"),
      ),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              const Text(
                "ChartBitcoin",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ChangeNotifierProvider<CurrencyVM>.value(
                value: viewModel,
                child: Consumer<CurrencyVM>(
                  builder: (context, viewModel, _) {
                    switch (viewModel.CurrencyData.status) {
                      case Status.LOADING:
                        return const CircularProgressIndicator();
                      case Status.ERROR:
                        return Text(viewModel.CurrencyData.message ?? "NA");
                      case Status.COMPLETED:
                        return chartCurrency(
                            context, viewModel.CurrencyData.data!);
                      default:
                    }
                    return Container();
                  },
                ),
              ),
              ChangeNotifierProvider<CurrencyVM>.value(
                  value: viewModel,
                  child: Consumer<CurrencyVM>(
                    builder: (context, viewModel, _) {
                      return Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFieldCuxtom(),
                          ),
                          DropdownButton<String>(
                            value: viewModel.dropDown,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                            onChanged: (String? val) {
                              if (val != null) {
                                viewModel.switchDropDown(val);
                              }
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                        ],
                      );
                    },
                  )),
              ChangeNotifierProvider<CurrencyVM>.value(
                  value: viewModel,
                  child: Consumer<CurrencyVM>(
                    builder: (context, viewModel, _) {
                      return Text("${viewModel.btc.toStringAsFixed(4)} BTC");
                    },
                  )),
              ChangeNotifierProvider<CurrencyVM>.value(
                  value: viewModel,
                  child: Consumer<CurrencyVM>(
                    builder: (context, viewModel, _) {
                      return Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              viewModel.fetchPrimeNumber(500);
                            },
                            child: const Text("สร้างจำนวนเฉพาะ: 2-500"),
                          ),
                          Text(viewModel.primeNumber.toString()),
                        ],
                      );
                    },
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Padding TextFieldCuxtom() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        onChanged: (e) {
          viewModel.calculateBTC(viewModel.dropDown);
        },
        maxLength: 10,
        keyboardType: TextInputType.number,
        controller: viewModel.amontController,
        decoration: const InputDecoration(
          hintText: "ใส่ค่าเงิน",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Column chartCurrency(BuildContext context, CurrentPriceModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(14),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                rowCurrency(data.bpi.usd.code, data.bpi.usd.rate),
                const Divider(),
                rowCurrency(data.bpi.gbp.code, data.bpi.gbp.rate),
                const Divider(),
                rowCurrency(data.bpi.eur.code, data.bpi.eur.rate),
              ],
            ),
          ),
        ),
        Text(
            "LastUpdate: ${data.time.updatedIso.day}/${data.time.updatedIso.month}/${data.time.updatedIso.year}  ${data.time.updatedIso.hour}:${data.time.updatedIso.minute} "),
      ],
    );
  }

  Row rowCurrency(String code, String rate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("BTC"),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(rate),
            Text(code),
          ],
        ),
      ],
    );
  }
}
