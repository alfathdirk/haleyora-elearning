import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/widget/card.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  Future<void> initState() async {
    // fetch data from api
  }

  Scaffold buildScalffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bidang ${Get.parameters['name']}"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: CustomCard(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListBody(
                children: [
                  ListTile(
                    title: const Text("Yantek"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    subtitle: Text("(Pelayanan Teknologi)",
                        style: GoogleFonts.mulish(
                            fontSize: 12, color: Colors.grey)),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text("P2TL"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    subtitle: Text("(Penertiban Pemakaian Tenaga Listrik)",
                        style: GoogleFonts.mulish(
                            fontSize: 12, color: Colors.grey)),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text("Operasi Kabel"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initState(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return buildScalffold(context);
      },
    );
  }
}
