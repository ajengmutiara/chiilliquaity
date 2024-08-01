import 'package:flutter/material.dart';

class TipsPemilihanCabaiScreen extends StatefulWidget {
  const TipsPemilihanCabaiScreen({super.key});

  @override
  _TipsPemilihanCabaiScreenState createState() => _TipsPemilihanCabaiScreenState();
}

class _TipsPemilihanCabaiScreenState extends State<TipsPemilihanCabaiScreen> {
  String _selectedLanguage = 'id'; // Default language

  final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'title': 'Tips for Caring Chili Plants',
      'heading': 'Tips for Caring Chili Plants',
      'description':
          'Proper care of chili plants will help them grow well and bear fruit properly. Here are some steps you can take to care for chili plants:',
      'watering': 'Watering',
      'watering_description':
          'Chili plants need regular watering. Make sure the soil remains moist but not waterlogged. Watering should be done regularly, especially when the plant is fruiting or the weather is very hot.',
      'fertilizing': 'Fertilizing',
      'fertilizing_description':
          'Provide regular fertilizers to meet the nutritional needs of chili plants. Choose fertilizers containing nitrogen, phosphorus, and potassium to help plant growth and good fruit formation.',
      'pruning': 'Pruning',
      'pruning_description':
          'Pruning chili plants can help stimulate growth and fruit production. Cut non-productive or damaged branches to keep the plant healthy and focus on fruit growth.',
      'pest_control': 'Pest and Disease Control',
      'pest_control_description':
          'Monitor plants regularly for signs of pest or disease attacks. Use organic pesticides or other appropriate methods to control pests and diseases of chili plants.',
      'weed_control': 'Weed Control',
      'weed_control_description':
          'Ensure the area around the chili plants remains free of weeds. Weeds can compete with chili plants for nutrients and water.',
      'regular_harvesting': 'Regular Harvesting',
      'regular_harvesting_description':
          'Harvest chili regularly when ripe. This not only prevents excessive fruit rot but also stimulates the plant to continue producing fruit.',
    },
    'id': {
      'title': 'Tips Perawatan Tanaman Cabai',
      'heading': 'Tips Perawatan Tanaman Cabai',
      'description':
          'Merawat tanaman cabai dengan benar akan membantu tanaman tumbuh subur dan berbuah dengan baik. Berikut adalah beberapa langkah yang dapat Anda lakukan untuk merawat tanaman cabai:',
      'watering': 'Penyiraman',
      'watering_description':
          'Tanaman cabai membutuhkan penyiraman yang teratur. Pastikan tanah tetap lembab namun tidak tergenang air. Penyiraman sebaiknya dilakukan secara teratur, terutama saat tanaman sedang berbuah atau cuaca sangat panas.',
      'fertilizing': 'Pemupukan',
      'fertilizing_description':
          'Berikan pupuk secara teratur untuk memenuhi kebutuhan nutrisi tanaman cabai. Pilihlah pupuk yang mengandung nitrogen, fosfor, dan kalium untuk membantu pertumbuhan tanaman dan pembentukan buah yang baik.',
      'pruning': 'Pemangkasan',
      'pruning_description':
          'Pemangkasan cabai dapat membantu merangsang pertumbuhan dan produksi buah. Potong cabang-cabang yang tidak produktif atau yang rusak untuk menjaga tanaman tetap sehat dan fokus pada pertumbuhan buah.',
      'pest_control': 'Perlindungan dari Hama dan Penyakit',
      'pest_control_description':
          'Pantau tanaman secara berkala untuk memeriksa adanya tanda-tanda serangan hama atau penyakit. Gunakan pestisida organik atau metode lain yang tepat untuk mengendalikan hama dan penyakit tanaman cabai.',
      'weed_control': 'Pengendalian Gulma',
      'weed_control_description':
          'Pastikan area sekitar tanaman cabai tetap bersih dari gulma. Gulma dapat bersaing dengan tanaman cabai untuk mendapatkan nutrisi dan air.',
      'regular_harvesting': 'Panen Secara Teratur',
      'regular_harvesting_description':
          'Panen cabai secara teratur ketika sudah matang. Ini tidak hanya mencegah pembusukan buah yang berlebihan tetapi juga merangsang tanaman untuk terus berbuah.',
    }
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 151, 5),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(_localizedStrings[_selectedLanguage]!['title']!),
          backgroundColor: Color.fromARGB(255, 248, 151, 5),
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
                      _localizedStrings[_selectedLanguage]!['heading']!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _localizedStrings[_selectedLanguage]!['description']!,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    _buildTipsItem(
                      _localizedStrings[_selectedLanguage]!['watering']!,
                      _localizedStrings[_selectedLanguage]!
                          ['watering_description']!,
                    ),
                    _buildTipsItem(
                      _localizedStrings[_selectedLanguage]!['fertilizing']!,
                      _localizedStrings[_selectedLanguage]!
                          ['fertilizing_description']!,
                    ),
                    _buildTipsItem(
                      _localizedStrings[_selectedLanguage]!['pruning']!,
                      _localizedStrings[_selectedLanguage]!
                          ['pruning_description']!,
                    ),
                    _buildTipsItem(
                      _localizedStrings[_selectedLanguage]!['pest_control']!,
                      _localizedStrings[_selectedLanguage]!
                          ['pest_control_description']!,
                    ),
                    _buildTipsItem(
                      _localizedStrings[_selectedLanguage]!['weed_control']!,
                      _localizedStrings[_selectedLanguage]!
                          ['weed_control_description']!,
                    ),
                    _buildTipsItem(
                      _localizedStrings[_selectedLanguage]!
                          ['regular_harvesting']!,
                      _localizedStrings[_selectedLanguage]!
                          ['regular_harvesting_description']!,
                    ),
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
                  text: '• $title: ',
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
