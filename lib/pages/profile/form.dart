import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/dropdown.dart';
import 'package:haleyora/widget/text_input.dart';

class EditProfileForm extends StatefulWidget {
  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nickNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  final List<Map<String, dynamic>> options = [
    {'key': 'M', 'label': 'Male'},
    {'key': 'F', 'label': 'Female'}
  ];

  @override
  void initState() {
    super.initState();
    // _nickNameController.text = 'John Doe';
    // _lastNameController.text = 'John';
    // _emailController.text = '';
    // _phoneController.text = '081234567890';
    // _dobController.text = '01/01/1990';
    // _genderController.text = 'F';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 115,
                        width: 115,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            const CircleAvatar(
                              backgroundImage:
                                  NetworkImage("https://picsum.photos/200/300"),
                            ),
                            Positioned(
                                bottom: 0,
                                right: -25,
                                child: RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 2.0,
                                  fillColor: Color(0xFFF5F6F9),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  padding: EdgeInsets.all(2.0),
                                  shape: CircleBorder(),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFieldWithBoxShadow(
                        controller: _nickNameController,
                        labelText: 'Nama lengkap',
                        placeholder: 'John Doe',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithBoxShadow(
                        controller: _lastNameController,
                        labelText: 'Nama Panggilan',
                        placeholder: '',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithBoxShadow(
                        controller: _emailController,
                        labelText: 'Email',
                        placeholder: 'john@doe.com',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithBoxShadow(
                        controller: _phoneController,
                        labelText: 'Phone',
                        placeholder: '081234567890',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithBoxShadow(
                        controller: _dobController,
                        labelText: 'Tanggal Lahir',
                        placeholder: '01/01/1990',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownWidget(
                        value: _genderController.text,
                        placeholder: 'Jenis kelamin',
                        onChanged: (value) {
                          _genderController.text = value;
                        },
                        options: options,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: RoundedButton(
                  text: 'Simpan',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // save to database
                      Navigator.pop(context);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
