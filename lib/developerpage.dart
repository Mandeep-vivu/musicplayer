import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ionicons/ionicons.dart';

class DeveloperPage extends StatefulWidget {
  const DeveloperPage({Key? key}) : super(key: key);

  @override
  State<DeveloperPage> createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: ' '));
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Page'),
        flexibleSpace: Container(
         decoration: BoxDecoration(color: Colors.grey[900]),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 120,
        //    backgroundImage: AssetImage('assets/hl.png'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Mandeep (Vivan)',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            color: Colors.white
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Flutter Developer',
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
                color: Colors.white
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  String phoneNumber = "8708893657";
                  setState(() {
                    _makePhoneCall(phoneNumber);
                  });
                },
                icon: const Icon(Ionicons.call, color: CupertinoColors.secondarySystemGroupedBackground,),
                iconSize: 40,
              ),
              IconButton(
                onPressed: () {
                  Uri toLaunch = Uri(
                    scheme: 'mailto',
                    path: 'mandeepses132@gmail.com',
                  );
                  _launchInBrowser(toLaunch);
                },
                icon: const Icon(Ionicons.mail, color: CupertinoColors.secondarySystemGroupedBackground,),
                iconSize: 40,
              ),
              IconButton(
                onPressed: () {
                  final Uri toLaunch = Uri(
                      scheme: 'https',
                      host: 'github.com',
                      path: 'Mandeep-vivu');
                  _launchInBrowser(toLaunch);
                },
                icon: const Icon(Ionicons.logo_github, color: CupertinoColors.secondarySystemGroupedBackground,),
                iconSize: 40,
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
