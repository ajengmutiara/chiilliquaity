import 'package:flutter/material.dart';
import 'package:cabaiku/features/tips_pemilihan_cabai_screen.dart';
import 'package:cabaiku/features/tips_pengeringan_cabai_screen.dart';
import 'package:cabaiku/features/tips_penyimpanan_cabai_screen.dart';

class TipsSeputarCabaiScreen extends StatefulWidget {
  const TipsSeputarCabaiScreen({super.key});

  @override
  _TipsSeputarCabaiScreenState createState() => _TipsSeputarCabaiScreenState();
}

class _TipsSeputarCabaiScreenState extends State<TipsSeputarCabaiScreen> {
  String _selectedLanguage = 'id'; // Default language

  final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'title': 'Chili Care Tips',
      'tips_pemilihan': 'Tips for Selecting Chili',
      'tips_pengeringan': 'Tips for Drying Chili',
      'tips_penyimpanan': 'Tips for Storing Chili',
      'quality_img': 'assets/quality.png',
      'tips_pemilihan_img': 'assets/1.png',
      'tips_pengeringan_img': 'assets/2.png',
      'tips_penyimpanan_img': 'assets/3.png',
    },
    'id': {
      'title': 'Tips Seputar Cabai',
      'tips_pemilihan': 'Tips Pemilihan Cabai',
      'tips_pengeringan': 'Tips Pengeringan Cabai',
      'tips_penyimpanan': 'Tips Penyimpanan Cabai',
      'quality_img': 'assets/quality.png',
      'tips_pemilihan_img': 'assets/tips_care.png',
      'tips_pengeringan_img': 'assets/cabekering.png',
      'tips_penyimpanan_img': 'assets/tips_simpan.png',
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
              Text(_localizedStrings[_selectedLanguage]!['title']!),
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
              _localizedStrings[_selectedLanguage]!['quality_img']!,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TipsPemilihanCabaiScreen();
                }));
              },
              child: Image.asset(
                _localizedStrings[_selectedLanguage]!['tips_pemilihan_img']!,
                width: MediaQuery.of(context).size.width * 0.85,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TipsPengeringanCabaiScreen();
                }));
              },
              child: Image.asset(
                _localizedStrings[_selectedLanguage]!['tips_pengeringan_img']!,
                width: MediaQuery.of(context).size.width * 0.85,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TipsPenyimpananCabaiScreen();
                }));
              },
              child: Image.asset(
                _localizedStrings[_selectedLanguage]!['tips_penyimpanan_img']!,
                width: MediaQuery.of(context).size.width * 0.85,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
