import 'package:flutter/material.dart';

import 'custom_long_button.dart';

const addedSuccessSnackBar = SnackBar(
  content: Text(
    'Market Watch Scrip added successfully.',
  ),
  duration: Duration(seconds: 1),
  backgroundColor: Colors.greenAccent,
);
const addfailSnackBar = SnackBar(
  content: Text(
    'Failed to add Scrip. Please retry.',
  ),
  duration: Duration(seconds: 1),
  backgroundColor: Colors.red,
);
const deleteSuccessSnackBar = SnackBar(
  content: Text(
    'Scrip from Market Watch is deleted successfully.',
  ),
  duration: Duration(seconds: 1),
  backgroundColor: Colors.green,
);
const deletefailSnackBar = SnackBar(
  content: Text(
    'Delete is not successful. Please refresh scrip & retry.',
  ),
  duration: Duration(seconds: 1),
  backgroundColor: Colors.red,
);

const mPinErrorSnackBar = SnackBar(
  content: Text(
    'Wrong mPIN. Please retry.',
  ),
  duration: Duration(seconds: 1),
  backgroundColor: Colors.red,
);

const faErrorSnackBar = SnackBar(
  content: Text(
    'Wrong 2FA Answers. Please retry.',
  ),
  duration: Duration(seconds: 1),
  backgroundColor: Colors.red,
);

SnackBar errorSnackBar(String error) => SnackBar(
      content: Text(error),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.red,
    );

SnackBar successSnackBar(String success) => SnackBar(
      content: Text(success),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.red,
    );

AlertDialog alertDialog(BuildContext context) => AlertDialog(
      title: const Text('Alert'),
      actions: [
        CustomLongButton(
            color: Colors.blue,
            label: "OK",
            onPress: () {
              Navigator.pop(context);
            })
      ],
    );
