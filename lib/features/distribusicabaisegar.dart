import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DistribusiCabaiSegarScreen extends StatelessWidget {
  const DistribusiCabaiSegarScreen({super.key});

  Color get primaryColor => const Color(0xffFFBB38);

  Future<void> openUrl(Uri uri) async {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Distribusi Cabai Segar"),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/splash.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildContactItem(
                    context,
                    "Dinas Pertanian Pemerintah Kota Semarang",
                    Uri.parse("https://wa.me/6281325373232"),
                    Uri.parse("mailto:pertanian@semarangkota.go.id"),
                    Uri.parse("tel:081325373232"),
                    Uri.parse("https://maps.app.goo.gl/3J5uyHbbkP44Kmr29"), // Replace with actual Google Maps URL
                    "assets/dinas.jpg",
                  ),
                  _buildContactItem(
                    context,
                    "PT. Jateng Agro Berdikari",
                    Uri.parse("https://wa.me/6288226527415"),
                    Uri.parse("mailto:jtab.perseroda@gmail.com"),
                    Uri.parse("tel:(024) 8417042"),
                    Uri.parse("https://maps.app.goo.gl/sgAYv5F8j1jDG2oA6"), // Replace with actual Google Maps URL
                    "assets/jtab.png",
                  ),
                  _buildContactItem(
                    context,
                    "Pasar Boja",
                    Uri.parse("https://wa.me/6281325217245"),
                    Uri.parse("mailto:bpr_pasarboja@yahoo.co.id"),
                    Uri.parse("tel:081325217245"),
                    Uri.parse("https://maps.app.goo.gl/6ixmwYAcYioffmaB9"), // Replace with actual Google Maps URL
                    "assets/images.jpg",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    String title,
    Uri whatsappUrl,
    Uri emailUrl,
    Uri phoneUrl,
    Uri mapsUrl,
    String imagePath,
  ) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.message),
                  title: const Text('WhatsApp'),
                  onTap: () => openUrl(whatsappUrl),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  onTap: () => openUrl(emailUrl),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Telephone'),
                  onTap: () => openUrl(phoneUrl),
                ),
                ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text('Google Maps'),
                  onTap: () => openUrl(mapsUrl),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(imagePath, width: 50, height: 50),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
