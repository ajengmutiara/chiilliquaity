import 'dart:io';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cabaiku/classifier/classifier.dart';
import 'package:cabaiku/core/constants.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class HasilAnalisaScreen extends StatefulWidget {
  const HasilAnalisaScreen({super.key, required this.selectedImageFile});

  final File? selectedImageFile;

  @override
  State<HasilAnalisaScreen> createState() => _HasilAnalisaScreenState();
}

class _HasilAnalisaScreenState extends State<HasilAnalisaScreen> {
  String _detectedImage = "Tidak Terdefinisi!";
  String _detectedAccuracy = "0.0";
  String _detectedKadarAir = "0.0";
  double detectedKadarAir = 0.0;
  String colorDetected = '';
  String _detectedAnalysisImage = '';
  late Classifier _classifier;
  bool _isDetecting = false;
  bool _isSaving = false;
  String _selectedLanguage = 'id'; // Default language

  final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'image_not_defined': 'Not Defined!',
      'try_another_detection': 'Try Another Detection?',
      'do_you_want_to_try_another_detection': 'Do you want to try another detection?',
      'yes': 'Yes',
      'no': 'No',
      'confirmation': 'Confirmation',
      'do_you_want_to_save_the_detection_results': 'Do you want to save the detection results?',
      'detected_image': 'Detected Image:',
      'detected_accuracy': 'Accuracy:',
      'done': 'Done',
    },
    'id': {
      'image_not_defined': 'Tidak Terdefinisi!',
      'try_another_detection': 'Mencoba Hasil Deteksi Lain?',
      'do_you_want_to_try_another_detection': 'Apakah Anda ingin mencoba deteksi yang lain?',
      'yes': 'Ya',
      'no': 'Tidak',
      'confirmation': 'Konfirmasi',
      'do_you_want_to_save_the_detection_results': 'Apakah Anda Ingin Menyimpan Hasil Deteksi?',
      'detected_image': 'Gambar Terdeteksi:',
      'detected_accuracy': 'Akurasi:',
      'done': 'Selesai',
    }
  };

  List<List<dynamic>> _csvData = [];

  @override
  void initState() {
    super.initState();
    _loadClassifier();
    _loadCSV();
    detectedKadarAir = (0 * 100).truncateToDouble() / 100;
  }

  Future<void> _loadCSV() async {
    final data = await rootBundle.loadString('assets/datacabai.csv');
    List<List<dynamic>> csvTable = CsvToListConverter().convert(data);
    setState(() {
      _csvData = csvTable;
    });
  }

  Future<void> _loadClassifier() async {
    debugPrint(
      'Start loading of Classifier with '
      'labels at $tfLiteLabel, '
      'model at $tfLiteModel',
    );

    final classifier = await Classifier.loadWith(
      labelsFileName: tfLiteLabel,
      modelFileName: tfLiteModel,
    );

    setState(() {
      _classifier = classifier!;
      _detectImage();
    });
  }

  Future<void> _detectImage() async {
    _setDetecting(true);

    if (widget.selectedImageFile == null) {
      return;
    }

    File image = File(widget.selectedImageFile!.path);

    final imageInput = img.decodeImage(image.readAsBytesSync())!;

    final resultCategory = _classifier.predict(imageInput);

    final result = resultCategory.score >= 0.8 ? setLabel("Cabai") : setLabel("Bukan Cabai");
    final plantLabel = resultCategory.label;

    final accuracy = resultCategory.score * 100; // Convert to percentage
    double formattedAccuracy = (accuracy * 100).truncateToDouble() / 100;

    setLabel(plantLabel);
    if (plantLabel != "Bukan Cabai") {
      setAccuracy(formattedAccuracy.toString());
    } else {
      setAccuracy(""); // No accuracy for "Bukan Cabai"
    }

    _setDetecting(false);
    displayWaterContent(plantLabel);
  }

  void displayWaterContent(String label) {
    for (var row in _csvData) {
      if (row[2] == label) {
        setState(() {
          _detectedKadarAir = row[0].toString();
        });
        break;
      }
    }
  }

  void setLabel(String label) {
    setState(() {
      _detectedImage = label;
      if (_detectedImage == 'Kering') {
        colorDetected = '0xffee1d23';
        _detectedAnalysisImage = _selectedLanguage == 'id'
            ? 'assets/analisa_kering.png'
            : 'assets/analisis_dry.png';

        // Set kadar air untuk 'Kering'
        _detectedKadarAir = (Random().nextDouble() * (11 - 5) + 5).toStringAsFixed(2);

      } else if (_detectedImage == 'Segar') {
        colorDetected = '0xff119646';
        _detectedAnalysisImage = _selectedLanguage == 'id'
            ? 'assets/analisa_segar.png'
            : 'assets/analisis_fresh.png';

        // Set kadar air untuk 'Segar'
        _detectedKadarAir = (Random().nextDouble() * (45 - 40) + 50).toStringAsFixed(2);
      } else if (_detectedImage == 'Bukan Cabai') {
        colorDetected = '0xff000000'; // Ubah warna menjadi hitam misalnya
        _detectedKadarAir = ""; // Tidak ada kadar air untuk "Bukan Cabai"
      }
    });
  }

  void setAccuracy(String accuracy) {
    setState(() {
      _detectedAccuracy = accuracy;
    });
  }

  void _setDetecting(bool status) {
    setState(() {
      _isDetecting = status;
    });
  }

  Future<bool> _onBackPressed() async {
    bool confirmExit = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_localizedStrings[_selectedLanguage]!['try_another_detection']!),
          content: Text(_localizedStrings[_selectedLanguage]!['do_you_want_to_try_another_detection']!),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                _localizedStrings[_selectedLanguage]!['yes']!,
                style: TextStyle(color: Color(int.parse("0xff119646"))),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                _localizedStrings[_selectedLanguage]!['no']!,
                style: TextStyle(color: Color(int.parse("0xff119646"))),
              ),
            ),
          ],
        );
      },
    );

    if (confirmExit ?? false) {
      Navigator.pop(context);
    }
    return false;
  }

  Future<void> _showConfirmationDialog() async {
    bool shouldSave = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_localizedStrings[_selectedLanguage]!['confirmation']!),
          content: Text(_localizedStrings[_selectedLanguage]!['do_you_want_to_save_the_detection_results']!),
          actions: <Widget>[
            TextButton(
              child: Text(
                _localizedStrings[_selectedLanguage]!['no']!,
                style: TextStyle(color: Color(int.parse("0xff119646"))),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(
                _localizedStrings[_selectedLanguage]!['yes']!,
                style: TextStyle(color: Color(int.parse("0xff119646"))),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (shouldSave == true) {
      _saveToFirebase();
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _saveToFirebase() {
    final DatabaseReference historyRef = FirebaseDatabase.instance.ref().child('history');

    String timestamp = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

    historyRef.push().set({
      'timestamp': timestamp,
      'kategori': _detectedImage,
      'kadar_air': _detectedKadarAir,
    }).then((value) {
      print("Data saved to Firebase");
    }).catchError((error) {
      print("Failed to save data: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Predicted Kadar Air: $_detectedKadarAir');
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 32, right: 32, bottom: 12),
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Image.asset(
                          'assets/btn_kembali.png',
                          width: 14,
                        ),
                        onTap: () {
                          _onBackPressed();
                        },
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
                    ],
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 136, 0), // Mengubah warna latar belakang menjadi oranye
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: widget.selectedImageFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                widget.selectedImageFile!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/img_not_exist.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[350],
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(height: 50),
                                  Text(
                                    _detectedImage,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(int.parse(colorDetected)),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(int.parse("0xFFFF8C00")),
                            ),
                            child: Center(
                              child: Text(
                                _localizedStrings[_selectedLanguage]!['detected_image']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_detectedImage != "Bukan Cabai")
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[350],
                              ),
                              child: Center(
                                child: Text(
                                  "$_detectedAccuracy%",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Color(int.parse(colorDetected)),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(int.parse("0xFFFF8C00")),
                              ),
                              child: Center(
                                child: Text(
                                  _localizedStrings[_selectedLanguage]!['detected_accuracy']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  if (_detectedImage != "Bukan Cabai")
                    Column(
                      children: [
                        Text(
                          'Kadar Air: $_detectedKadarAir%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        if (_detectedImage == 'Segar' || _detectedImage == 'Kering')
                          Image.asset(
                            _detectedAnalysisImage,
                            height: MediaQuery.of(context).size.height * 0.8,
                          ),
                      ],
                    ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(int.parse("0xFFFF8C00")),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          _showConfirmationDialog();
                        },
                        child: Text(
                          _localizedStrings[_selectedLanguage]!['done']!,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  (_isDetecting)
                      ? const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
