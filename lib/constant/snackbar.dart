import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySnackBars {
  /// failure
  failureSnackBar(String text) {
    return SnackBar(
      duration: const Duration(milliseconds: 800),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'On Snap!',
        message: text,
        contentType: ContentType.failure,
      ),
    );
  }

  /// help
  helpSnackBar(String text) {
    return SnackBar(
      duration: const Duration(milliseconds: 800),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Hi There!',
        message: text,
        contentType: ContentType.help,
      ),
    );
  }

  /// success
  successSnackBar(String text) {
    return SnackBar(
      duration: const Duration(milliseconds: 800),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Congratulation!',
        message: text,
        contentType: ContentType.success,
      ),
    );
  }

  /// warning
  warningSnackBar(String text) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 800),
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Warning!',
        message: text,
        contentType: ContentType.warning,
      ),
    );
  }

  successBar(String text) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      // backgroundColor: Color(0xffB5C0CF).withOpacity(.15),
      content: Text(
        text,
        style: GoogleFonts.inter(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xff20DC49),
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  unSuccessBar(String text) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      // backgroundColor: Color(0xffB5C0CF).withOpacity(.15),
      content: Text(
        text,
        style: GoogleFonts.inter(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xffe20613),
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
