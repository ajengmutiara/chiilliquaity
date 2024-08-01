import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class CabaiData {
  final double berat;
  final double kadarAir;
  final String label;

  CabaiData({required this.berat, required this.kadarAir, required this.label});
}

Future<List<CabaiData>> loadCSVData() async {
  final rawData = await rootBundle.loadString("assets/datasetcabairawitmerah.csv");
  List<List<dynamic>> rows = const CsvToListConverter(fieldDelimiter: ';').convert(rawData);

  List<CabaiData> cabaiDataList = [];
  for (int i = 1; i < rows.length; i++) {
    double berat = double.parse(rows[i][0].toString());
    double kadarAir = double.parse(rows[i][1].toString());
    String label = rows[i][2].toString();

    // Debugging prints
    print("Row $i - Berat: $berat, Kadar Air: $kadarAir, Label: $label");

    cabaiDataList.add(CabaiData(berat: berat, kadarAir: kadarAir, label: label));
  }
  return cabaiDataList;
}
