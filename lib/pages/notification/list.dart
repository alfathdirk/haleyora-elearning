import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/card.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 20, // Replace with the actual number of notifications
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
            child: CustomCard(
              child: ListTile(
                title: Text('Notification $index',
                    style: GoogleFonts.mulish(fontWeight: FontWeight.bold)),
                subtitle: Text('This is notification $index',
                    style: GoogleFonts.mulish(fontSize: 12, color: greyText)),
                // trailing time
                trailing: Text('10:00', style: GoogleFonts.mulish(fontSize: 9)),
                onTap: () {
                  // Handle notification tap
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
