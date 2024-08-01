import 'package:flutter/material.dart';

class TipsPenyimpananCabaiScreen extends StatefulWidget {
  const TipsPenyimpananCabaiScreen({super.key});

  @override
  _TipsPenyimpananCabaiScreenState createState() => _TipsPenyimpananCabaiScreenState();
}

class _TipsPenyimpananCabaiScreenState extends State<TipsPenyimpananCabaiScreen> {
  String _selectedLanguage = 'id'; // Default language

  final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'title': 'Tips for Storing Chili',
      'section_title': 'Tips for Storing Chili',
      'intro': 'Storing fresh and dried chilies should be done carefully to maintain their quality. Here are some tips for storing both types of chilies.',
      'fresh': 'Storing Fresh Chili',
      'temp_humidity': 'Temperature and Humidity: Fresh chili should be stored in cool and dry conditions. The ideal temperature for storing chili is around 10-12°C.',
      'ventilation': 'Good Ventilation: Ensure the chili has enough ventilation when stored. Avoid storing chili in airtight containers, as this can speed up the rotting process.',
      'separate': 'Separate from Other Fruits: Chili can accelerate the ripening of other fruits as it releases ethylene gas. It\'s better to store it separately from other fruits to avoid this issue.',
      'check_rot': 'Check and Remove Rotten Ones: Regularly check stored chili to remove any that have started to rot. This can prevent quick spreading to other chilies.',
      'dry': 'Storing Dried Chili',
      'cool_dry_place': 'Store Chili in a Cool, Dry Place: Place the dried chili container in a cool, dry place, away from direct sunlight and excessive heat.',
      'away_moisture': 'Keep Away from Moisture: Ensure dried chili does not come into contact with moisture, as this can cause the chili to become soft or even moldy.',
      'regular_check': 'Regular Inspection: Occasionally check dried chili to ensure there are no signs of moisture or other issues. Discard chili that is no longer suitable for consumption.',
    },
    'id': {
      'title':'Tips Penyimpanan Cabai',
      'section_title': 'Tips Penyimpanan Cabai',
      'intro': 'Penyimpanan cabai segar dan kering perlu dilakukan dengan hati-hati untuk menjaga kualitasnya. Berikut ini adalah tips untuk penyimpanan kedua jenis cabai tersebut.',
      'fresh': 'Penyimpanan Cabai Segar',
      'temp_humidity': 'Suhu dan Kelembaban: Cabai segar sebaiknya disimpan dalam kondisi yang sejuk dan kering. Suhu ideal untuk penyimpanan cabai adalah sekitar 10-12°C.',
      'ventilation': 'Ventilasi Baik: Pastikan cabai memiliki ventilasi yang cukup saat disimpan. Hindari menyimpan cabai dalam wadah yang kedap udara, karena dapat mempercepat proses pembusukan.',
      'separate': 'Pisahkan dari Buah-buahan Lain: Cabai dapat mempercepat pematangan buah-buahan lain karena melepaskan gas etilen. Lebih baik menyimpannya terpisah dari buah-buahan lain untuk menghindari masalah ini.',
      'check_rot': 'Cek dan Hapus yang Busuk: Rutin periksa cabai yang disimpan untuk menghapus yang sudah mulai membusuk. Ini dapat mencegah penyebaran cepat ke cabai lainnya.',
      'dry': 'Penyimpanan Cabai Kering',
      'cool_dry_place': 'Simpan Cabai di Tempat yang Sejuk dan Kering: Letakkan wadah cabai kering di tempat yang sejuk dan kering, jauh dari sinar matahari langsung dan panas berlebihan.',
      'away_moisture': 'Jauhkan dari Kelembapan: Pastikan cabai kering tidak terkena kelembaban, karena dapat menyebabkan cabai menjadi lembek atau bahkan berjamur.',
      'regular_check': 'Pemeriksaan Rutin: Sesekali periksa cabai kering untuk memastikan tidak ada tanda-tanda kelembaban atau masalah lain. Buang cabai yang sudah tidak layak konsumsi.',
    }
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 149, 10),
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
          backgroundColor: Color.fromARGB(255, 255, 153, 0),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _localizedStrings[_selectedLanguage]!['section_title']!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _localizedStrings[_selectedLanguage]!['intro']!,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    _buildTipsItem(_localizedStrings[_selectedLanguage]!['fresh']!, ''),
                    _buildTipsItem(_localizedStrings[_selectedLanguage]!['temp_humidity']!, ''),
                    _buildTipsItem(_localizedStrings[_selectedLanguage]!['ventilation']!, ''),
                    _buildTipsItem(_localizedStrings[_selectedLanguage]!['separate']!, ''),
                    _buildTipsItem(_localizedStrings[_selectedLanguage]!['check_rot']!, ''),
                    _buildTipsItem(_localizedStrings[_selectedLanguage]!['dry']!, ''),
                    _buildTipsItem(_localizedStrings[_selectedLanguage]!['cool_dry_place']!, ''),
                    _buildTipsItem(_localizedStrings[_selectedLanguage]!['away_moisture']!, ''),
                    _buildTipsItem(_localizedStrings[_selectedLanguage]!['regular_check']!, ''),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTipsItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '• $title ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: description,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
