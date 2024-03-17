import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/widget/card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile',
              style:
                  GoogleFonts.jost(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    'https://picsum.photos/300/300',
                    fit: BoxFit.cover,
                    width: 180,
                    height: 180,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "John Doe",
                  style: GoogleFonts.mulish(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  "John@mail.com",
                  style: GoogleFonts.mulish(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CustomCard(
                    // label with icon and arrow right icon
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListBody(
                        children: [
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text('Edit Akun',
                                style: GoogleFonts.mulish(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          ListTile(
                            leading: Icon(Icons.shield_moon_outlined),
                            title: Text('Keamanan',
                                style: GoogleFonts.mulish(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          ListTile(
                            leading: Icon(Icons.shield_outlined),
                            title: Text('Syarat dan Ketentuan',
                                style: GoogleFonts.mulish(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          ListTile(
                            leading: Icon(Icons.power_settings_new_outlined),
                            title: Text('Keluar',
                                style: GoogleFonts.mulish(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            trailing: Icon(Icons.chevron_right),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}