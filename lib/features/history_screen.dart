import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cabaiku/features/history_screen_grafik.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<HistoryData> historyList = [];
  bool isLoading = true;
  String searchTimestamp = '';
  final searchTimestampController = TextEditingController();
  String _selectedLanguage = 'id';

  final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'title': 'History',
      'search': 'Search History',
      'no_data': 'No History Data Available',
      'date': 'Date',
      'description': 'Description',
      'analysis_result': 'Analysis Result',
      'grafik': 'Chart',
      'dry': 'Dry',
      'fresh': 'Fresh',
      'undefined': 'Undefined',
      'not_imported': 'Not Imported',
    },
    'id': {
      'title': 'Riwayat',
      'search': 'Cari Riwayat',
      'no_data': 'Data History Belum Ada',
      'date': 'Tanggal',
      'description': 'Keterangan',
      'analysis_result': 'Hasil Analisis',
      'grafik': 'Grafik',
      'dry': 'Kering',
      'fresh': 'Segar',
      'undefined': 'Tidak Terdefinisi',
      'not_imported': 'Bukan Cabai',
    }
  };

  @override
  void initState() {
    super.initState();
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
          backgroundColor: const Color(0xFFFF8C00),
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return HistoryGrafikScreen();
                      }));
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
                          _localizedStrings[_selectedLanguage]!['grafik']!,
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
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchTimestamp = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: _localizedStrings[_selectedLanguage]!['search']!,
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseDatabase.instance.ref('history').onValue,
              builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                  return Center(
                    child: Text(
                      _localizedStrings[_selectedLanguage]!['no_data']!,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  );
                } else {
                  Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                  List<HistoryData> historyList = [];

                  data.forEach((key, value) {
                    var timestamp = value['timestamp'];
                    var kategori = value['kategori'];

                    HistoryData historyData = HistoryData(timestamp, kategori);
                    historyList.add(historyData);
                  });

                  historyList.sort((a, b) => b.timestamp.compareTo(a.timestamp));

                  return ListView.builder(
                    itemCount: historyList.length,
                    itemBuilder: (context, index) {
                      if (searchTimestamp.isNotEmpty &&
                          !historyList[index].timestamp.contains(searchTimestamp)) {
                        return Container(); 
                      }
                      return HistoryCardWidget(
                        historyData: historyList[index],
                        index: index,
                        localizedStrings: _localizedStrings[_selectedLanguage]!,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class HistoryCardWidget extends StatelessWidget {
  const HistoryCardWidget({
    super.key,
    required this.historyData,
    required this.index,
    required this.localizedStrings,
  });

  final HistoryData historyData;
  final int index;
  final Map<String, String> localizedStrings;

  @override
  Widget build(BuildContext context) {
    String colorDetected = '';
    String imageDetected = '';
    if (historyData.kategori == 'Kering') {
      colorDetected = '0xffee1d23';
      imageDetected = 'assets/bad.png';
    } else if (historyData.kategori == 'Segar') {
      colorDetected = '0xff119646';
      imageDetected = 'assets/good.png';
    } else if (historyData.kategori == 'Bukan Cabai') {
      colorDetected = '0xff0000ff'; 
      imageDetected = 'assets/tandasilang.jpg'; // Periksa apakah file gambar ini ada
    } else {
      colorDetected = '0xff000000'; // Default color for undefined categories
      imageDetected = 'assets/tandasilang.jpg'; // Default image for undefined categories
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Center(
                child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, left: 18, right: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${localizedStrings['date']!} : ${historyData.timestamp}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${localizedStrings['description']!} : ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: historyData.kategori,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(int.parse(colorDetected)),
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Image.asset(
                        imageDetected,
                        width: 100,
                      ),
                    )
                  ],
                ),
              ),
            )),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
              child: Center(
                child: Text(
                  "${localizedStrings['analysis_result']!} : ${index + 1}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
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
  final String kategori;

  HistoryData(this.timestamp, this.kategori);
}
