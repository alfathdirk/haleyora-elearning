import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/pages/auth/model.dart';
import 'package:haleyora/services/auth_service.dart';
import 'package:haleyora/services/dio_client.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthService authService = Get.find<AuthService>();
  final box = GetStorage();

  @override
  void dispose() {
    _usernameController.clear();
    _passwordController.clear();
    super.dispose();
  }

  bool isEmailCorrect = false;
  bool rememberMe = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    // if (_formKey.currentState!.validate()) {
    final response = await dio.post('/api/login', data: {
      'username': '7921203BDG',
      'password': '07071979',
      // 'username': _usernameController.text,
      // 'password': _passwordController.text,
    });
    LoginResponse loginResponse = LoginResponse.fromJson(response.data);
    box.write('accessToken', loginResponse.accessToken);
    box.write('refreshToken', loginResponse.refreshToken);
    await authService.setisLoggedIn(true);
    Get.offNamed('/home');
    return;
    // }
    // Get.snackbar('Error', 'Invalid username or password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        backgroundColor: backgroundWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 30,
                width: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'P L N',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  Text(
                    'Haleyora Power',
                    style: GoogleFonts.poppins(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo-elearning.png',
                      height: 180,
                      width: MediaQuery.of(context).size.width - 100,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: TextFieldWithBoxShadow(
                            placeholder: 'Username',
                            controller: _usernameController,
                            icon: const Icon(
                              Icons.email_outlined,
                              color: greyText,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter a valid username';
                              }
                              return null;
                            },
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: Column(
                          children: [
                            Form(
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
                          ],
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
                          ]),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 50,
                  child: RoundedButton(
                    text: "Login",
                    onPressed: () async {
                      await _login();
                      // Get.offNamed('/home');
                      // await PDF.generate();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
