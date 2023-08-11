import 'package:flutter/material.dart';
import '../widgets/menu_tile.dart';
import 'package:url_launcher/url_launcher.dart';




class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  bool _isDrawerExpanded = false;

  void _toggleDrawerExpansion() {
    setState(() {
      _isDrawerExpanded = !_isDrawerExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Netflix", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/user.png', width: 80),
              const SizedBox(height: 20),
              InkWell(
                onTap: _toggleDrawerExpansion,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.white.withOpacity(0.5),
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Manage Profiles',
                        style: TextStyle(color: Colors.white.withOpacity(0.5)),
                      ),
                      Icon(
                        _isDrawerExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_isDrawerExpanded) ...[
                MenuTile(title: 'My List', icon: const Icon(Icons.arrow_forward_ios_sharp), onTap: () {}),
                MenuTile(
                  title: 'Link to me',
                  icon: const Icon(Icons.arrow_forward_ios_sharp),
                  onTap: () async {
                    await launchUrl(
                      Uri.parse('https://www.facebook.com/thailai2k1'),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
                MenuTile(
                  title: 'Report Bug',
                  icon: const Icon(Icons.arrow_forward_ios_sharp),
                  onTap: () async {
                    await launchUrl(
                      Uri.parse('https://www.facebook.com/thailai2k1'),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
                MenuTile(
                  title: 'Check for Update',
                  icon: const Icon(Icons.arrow_forward_ios_sharp),
                  onTap: () async {
                    await launchUrl(
                      Uri.parse('https://pub.dev/packages/url_launcher/versions'),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
              ],
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Version: 0.0.1(nhom6) 1.4.0-002',
                  style: TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
              ],
            ),
          )
        ],
      ),

    );
  }
}
