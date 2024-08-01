import 'package:flutter/material.dart';
import 'package:cabaiku/features/tips_pemilihan_cabai_screen.dart';
import 'package:cabaiku/features/tips_pengeringan_cabai_screen.dart';
import 'package:cabaiku/features/tips_penyimpanan_cabai_screen.dart';
import 'package:cabaiku/features/distribusicabaisegar.dart';
import 'package:cabaiku/features/distribusicabaikering.dart';

class TempatDistribusiScreen extends StatefulWidget {
  const TempatDistribusiScreen({Key? key}) : super(key: key);

  @override
  _TempatDistribusiScreenState createState() => _TempatDistribusiScreenState();
}

class _TempatDistribusiScreenState extends State<TempatDistribusiScreen> {
  String _selectedLanguage = 'id'; // Default language

  final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'distribusi_cabai': 'Chili Distribution Place',
      'distribusi_segar': 'assets/4.png',
      'distribusi_kering': 'assets/5.png',
    },
    'id': {
      'distribusi_cabai': 'Tempat Distribusi Cabai',
      'distribusi_segar': 'assets/distribusi_segar.png',
      'distribusi_kering': 'assets/distribusi_kering.png',
    }
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(int.parse("0xFFFF8C00")),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_localizedStrings[_selectedLanguage]!['distribusi_cabai']!),
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
          backgroundColor: Color(int.parse("0xFFFF8C00")),
        ),
        body: Center(
          child: Column(children: [
            SizedBox(height: 20),
            Image.asset(
              'assets/quality.png',
              width: MediaQuery.of(context).size.width * 0.4,
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DistribusiCabaiSegarScreen();
                }));
              },
              child: Image.asset(
                _localizedStrings[_selectedLanguage]!['distribusi_segar']!,
                width: MediaQuery.of(context).size.width * 0.85,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DistribusiCabaiKeringScreen();
                }));
              },
              child: Image.asset(
                _localizedStrings[_selectedLanguage]!['distribusi_kering']!,
                width: MediaQuery.of(context).size.width * 0.85,
              ),
            ),
            SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }
}
