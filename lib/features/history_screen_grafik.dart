import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cabaiku/features/history_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryGrafikScreen extends StatefulWidget {
  const HistoryGrafikScreen({super.key});

  @override
  State<HistoryGrafikScreen> createState() => _HistoryGrafikScreenState();
}

class _HistoryGrafikScreenState extends State<HistoryGrafikScreen> {
  List<HistoryDataGrafik> chartDataGrafik = [];
  late TooltipBehavior _tooltipBehavior;
  int isBasah = 0;
  String _selectedLanguage = 'id'; // Default language

  final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'title': 'History',
      'chart_title': 'Category Chart',
      'list': 'List',
      'fresh': 'Fresh',
      'dry': 'Dry',
      'undefined': 'Undefined',
      'not_chili': 'Not Chili',
    },
    'id': {
      'title': 'Riwayat',
      'chart_title': 'Grafik Kategori',
      'list': 'Daftar',
      'fresh': 'Segar',
      'dry': 'Kering',
      'undefined': 'Tidak Terdefinisi',
      'not_chili': 'Bukan Cabai',
    }
  };

  @override
  void initState() {
    fetchLogDetectionChart();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  Future<void> fetchLogDetectionChart() async {
    List<HistoryDataGrafik> chartData = [];
    final DatabaseReference historyGrafikRef = FirebaseDatabase.instance.ref('history');
    final dataSnapshot = await historyGrafikRef.once();
    Map<dynamic, dynamic> data = dataSnapshot.snapshot.value as dynamic;
    data.forEach((key, value) {
      var timestamp = value['timestamp'];
      var kategori = value['kategori'];
      if (kategori == 'Segar') {
        isBasah = 2;
      } else if (kategori == 'Kering') {
        isBasah = 1;
      } else if (kategori == 'Bukan Cabai') {
        isBasah = 0;
      } else {
        isBasah = -1;
      }

      HistoryDataGrafik logData = HistoryDataGrafik(timestamp, isBasah);
      chartData.add(logData);
    });

    chartData.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    if (chartData.length > 5) {
      chartData.removeRange(0, chartData.length - 5);
    }

    setState(() {
      chartDataGrafik = chartData;
    });

    print("CekDataGrafik $chartDataGrafik");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFF8C00),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(_localizedStrings[_selectedLanguage]!['title']!),
          backgroundColor: const Color(0xFFFF8C00), // Change the background color here
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/quality.png',
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                DropdownButton<String>(
                  value: _selectedLanguage,
                  items: [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text('EN'),
                    ),
                    DropdownMenuItem(
                      value: 'id',
                      child: Text('ID'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HistoryScreen();
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          _localizedStrings[_selectedLanguage]!['list']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: const Color(0xFFFF8C00),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                child: SfCartesianChart(
                  title: ChartTitle(
                    text: _localizedStrings[_selectedLanguage]!['chart_title']!,
                    borderWidth: 10,
                  ),
                  tooltipBehavior: _tooltipBehavior,
                  series: <CartesianSeries>[
                    ColumnSeries<HistoryDataGrafik, String>(
                      name: _localizedStrings[_selectedLanguage]!['chart_title']!,
                      dataSource: chartDataGrafik,
                      xValueMapper: (HistoryDataGrafik gdp, _) => gdp.timestamp,
                      yValueMapper: (HistoryDataGrafik gdp, _) => gdp.isBasah,
                      dataLabelMapper: (HistoryDataGrafik gdp, _) {
                        if (gdp.isBasah == 2) {
                          return _localizedStrings[_selectedLanguage]!['fresh']!;
                        } else if (gdp.isBasah == 1) {
                          return _localizedStrings[_selectedLanguage]!['dry']!;
                        } else if (gdp.isBasah == 0) {
                          return _localizedStrings[_selectedLanguage]!['not_chili']!;
                        }
                        return _localizedStrings[_selectedLanguage]!['undefined']!;
                      },
                      pointColorMapper: (HistoryDataGrafik gdp, _) {
                        if (gdp.isBasah == 2) {
                          return Colors.green;
                        } else if (gdp.isBasah == 1) {
                          return Colors.red;
                        } else if (gdp.isBasah == 0) {
                          return Colors.blue;
                        }
                        return Colors.grey;
                      },
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                    )
                  ],
                  primaryXAxis: CategoryAxis(
                    labelRotation: 90,
                  ),
                  primaryYAxis: NumericAxis(
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class HistoryData {
  final String timestamp;
  final String kadarAir;
  final String kategori;

  HistoryData(this.timestamp, this.kadarAir, this.kategori);
}

class HistoryDataGrafik {
  final String timestamp;
  final int isBasah;

  HistoryDataGrafik(this.timestamp, this.isBasah);
}
