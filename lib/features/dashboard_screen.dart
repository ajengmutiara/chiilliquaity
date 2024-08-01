import 'package:flutter/material.dart';
import 'package:cabaiku/features/deteksi_citra_screen.dart';
import 'package:cabaiku/features/history_screen.dart';
import 'package:cabaiku/features/informasi_screen.dart';
import 'package:cabaiku/features/tips_seputar_cabai_screen.dart';
import 'package:cabaiku/features/tempat_distribusi_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _selectedLanguage = 'id'; // Default language
  final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'title': '',
      'cek_kualitas_cabai': 'Check Chili Quality',
      'history': 'History',
      'tips_seputar_cabai': 'Chili Tips',
      'tempat_distribusi_cabai': 'Chili Distribution Places',
      'informasi': 'Information',
    },
    'id': {
      'title': '',
      'cek_kualitas_cabai': 'Cek Kualitas Cabai',
      'history': 'Riwayat',
      'tips_seputar_cabai': 'Tips Seputar Cabai',
      'tempat_distribusi_cabai': 'Tempat Distribusi Cabai',
      'informasi': 'Informasi',
    }
  };

  @override
  void initState() {
    super.initState();
    _precacheImages();
  }

  Future<void> _precacheImages() async {
    await Future.wait([
      precacheImage(Image.asset("assets/quality.png").image, context),
      precacheImage(Image.asset("assets/bg_baru.png").image, context),
      precacheImage(Image.asset("assets/deteksi.png").image, context),
      precacheImage(Image.asset("assets/dokumen.png").image, context),
      precacheImage(Image.asset("assets/lampu.png").image, context),
      precacheImage(Image.asset("assets/info.png").image, context),
      precacheImage(Image.asset("assets/distribusi.png").image, context),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/bg_baru.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DropdownButton<String>(
                        value: _selectedLanguage,
                        items: [
                          DropdownMenuItem(
                            value: 'en',
                            child: Text('EN'),
                          ),
                          DropdownMenuItem(
                            value: 'id',
                            child: Text('IN'),
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
                  Image.asset(
                    "assets/quality.png",
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _localizedStrings[_selectedLanguage]!['title']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        _buildMenuItem(
                          context,
                          "assets/deteksi.png",
                          _localizedStrings[_selectedLanguage]!['cek_kualitas_cabai']!,
                          DeteksiCitraScreen(),
                        ),
                        _buildMenuItem(
                          context,
                          "assets/dokumen.png",
                          _localizedStrings[_selectedLanguage]!['history']!,
                          HistoryScreen(),
                        ),
                        _buildMenuItem(
                          context,
                          "assets/lampu.png",
                          _localizedStrings[_selectedLanguage]!['tips_seputar_cabai']!,
                          TipsSeputarCabaiScreen(),
                        ),
                        _buildMenuItem(
                          context,
                          "assets/distribusi.png",
                          _localizedStrings[_selectedLanguage]!['tempat_distribusi_cabai']!,
                          TempatDistribusiScreen(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return InformasiScreen();
                            }));
                          },
                          child: Image.asset(
                            "assets/info.png",
                            width: MediaQuery.of(context).size.width * 0.12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String imagePath, String title, Widget screen) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 243, 190, 15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
