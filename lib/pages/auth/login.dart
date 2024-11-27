import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/model/auth.dart';
import 'package:haleyora/services/auth_service.dart';
import 'package:haleyora/services/dio_client.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/text_input.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  void dispose() {
    _usernameController.clear();
    _passwordController.clear();
    super.dispose();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  bool isEmailCorrect = false;
  bool rememberMe = false;
  bool isLoading = false;
  bool isDisabled = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        isDisabled = true;
      });
      try {
        final response = await dio.post('/api/login', data: {
          'username': _usernameController.text,
          'password': _passwordController.text,
        });
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        box.write('accessToken', loginResponse.accessToken);
        box.write('refreshToken', loginResponse.refreshToken);
        await authService.setisLoggedIn(true);
        Get.offNamed('/home');
        return;
      } catch (e) {
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Error',
            message: 'Username atau password salah!',
            icon: Icon(Icons.info_outline),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
          isDisabled = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 6),
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
                                padding:
                                    const EdgeInsets.only(left: 0, right: 0),
                                child: TextFieldWithBoxShadow(
                                  placeholder: 'User Name',
                                  controller: _usernameController,
                                  icon: const Icon(
                                    Icons.person_outline,
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
                                        if (value!.isEmpty &&
                                            value.length < 5) {
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
                            // Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       Row(
                            //         children: [
                            //           Checkbox(
                            //             value: rememberMe,
                            //             onChanged: (bool? value) {
                            //               setState(() {
                            //                 rememberMe = value!;
                            //               });
                            //             },
                            //           ),
                            //           Text(
                            //             'Ingatkan Saya',
                            //             style: GoogleFonts.poppins(
                            //                 fontSize: 12.sp,
                            //                 fontWeight: FontWeight.w600,
                            //                 color: greyText),
                            //           ),
                            //         ],
                            //       ),
                            //     ]),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: RoundedButton(
                          text: "Login",
                          isDisabled: isDisabled,
                          isLoading: isLoading,
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.white,
              child: Center(
                child: Text(
                  'Version ${_packageInfo.version}+${_packageInfo.buildNumber}',
                  style: TextStyle(
                    color: greyText,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
