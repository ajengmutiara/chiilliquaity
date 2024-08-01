import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:cabaiku/features/hasil_analisa_screen.dart';

class DeteksiCitraScreen extends StatefulWidget {
  const DeteksiCitraScreen({super.key});

  @override
  State<DeteksiCitraScreen> createState() => _DeteksiCitraScreenState();
}

class _DeteksiCitraScreenState extends State<DeteksiCitraScreen> {
  File? selectedImageFile;
  bool _isAnalyzing = false;
  String _selectedLanguage = 'id'; // Default language

  final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'title': 'Image Detection',
      'guide_title': 'User Guide',
      'guide_text': 'There are two ways to take a picture of chili, either by using the camera directly by pressing the \'Take Picture\' button or by taking a picture from the device gallery by pressing the button with the gallery icon, then press the \'Check Chili Quality\' button to process the image.',
      'take_picture': 'Take Picture',
      'gallery': 'Gallery',
      'check_quality': 'Check Chili Quality',
      'confirm_exit_title': 'Confirmation',
      'confirm_exit_text': 'Are you sure you want to cancel the detection?',
      'yes': 'Yes',
      'no': 'No',
      'error_gallery': 'Failed to Pick Image',
      'error_camera': 'Failed to Capture Image',
    },
    'id': {
      'title': 'Deteksi Citra',
      'guide_title': 'Panduan Penggunaan',
      'guide_text': 'Terdapat dua cara dalam mengambil gambar cabai yaitu menggunakan kamera secara langsung dengan menekan tombol ‘Ambil Gambar’ atau mengambil gambar dari galeri perangkat dengan menekan tombol dengan icon galeri, lalu tekan tombol ‘Cek Kualitas Cabai’ untuk mengolah gambar.',
      'take_picture': 'Ambil Gambar',
      'gallery': 'Galeri',
      'check_quality': 'Cek Kualitas Cabai',
      'confirm_exit_title': 'Konfirmasi',
      'confirm_exit_text': 'Apakah Anda yakin ingin membatalkan deteksi?',
      'yes': 'Ya',
      'no': 'Tidak',
      'error_gallery': 'Gagal Mengambil Gambar',
      'error_camera': 'Gagal Mengambil Gambar',
    }
  };

  Future<File?> _imgFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (imageFile != "null" && imageFile != null) {
      setState(() {
        selectedImageFile = File(imageFile.path); // Store the selected image file
      });
      return File(imageFile.path);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_localizedStrings[_selectedLanguage]!['error_gallery']!),
        ));
      }
    }

    return null;
  }

  Future<File?> _imgFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (imageFile != "null" && imageFile != null) {
      setState(() {
        selectedImageFile = File(imageFile.path); // Store the selected image file
      });
      return File(imageFile.path);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_localizedStrings[_selectedLanguage]!['error_camera']!),
        ));
      }
    }
    return null;
  }

  Future<bool> _onBackPressed() async {
    if (selectedImageFile != null) {
      bool confirmExit = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(_localizedStrings[_selectedLanguage]!['confirm_exit_title']!),
            content: Text(_localizedStrings[_selectedLanguage]!['confirm_exit_text']!),
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
                child: Text(_localizedStrings[_selectedLanguage]!['no']!,
                    style: TextStyle(color: Color(int.parse("0xff119646")))),
              ),
            ],
          );
        },
      );

      if (confirmExit ?? false) {
        // Navigate back if the user confirms
        Navigator.pop(context);
      }
      return false;
    } else {
      Navigator.pop(context);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
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
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 24.0,
              left: 32,
              right: 32,
              bottom: 12,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: selectedImageFile != null
                          ? Image.file(
                              selectedImageFile!,
                            )
                          : Image.asset(
                              'assets/img_not_exist.png',
                            ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _localizedStrings[_selectedLanguage]!['guide_title']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _localizedStrings[_selectedLanguage]!['guide_text']!,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _imgFromCamera(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(int.parse("0xFFFF8C00"))),
                          child: Center(
                            child: Text(
                              _localizedStrings[_selectedLanguage]!['take_picture']!,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _imgFromGallery(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(int.parse("0xFFFF8C00"))),
                          child: Center(
                            child: Image.asset(
                              'assets/ic_galery.png',
                              width: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: selectedImageFile != null
                        ? () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HasilAnalisaScreen(
                                selectedImageFile: selectedImageFile,
                              );
                            }));
                          }
                        : null,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: selectedImageFile != null
                            ? Color(int.parse("0xFFFF8C00"))
                            : Colors
                                .grey, // Warna abu jika selectedImageFile null
                      ),
                      child: Center(
                        child: Text(
                          _localizedStrings[_selectedLanguage]!['check_quality']!,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
