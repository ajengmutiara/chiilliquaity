import 'package:flutter/material.dart';

class TipsPengeringanCabaiScreen extends StatefulWidget {
  const TipsPengeringanCabaiScreen({super.key});

  @override
  _TipsPengeringanCabaiScreenState createState() =>
      _TipsPengeringanCabaiScreenState();
}

class _TipsPengeringanCabaiScreenState extends State<TipsPengeringanCabaiScreen> {
  String _selectedLanguage = 'id'; // Default language

  final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'title': 'Tips for Drying Chili Peppers',
      'heading': 'Tips for Drying Chili Peppers',
      'description':
          'Proper drying of chili peppers can increase their market value. Here are some tips for farmers to improve the selling price of dried chili peppers:',
      'selection_and_harvesting':
          'Selection and Harvesting of Chili Peppers',
      'selection_and_harvesting_description':
          'Select chili peppers that are optimally ripe for drying. Harvest peppers when they have reached the desired size and color for specific types of chili peppers.',
      'good_drying': 'Proper Drying',
      'good_drying_description':
          'The drying process is crucial to obtain quality dried peppers. Ensure that the peppers are thoroughly dried using appropriate methods, such as sunlight or suitable drying machines.',
      'proper_storage': 'Proper Storage',
      'proper_storage_description':
          'After drying, ensure that the peppers are stored in an airtight container to maintain their quality. Avoid direct exposure to sunlight or excessive humidity.',
      'cleaning_and_sorting': 'Cleaning and Sorting',
      'cleaning_and_sorting_description':
          'Before sale, make sure the dried peppers are properly cleaned and sorted. Discard defective or unsuitable peppers to maintain the product image in the market.',
      'attractive_packaging': 'Attractive Packaging',
      'attractive_packaging_description':
          'Pack dried peppers in attractive and hygienic packaging. Clearly label the product and include important information such as the type of chili peppers, net weight, and production date.',
    },
    'id': {
      'title': 'Tips Pengolahan Cabai Kering',
      'heading': 'Tips Pengolahan Cabai Kering',
      'description':
          'Pengolahan cabai kering dengan baik dapat meningkatkan nilai jualnya. Berikut adalah beberapa tips untuk petani dalam meningkatkan harga jual cabai kering:',
      'selection_and_harvesting': 'Pemilihan dan Pemetikan Cabai yang Tepat',
      'selection_and_harvesting_description':
          'Pilih cabai yang matang secara optimal untuk dikeringkan. Pemetikan cabai saat sudah mencapai ukuran dan warna yang diinginkan untuk jenis cabai tertentu.',
      'good_drying': 'Pengeringan yang Baik',
      'good_drying_description':
          'Proses pengeringan sangat penting untuk mendapatkan cabai kering berkualitas. Pastikan cabai dikeringkan secara menyeluruh dengan cara yang tepat, misalnya dengan sinar matahari atau menggunakan mesin pengering yang cocok untuk cabai.',
      'proper_storage': 'Penyimpanan yang Benar',
      'proper_storage_description':
          'Setelah dikeringkan, pastikan cabai disimpan dalam wadah yang kedap udara untuk menjaga kualitasnya. Hindari paparan langsung terhadap sinar matahari atau kelembaban yang berlebihan.',
      'cleaning_and_sorting': 'Pembersihan dan Sortasi',
      'cleaning_and_sorting_description':
          'Sebelum dijual, pastikan cabai dikeringkan dibersihkan dan disortir dengan baik. Buang cabai yang cacat atau tidak layak jual untuk menjaga citra produk Anda di pasaran.',
      'attractive_packaging': 'Pengemasan Menarik',
      'attractive_packaging_description':
          'Kemas cabai kering dalam kemasan yang menarik dan higienis. Label produk dengan jelas dan cantumkan informasi penting seperti jenis cabai, berat bersih, dan tanggal produksi.',
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
          title: Text(_localizedStrings[_selectedLanguage]!['title']!),
          backgroundColor: Color.fromARGB(255, 255, 153, 0),
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
                      _localizedStrings[_selectedLanguage]![
                          'selection_and_harvesting']!,
                      _localizedStrings[_selectedLanguage]![
                          'selection_and_harvesting_description']!,
                    ),
                    _buildTipsItem(
                      _localizedStrings[_selectedLanguage]!['good_drying']!,
                      _localizedStrings[_selectedLanguage]![
                          'good_drying_description']!,
                    ),
                    _buildTipsItem(
                      _localizedStrings[_selectedLanguage]!['proper_storage']!,
                      _localizedStrings[_selectedLanguage]![
                          'proper_storage_description']!,
                    ),
                    _buildTipsItem(
                      _localizedStrings[_selectedLanguage]![
                          'cleaning_and_sorting']!,
                      _localizedStrings[_selectedLanguage]![
                          'cleaning_and_sorting_description']!,
                    ),
                    _buildTipsItem(
                      _localizedStrings[_selectedLanguage]![
                          'attractive_packaging']!,
                      _localizedStrings[_selectedLanguage]![
                          'attractive_packaging_description']!,
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
