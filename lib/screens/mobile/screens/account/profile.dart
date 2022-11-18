import 'package:flutter/material.dart';
import 'package:mynt_pro/constant/model/const_var.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant/constants.dart';
import '../../../../functions/logout_func.dart';

class AccProfile extends StatefulWidget {
  const AccProfile({super.key});

  @override
  State<AccProfile> createState() => _AccProfileState();
}

class _AccProfileState extends State<AccProfile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView(
      children: [
        sizedHeight(size),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "PREM KUMAR J",
                  style: listTitle2(size),
                ),
                Text(
                  "ZP00194",
                  style: listSubTitle(size),
                )
              ],
            ),
          ),
        ),
        sizedHeight(size),
        Container(
          padding: const EdgeInsets.only(bottom: 20),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: Color.fromARGB(255, 243, 242, 248),
              ),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "E-mail",
                    style: profileTextStyle(size),
                  ),
                  Text(
                    "PREM.JEYAVEL@GMAIL.COM",
                    style: profileTextStyle(size),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phone",
                    style: profileTextStyle(size),
                  ),
                  Text(
                    "9962573900",
                    style: profileTextStyle(size),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PAN",
                    style: profileTextStyle(size),
                  ),
                  Text(
                    "***********998R",
                    style: profileTextStyle(size),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Demat (BO)",
                    style: profileTextStyle(size),
                  ),
                  Text(
                    "*********5743",
                    style: profileTextStyle(size),
                  )
                ],
              )
            ],
          ),
        ),
        sizedHeight(size),
        Container(
          padding: const EdgeInsets.only(bottom: 20),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: Color.fromARGB(255, 243, 242, 248),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bank Accounts",
                style: listTitle(size),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "HDFC Bank",
                    style: profileTextStyle(size),
                  ),
                  Text(
                    "***********3847",
                    style: profileTextStyle(size),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Segments",
                    style: profileTextStyle(size),
                  ),
                  Text(
                    "NSE, MCX",
                    style: profileTextStyle(size),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Products",
                    style: profileTextStyle(size),
                  ),
                  Text(
                    "RML, MIS, CNO, CO",
                    style: profileTextStyle(size),
                  )
                ],
              ),
            ],
          ),
        ),
        sizedHeight(size),
        Card(
          child: ListTile(
            title: Text(
              "Change M-PIN",
              style: listTitle(size),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, "changeMPin");
            },
          ),
        ),
        sizedHeight(size),
        Card(
          child: ListTile(
            title: Text(
              "Change Password",
              style: listTitle(size),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, "changePassword");
            },
          ),
        ),
        sizedHeight(size),
        Card(
          child: ListTile(
            title: Text(
              "Change 2FA",
              style: listTitle(size),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        ),
        sizedHeight(size),
        Card(
          child: ListTile(
            title: Text(
              "Logout",
              style: listTitle(size),
            ),
            trailing: const Icon(Icons.logout),
            onTap: () {
              logout(context: context);
            },
          ),
        ),
        sizedHeight(size),
        SwitchListTile(
          title: Text(
            'Biometric',
            style: listTitle(size),
          ),
          value: ConstVariable.authStatus,
          onChanged: (bool value) async {
            setState(() {
              ConstVariable.authStatus = value;
            });
            try {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('bioAuth', ConstVariable.authStatus);
            } catch (e) {}
          },
          secondary: const Icon(Icons.fingerprint),
        )
      ],
    );
  }
}
