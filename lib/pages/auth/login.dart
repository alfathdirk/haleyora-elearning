import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/text_input.dart';
import '../../router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.clear();
    super.dispose();
  }

  bool isEmailCorrect = false;
  bool rememberMe = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhite,
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/logo.png',
                        height: 80,
                        width: 80,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PLN',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: darkText),
                          ),
                          Text(
                            'Haleyora Power',
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: darkText),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    // _formKey!.currentState!.validate() ? 200 : 600,
                    // height: isEmailCorrect ? 260 : 182,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 38),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Text(
                              'Masuk ke dalam Akun anda untuk melanjutkan Kursus',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: darkText),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 0, right: 0),
                            child: TextFieldWithBoxShadow(
                              placeholder: 'Email',
                              controller: _emailController,
                              icon: const Icon(
                                Icons.email_outlined,
                                color: greyText,
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Form(
                            child: TextFieldWithBoxShadow(
                              isPassword: true,
                              placeholder: 'Password',
                              controller: _passwordController,
                              icon: const Icon(
                                Icons.lock_outline,
                                color: greyText,
                              ),
                              validator: (value) {
                                if (value!.isEmpty && value.length < 5) {
                                  return 'Enter a valid password';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: rememberMe,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        rememberMe = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Ingatkan Saya',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: greyText),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Lupa sandi?',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: greyText),
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0)),
                          backgroundColor: primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 2.4,
                              vertical: 28)
                          // padding: EdgeInsets.only(
                          //     left: 120, right: 120, top: 20, bottom: 20),
                          ),
                      onPressed: () {
                        Get.toNamed(Routes.homePage);
                        // if (_formKey.currentState!.validate()) {
                        //   print('Email: ${_emailController.text}');
                        // }
                      },
                      child: Text(
                        'Masuk',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )), //
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
