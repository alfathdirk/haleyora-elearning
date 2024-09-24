import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/card.dart';

class ListSector extends StatelessWidget {
  const ListSector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Bidang Distribusi',
              style:
                  GoogleFonts.jost(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: CustomCard(
                  // label with icon and arrow right icon
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListBody(
                      children: [
                        ListTile(
                          title: Text('Yantek',
                              style: GoogleFonts.mulish(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          subtitle: Text('(Pelatihan Teknis)',
                              style: GoogleFonts.mulish(
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal,
                                  color: greyText)),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        // ListTile(
                        //   title: Text('Keamanan',
                        //       style: GoogleFonts.mulish(
                        //           fontSize: 14, fontWeight: FontWeight.bold)),
                        //   trailing: const Icon(Icons.chevron_right),
                        // ),
                        ListTile(
                          title: Text('Syarat dan Ketentuan',
                              style: GoogleFonts.mulish(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        ListTile(
                          title: Text('Keluar',
                              style: GoogleFonts.mulish(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}
