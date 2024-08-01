import 'package:flutter/material.dart';

class InformasiScreen extends StatefulWidget {
  const InformasiScreen({super.key});

  @override
  _InformasiScreenState createState() => _InformasiScreenState();
}

class _InformasiScreenState extends State<InformasiScreen> {
  String _selectedLanguage = 'id'; // Default language

  final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'title': 'Info',
    },
    'id': {
      'title': 'Info',
    }
  };

  final Map<String, String> _imagePaths = {
    'en': 'assets/info2.png',
    'id': 'assets/info_tentang.png',
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
          title: Text(_localizedStrings[_selectedLanguage]!['title']!),
          backgroundColor: Color(int.parse("0xFFFF8C00")),
          actions: [
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Image.asset(
                  _imagePaths[_selectedLanguage]!,
                  width: MediaQuery.of(context).size.width * 0.85,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
