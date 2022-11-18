import 'package:flutter/material.dart';

import '../../../../constant/text_style.dart';
import '../../../../shared_widgets/custom_text_form_field.dart';
import '../../../../shared_widgets/custom_widget_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  static const String routeName = 'forgotPass';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ForgotPassword(),
    );
  }

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final userId = TextEditingController();
  final emailId = TextEditingController();
  final panNum = TextEditingController();
  @override
  void dispose() {
    userId.dispose();
    emailId.dispose();
    panNum.dispose();
    super.dispose();
  }

  bool passHidden = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: formkey,
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child:
                                Text("Reset Password", style: logInText(size)),
                          ),
                          sizedHeight(size * .2),
                          buildText("User Id", size),
                          TextFormField(
                            inputFormatters: [UpperCaseTextFormatter()],
                            autofocus: true,
                            style: listTitle(size),
                            controller: userId,
                            keyboardType: TextInputType.text,
                            onChanged: (onChanged) {},
                            validator: (userValue) {
                              if (userValue!.isEmpty) {
                                return 'Please enter your User Id !';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              prefixIcon: const Icon(Icons.key),
                              hintText: "USER ID",
                              counterText: '',
                              hintStyle: listTitle(size),
                            ),
                          ),
                          sizedHeight(size * .2),
                          buildText("Email Id", size),
                          TextFormField(
                            style: listTitle(size),
                            controller: emailId,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: passHidden,
                            onChanged: (onChanged) {},
                            validator: (emailValue) {
                              if (emailValue!.isEmpty) {
                                return "Please enter your e-mail !";
                              } else if (!RegExp(
                                      r"[a-z0-1!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-0!#$%$'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-]*[a-z0-9])?")
                                  .hasMatch(emailValue)) {
                                return "Invalid Email Address";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              prefixIcon: const Icon(Icons.email),
                              hintText: "EMAIL ID",
                              hintStyle: listTitle(size),
                            ),
                          ),
                          sizedHeight(size * .2),
                          buildText("PAN No", size),
                          TextFormField(
                            inputFormatters: [UpperCaseTextFormatter()],
                            autofocus: true,
                            style: listTitle(size),
                            controller: panNum,
                            keyboardType: TextInputType.text,
                            onChanged: (onChanged) {},
                            validator: (panValue) {
                              if (panValue!.isEmpty) {
                                return 'Please enter your PAN number !';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              prefixIcon: const Icon(Icons.numbers),
                              hintText: "PAN NO",
                              counterText: '',
                              hintStyle: listTitle(size),
                            ),
                          ),
                          sizedHeight(size * 1.5),
                          Center(
                            child: CustomWidgetButton(
                              onPress: () {
                                if (formkey.currentState!.validate()) {
                                  Navigator.pushNamed(context, 'home');
                                }
                              },
                              widget: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                alignment: Alignment.center,
                                height: 48,
                                width: 300,
                                child: Text("Reset Password",
                                    style: listTitle(size)),
                              ),
                            ),
                          ),
                          sizedHeight(size * 1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildText(String text, Size size) => Container(
        margin: const EdgeInsets.fromLTRB(0, 24, 0, 8),
        child: Text(text, style: listTitle(size)),
      );
}
