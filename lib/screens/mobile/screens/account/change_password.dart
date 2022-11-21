import 'package:flutter/material.dart';

import '../../../../constant/constants.dart';
import '../../../../constant/snackbar.dart';
import '../../../../functions/cange_pass.dart';
import '../../../../shared_widgets/custom_widget_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});
  static const String routeName = 'changePassword';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ChangePassword(),
    );
  }

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final userId = TextEditingController();
  final oldPass = TextEditingController();
  final newPass = TextEditingController();
  final MySnackBars sb = MySnackBars();
  @override
  void dispose() {
    userId.dispose();
    oldPass.dispose();
    newPass.dispose();
    super.dispose();
  }

  bool passHidden = true;
  bool panHidden = true;
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
                                Text("Change Password", style: logInText(size)),
                          ),
                          sizedHeight(size * .2),
                          buildText("User Id", size),
                          TextFormField(
                            // inputFormatters: [UpperCaseTextFormatter()],
                            textCapitalization: TextCapitalization.characters,
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
                          buildText("Old Password", size),
                          TextFormField(
                            style: listTitle(size),
                            controller: oldPass,
                            keyboardType: TextInputType.text,
                            obscureText: passHidden,
                            onChanged: (onChanged) {},
                            validator: (passValue) {
                              if (passValue!.isEmpty) {
                                return "Please enter your Old password !";
                              } else if (passValue.length < 4 ||
                                  passValue.length > 10) {
                                return "Password length is min 4 and max 10 !";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passHidden
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    passHidden = !passHidden;
                                  });
                                },
                              ),
                              hintText: "OLD PASSWORD",
                              hintStyle: listTitle(size),
                            ),
                          ),
                          sizedHeight(size * .2),
                          buildText("New Password", size),
                          TextFormField(
                            style: listTitle(size),
                            controller: newPass,
                            keyboardType: TextInputType.text,
                            obscureText: passHidden,
                            onChanged: (onChanged) {},
                            validator: (passValue) {
                              if (passValue!.isEmpty) {
                                return "Please enter your New password !";
                              } else if (passValue.length < 7 ||
                                  passValue.length > 12) {
                                return "Password length is min 7 and max 12 !";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passHidden
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    passHidden = !passHidden;
                                  });
                                },
                              ),
                              hintText: "NEW PASSWORD",
                              hintStyle: listTitle(size),
                            ),
                          ),
                          sizedHeight(size * .8),
                          Center(
                            child: CustomWidgetButton(
                              onPress: () {
                                if (formkey.currentState!.validate()) {
                                  changePass(
                                    context: context,
                                    oldPass: oldPass.text,
                                    newPass: newPass.text,
                                  );
                                }
                              },
                              widget: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(22))),
                                alignment: Alignment.center,
                                height: 48,
                                width: 300,
                                child: Text("Update Password",
                                    style: listTitle(size)),
                              ),
                            ),
                          ),
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
