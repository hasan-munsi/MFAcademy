import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:mf_academy/http/custom_http_requests.dart';
import 'package:mf_academy/model/user.dart';
import 'package:mf_academy/views/loader/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Xarvis {
  static const kURL = "http://mfa.devbose.xyz";
  static const kApiURL = "$kURL/api";

  static const Color dark = Color(0xFF000000);
  static const Color fair = Color(0xFFFFFFFF);
  static const Color appBgColor = Color(0xFF700610);
  static const Color appBgColorLight = Color(0xFFff0017);

  static User? loggedInUser;

  static final logger = Logger();

  static void showToaster({required String message, bool danger = false}) {
    Fluttertoast.showToast(msg: message, backgroundColor: danger ? appBgColor : dark);
  }

  static SizedBox customHeight(double height) {
    return SizedBox(
      height: height,
    );
  }

  static SizedBox customWidth(double width) {
    return SizedBox(
      width: width,
    );
  }

  static Text genericText({
    required String text,
    Color textColor = dark,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    double? height,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) {
    return Text(
      text,
      style: GoogleFonts.nunito(
        textStyle: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
        ),
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  static TextFormField getTextField({
    required TextEditingController controller,
    String? hint,
    bool obscureText = false,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        suffix: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  static Widget getGlobalButton({
    required Function() action,
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    double? width,
    double? height,
  }) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            appBgColorLight,
            appBgColor,
          ]
        ),
      ),
      child: ElevatedButton(
        onPressed: action,
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
            padding: MaterialStateProperty.all(padding),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)))),

        child: child,
      ),
    );
  }

  static logoutKicker() async {
    final _response = await CustomHTTPRequests.logout();
    if (_response == true) {
      SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
      Xarvis.loggedInUser = null;
      _sharedPrefs.clear();
      Get.offAllNamed(LoaderView.id);
    }
  }
}
