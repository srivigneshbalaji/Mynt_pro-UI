// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';

final NumberFormat numberFormat = NumberFormat("##,##,##,##,##0.00", "hi");

String getFormatter(
    {required double value, required bool v4d, required bool noDecimal}) {
  const String formatWith2 = "##,##,##,##,##0.00";
  const String formatWith4 = "##,##,##,##,##0.0000";
  const String formatWith0 = "##,##,##,###";
  return NumberFormat(noDecimal
          ? formatWith0
          : v4d
              ? formatWith4
              : formatWith2)
      .format(value);
}

String getRandomAlphaNumbericString(int length) {
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random rnd = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}

bool isNumberNegative(String num) {
  return num.startsWith('-');
}

String getFormatedNumValue(
  String number, {
  bool showSign = true,
  required int afterPoint,
}) {
  // print(num);
  final String num = (number == "inf" || number == 'null') ? "0.00" : number;
  final bool isNeg = num.startsWith('-');
  final double val = double.parse(isNeg
      ? num.toString().replaceAll(',', '').substring(1)
      : num.toString().replaceAll(',', ''));

  if (val == 0) {
    return afterPoint == 0 ? "00" : "00.00";
  } else {
    return isNeg
        ? "-${val.toStringAsFixed(afterPoint)}"
        : showSign
            ? "+${val.toStringAsFixed(afterPoint)}"
            : val.toStringAsFixed(afterPoint);
  }
}

// Future<bool> isUserLoggedIn(LoginStatus status) async {
//   if (status.stat && status.available && status.login) {
//     return true;
//   } else if (!status.stat && status.available && !status.login) {
//     return false;
//   } else {
//     return false;
//   }
// }

String encryptAESCryptoJS(String plainText, String passphrase) {
  try {
    final salt = genRandomWithNonZero(8);
    final keyndIV = deriveKeyAndIV(passphrase, salt);
    final key = encrypt.Key(keyndIV.item1);
    final iv = encrypt.IV(keyndIV.item2);

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final Uint8List encryptedBytesWithSalt = Uint8List.fromList(
        createUint8ListFromString("Salted__") + salt + encrypted.bytes);
    return base64.encode(encryptedBytesWithSalt);
  } catch (error) {
    rethrow;
  }
}

String decryptAESCryptoJS(String encrypted, String passphrase) {
  try {
    final Uint8List encryptedBytesWithSalt = base64.decode(encrypted);
    final Uint8List encryptedBytes =
        encryptedBytesWithSalt.sublist(16, encryptedBytesWithSalt.length);
    final salt = encryptedBytesWithSalt.sublist(8, 16);
    final keyndIV = deriveKeyAndIV(passphrase, salt);
    final key = encrypt.Key(keyndIV.item1);
    final iv = encrypt.IV(keyndIV.item2);

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final decrypted =
        encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);
    return decrypted;
  } catch (error) {
    rethrow;
  }
}

Uint8List genRandomWithNonZero(int seedLength) {
  final random = Random.secure();
  const int randomMax = 245;
  final Uint8List uint8list = Uint8List(seedLength);
  for (int i = 0; i < seedLength; i++) {
    uint8list[i] = random.nextInt(randomMax) + 1;
  }
  return uint8list;
}

Tuple2<Uint8List, Uint8List> deriveKeyAndIV(String passphrase, Uint8List salt) {
  final password = createUint8ListFromString(passphrase);
  Uint8List concatenatedHashes = Uint8List(0);
  Uint8List currentHash = Uint8List(0);
  bool enoughBytesForKey = false;
  Uint8List preHash = Uint8List(0);

  while (!enoughBytesForKey) {
    // int preHashLength = currentHash.length + password.length + salt.length;
    if (currentHash.isNotEmpty) {
      preHash = Uint8List.fromList(currentHash + password + salt);
    } else {
      preHash = Uint8List.fromList(password + salt);
    }

    currentHash = md5.convert(preHash).bytes as Uint8List;
    concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
    if (concatenatedHashes.length >= 48) enoughBytesForKey = true;
  }

  final keyBtyes = concatenatedHashes.sublist(0, 32);
  final ivBtyes = concatenatedHashes.sublist(32, 48);
  return Tuple2(keyBtyes, ivBtyes);
}

Uint8List createUint8ListFromString(String s) {
  final ret = Uint8List(s.length);
  for (var i = 0; i < s.length; i++) {
    ret[i] = s.codeUnitAt(i);
  }
  return ret;
}

String formatCurrencyStandard({required String value}) {
  String formatedCurrency = '';
  // final bool isNeg = value.startsWith('-');
  if (value.isNotEmpty) {
    if (value.indexOf(",") > 0) {
      // ignore: parameter_assignments
      value = value.replaceAll(',', '');
    }
    final double formatValue = double.parse(value);
    formatedCurrency = numberFormat.format(formatValue);
    // if(isNeg){
    //   formatedCurrency = '-$formatedCurrency';
    // }
  }
  return formatedCurrency;
}

Future<void> launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    throw 'Could not launch $url';
  }
}
