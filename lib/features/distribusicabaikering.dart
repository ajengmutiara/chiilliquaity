import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DistribusiCabaiKeringScreen extends StatelessWidget {
  const DistribusiCabaiKeringScreen({super.key});

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
        title: const Text("Distribusi Cabai Kering"),
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
                    "Produsen Cabai Kering",
                    Uri.parse("https://wa.me/6289612821257"),
                    Uri.parse("mailto:pertanian@semarangkota.go.id"),
                    Uri.parse("tel:081325373232"),
                    Uri.parse("https://maps.app.goo.gl/JwJ5XKGJ6NPVdeg47"), // Replace with actual Google Maps URL
                    "assets/produsen.png",
                  ),
                  _buildContactItem(
                    context,
                    "PT. Putra Nasa Mandiri",
                    Uri.parse("https://wa.me/6281358769824"),
                    Uri.parse("mailto:pt.putranasamandiri@gmail.com"),
                    Uri.parse("tel:(031)60018570"),
                    Uri.parse("https://maps.app.goo.gl/TTHEPfecK1vDcJGD8"), // Replace with actual Google Maps URL
                    "assets/logo.png",
                  ),
                  _buildContactItem(
                    context,
                    "Agro Jowo",
                    Uri.parse("https://wa.me/62817458182"),
                    Uri.parse("mailto: distanbun@jatengprov.go.id"),
                    Uri.parse("tel:(024)921010"),
                    Uri.parse("https://maps.app.goo.gl/EcMAfSX1TKPcgude8"), // Replace with actual Google Maps URL
                    "assets/agrojowo.png",
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
