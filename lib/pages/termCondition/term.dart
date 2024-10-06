import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Please read these terms and conditions carefully before using Our Service.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Interpretation and Definitions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Interpretation',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Definitions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'For the purposes of these Terms and Conditions:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                'Affiliate means an entity that controls, is controlled by or is under common control with a party, where "control" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Country refers to: Indonesia',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                'Company (referred to as either "the Company", "We", "Us" or "Our" in this Agreement) refers to PT. XYZ.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ]),
      ),
    );
  }
}
