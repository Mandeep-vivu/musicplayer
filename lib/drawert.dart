import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/developerpage.dart';


class Drawert extends StatelessWidget {
  const Drawert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900]
        ),
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey[600]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Music Player',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'by vivu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.home_outlined,
                      color: CupertinoColors.secondarySystemGroupedBackground,
                    ),
                    title: const Text('Home',style: TextStyle(color: Colors.white), ),
                    onTap: () {
                      // do something when Home is selected

                    },
                  ),
                  const Divider(),

                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.code,
                      color: CupertinoColors.secondarySystemGroupedBackground,
                    ),
                    title: const Text('Developer',style: TextStyle(color: Colors.white), ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DeveloperPage()),
                      );
                    },
                  ),
                  const Divider(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
