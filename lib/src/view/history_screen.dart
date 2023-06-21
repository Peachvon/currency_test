import 'package:currency_test/src/view_model/history_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final HistoryVM viewModel = HistoryVM();
  List<Map<String, dynamic>> myBooks = [
    {"id": 1, "name": "HTML and CSS", "price": 150},
    {"id": 2, "name": "Python", "price": 250},
    {"id": 3, "name": "Dart", "price": 120},
    {"id": 4, "name": "Java", "price": 100},
    {"id": 5, "name": "JavaScript", "price": 110},
    {"id": 6, "name": "Swift", "price": 90},
    {"id": 7, "name": "C++", "price": 85},
    {"id": 8, "name": "C#", "price": 58},
    {"id": 9, "name": "Python", "price": 120},
    {"id": 10, "name": "Ruby", "price": 55},
    {"id": 11, "name": "FrameWork", "price": 125}
  ];
  @override
  void initState() {
    viewModel.fetchHistory();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: const Text("History"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ChangeNotifierProvider<HistoryVM>.value(
              value: viewModel,
              child: Consumer<HistoryVM>(
                builder: (context, viewModel, _) {
                  return Table(
                    columnWidths: const {
                      0: FractionColumnWidth(0.28),
                      1: FractionColumnWidth(0.24),
                      2: FractionColumnWidth(0.24),
                      3: FractionColumnWidth(0.24),
                    },
                    border: TableBorder.all(),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: List.generate(viewModel.Historydata.length + 1,
                        (index) {
                      if (index == 0) {
                        return TableRowCustom("Time", "USD", "GBP", "ERU");
                      }
                      String time =
                          "${viewModel.Historydata[index - 1].time.day.toString()}/${viewModel.Historydata[index - 1].time.month.toString()}/${viewModel.Historydata[index - 1].time.year.toString()} ${viewModel.Historydata[index - 1].time.hour.toString()}:${viewModel.Historydata[index - 1].time.minute.toString()}";

                      return TableRowCustom(
                          time,
                          viewModel.Historydata[index - 1].usdRate,
                          viewModel.Historydata[index - 1].gbpRate,
                          viewModel.Historydata[index - 1].eurRate);
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

TableRow TableRowCustom(String time, String USD, String GBP, String EUR) {
  Text _text(String val, Color Color) {
    return Text(
      val,
      style: TextStyle(fontSize: 14, color: Color, fontWeight: FontWeight.bold),
    );
  }

  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Center(child: _text(time, Colors.black)),
      ),
      Center(child: _text(USD, Colors.green)),
      Center(child: _text(GBP, Colors.red)),
      Center(child: _text(EUR, Colors.blue)),
    ],
  );
}
