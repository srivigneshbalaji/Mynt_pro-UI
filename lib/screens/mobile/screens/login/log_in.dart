// ignore_for_file: avoid_print

import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_information/device_information.dart';
import 'package:mynt_pro/constant/model/device_info.dart';
import '../../../../constant/constants.dart';
import '../../../../constant/model/models.dart';
import '../../../../constant/snackbar.dart';
import '../../../../functions/quick_auth_func.dart';
import '../../../../shared_widgets/custom_text_button.dart';
import '../../../../shared_widgets/custom_widget_button.dart';
import '../../../../util/functions.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  static const String routeName = 'logIn';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const LogIn(),
    );
  }

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  void initState() {
    super.initState();

    requestPermission();
  }

  Future<void> initPlatformState() async {
    late String platformVersion,
        imeiNo = '',
        modelName = '',
        manufacturer = '',
        deviceName = '',
        productName = '',
        cpuType = '',
        hardware = '';
    try {
      platformVersion = await DeviceInformation.platformVersion;
      imeiNo = await DeviceInformation.deviceIMEINumber;
      modelName = await DeviceInformation.deviceModel;
      manufacturer = await DeviceInformation.deviceManufacturer;
      deviceName = await DeviceInformation.deviceName;
      productName = await DeviceInformation.productName;
      cpuType = await DeviceInformation.cpuName;
      hardware = await DeviceInformation.hardware;
    } on PlatformException catch (e) {
      platformVersion = '${e.message}';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      DeviceInfo.platformVersion = platformVersion;
      DeviceInfo.imeiNo = imeiNo;
      DeviceInfo.modelName = modelName;
      DeviceInfo.manufacturerName = manufacturer;
      DeviceInfo.deviceName = deviceName;
      DeviceInfo.productName = productName;
      DeviceInfo.cpuType = cpuType;
      DeviceInfo.hardware = hardware;
    });
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final userId = TextEditingController();
  final password = TextEditingController();
  final panNumber = TextEditingController();
  final MySnackBars sb = MySnackBars();
  @override
  void dispose() {
    userId.dispose();
    password.dispose();
    super.dispose();
  }

  bool passHidden = true;
  bool panHidden = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color createColor = Colors.black;
    Color dontAccColor = Colors.grey;
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
                            child: Text("Welcome", style: welcomeText(size)),
                          ),
                          Center(
                            child: Text("Login to your account",
                                style: logInText(size)),
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
                            onChanged: (onChanged) {
                              // final prefs =
                              //     await SharedPreferences.getInstance();
                              // onChanged = prefs.getString('userId')!;
                              // ConstVariable.userId = onChanged;
                            },
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
                          buildText("Password", size),
                          TextFormField(
                            style: listTitle(size),
                            controller: password,
                            keyboardType: TextInputType.text,
                            obscureText: passHidden,
                            onChanged: (onChanged) {},
                            validator: (passValue) {
                              if (passValue!.isEmpty) {
                                return "Please enter the Password !";
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
                              hintText: "PASSWORD",
                              hintStyle: listTitle(size),
                            ),
                          ),
                          sizedHeight(size * .2),
                          buildText("PAN Number", size),
                          TextFormField(
                            maxLength: 10,
                            textCapitalization: TextCapitalization.characters,
                            style: listTitle(size),
                            controller: panNumber,
                            keyboardType: TextInputType.text,
                            obscureText: panHidden,
                            onChanged: (onChanged) {
                              if (panNumber.text.length == 10) {
                                FocusScope.of(context).unfocus();
                              }
                            },
                            validator: (panValue) {
                              if (panValue!.isEmpty) {
                                return "Please enter your PAN number !";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  panHidden
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    panHidden = !panHidden;
                                  });
                                },
                              ),
                              counterStyle: TextStyle(color: Colors.black),
                              hintText: "PAN NUMBER",
                              hintStyle: listTitle(size),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomTextButton(
                              text: 'Forgot Password?',
                              onPress: () {
                                Navigator.pushNamed(context, 'forgotPass');
                              },
                            ),
                          ),
                          sizedHeight(size * .8),
                          Center(
                            child: CustomWidgetButton(
                              onPress: () {
                                if (formkey.currentState!.validate()) {
                                  QuickAuth.quickAuth(
                                      context: context,
                                      uId: userId.text,
                                      pass: password.text,
                                      pan: panNumber.text);
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
                                child: Text("Login", style: listTitle(size)),
                              ),
                            ),
                          ),
                          sizedHeight(size * 1),
                          CustomWidgetButton(
                              onPress: () {
                                launchInBrowser("https://oa.zebull.in/");
                              },
                              widget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don’t have account? ",
                                      style: logText(size, dontAccColor)),
                                  Text("Create Now",
                                      style: logText(size, createColor))
                                ],
                              )),
                          // sizedHeight(size * 1),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     IconButton(
                          //         onPressed: () {},
                          //         icon: SvgPicture.asset("assets/chrome.svg",
                          //             height: 50, fit: BoxFit.contain)),
                          //     IconButton(
                          //         onPressed: () {},
                          //         icon: SvgPicture.asset("assets/fb.svg",
                          //             height: 50, fit: BoxFit.cover)),
                          //     IconButton(
                          //         onPressed: () {},
                          //         icon: const Icon(
                          //           Icons.apple,
                          //           size: 32,
                          //         )),
                          //   ],
                          // )
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

  void requestPermission() async {
    var status = await Permission.phone.status;
    if (status.isGranted) {
      print("Permission is granted");
      initPlatformState();
    } else if (status.isDenied) {
      if (await Permission.phone.request().isGranted) {
        print("Permission was granted");
        initPlatformState();
      }
    }
  }
}
