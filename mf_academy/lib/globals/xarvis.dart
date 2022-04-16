import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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

  static const kBMFAWarriorsAppId = "com.bmfacadets.warriors";
  static const kSafetyGPSProAppId = "com.safetygps.track";

  ///30 Mar, 2022 (Sun) to DateTime
  static DateTime getStringToDateTime1(String stringedDate){
    try{
      return DateFormat("dd MMM, yyyy (EEE)").parse(stringedDate);
    }catch(e){
      return DateTime.now();
    }
  }

  ///DateTime to 30 Mar, 2022
  static String getDateTimeToString1(DateTime dateTime){
    try{
      return DateFormat("dd MMM, yyyy (EEE)").format(dateTime);
    }catch(e){
      return "";
    }
  }

  ///DateTime to 2022-04-01
  static String getDateTimeToString2(DateTime dateTime){
    try{
      return DateFormat("yyyy-MM-dd").format(dateTime);
    }catch(e){
      return "";
    }
  }

  ///2020-03-30 to 30 Mar, 2022 (Sun)
  static String getStringToStringDate1(String stringedDate){
    try{
      DateTime dateTime = DateFormat("yyyy-MM-dd").parse(stringedDate);
      return DateFormat("dd MMM, yyyy (EEE)").format(dateTime);
    }catch(e){
      return "";
    }
  }

  ///2020-03-30 to 30 Mar, 2022
  static String getStringToStringTime1(String stringedDate){
    try{
      DateTime dateTime = DateFormat("HH:mm:ss").parse(stringedDate);
      return DateFormat("hh:mm:ss a").format(dateTime);
    }catch(e){
      return "";
    }
  }

  static const homeText = """1971 - As part of the Foreign Reconstruction of the Great War of Liberation of 1971, the then Bangladesh Government Attorney Councilors were hired to make the port of Chittagong suitable for the port of Chittagong before the removal of large and decommissioned / half-built ships and explosive mines. The experts observed the movement of huge fishery resources in the Bay of Bengal and expressed interest in extracting them.
  
Following this, in 1973, the Russian government provided 10 fishing trawlers (including officers, sailors and experts) to the then government of Bangladesh for extraction of fishery resources in the Bay of Bengal. The Marine Fisheries Academy was established in 1973 by the then government under the leadership of Bangabandhu Sheikh Mujibur Rahman, the father of the Sonejati, with the technical assistance of the Russian government, so that the trawlers could be operated by local trained manpower in the future.

At present, this academy is one of the recognized maritime educational institutions recognized by the Ministry of Shipping. Since 2016, the cadets of the Department of Nautical and Marine Engineering of the academy have been receiving the required Seaman Book / CDC (Continuous Discharge Certificate) from the Department of Shipping to avail job opportunities in the shipping vessels. Moreover, in 2016, the academy was affiliated to Bangabandhu Sheikh Mujibur Rahman Maritime University and the course curriculum has been developed for 4 years B.Sc Honors level. This has increased the acceptability of Academy Certificates and created diversified job opportunities for the passed cadets.

Vision.
Human resource development through conducting vocational training / education activities in the maritime sector.

Objectives.
To meet the demand of our people for animal meat, to enrich the economy of the country through earning foreign currency and socio-economic development.

Goals and Objectives.

1. Conducting pre-sea training and undergraduate training activities to build skilled manpower for deep sea fishing vessels / trawlers and naval commercial vessels, ship engine operations, shipbuilding and repair industries, fish processing and quality control industries and other related sectors.

2. Provide ancillary training to naval officers and sailors on basic maritime security and other essentials.

3. Conduct refresher courses for preparation of Certificate of Competency Examination for officers engaged in Ocean Fishing / Trawler Naval Commercial Ships.

Main functions.

1. Admission of 35 student cadets in Nautical Department, 35 students in Marine Engineering Department and 20 local student cadets in Marine Fisheries Department on batch basis in each academic year and admission of 10 foreign cadets in these 3 departments subject to admission.

2. According to the syllabus and academic calendar approved by the Department of Shipping, 2 (two) years Mayor's Pre-Sea Training Course and as per the syllabus approved by Bangabandhu Sheikh Mujibur Rahman Maritime University, 4 years term / BSc in Nautical Studies / BSc in Marine Engineering (B.Sc.) Conduct simultaneous education courses in Marine Fisheries.

3. Taking exams and publishing results in semester system etc.
""";

  static const visionText = "Human resource development through conducting vocational training/education activities in the mari-time sector";
  static const objectivesText = "To meet the demand of our people for animal meat, to enrich the economy of the country through earning foreign currency and socio-economic development";

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
    String? Function(String? val)? validator,
    int maxLine = 1,
    int maxLength = 200,
    TextInputType keyboardType = TextInputType.text,
    Function(String val)? onChange,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      maxLines: maxLine,
      maxLength: maxLength,
      keyboardType: keyboardType,
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hint,
        suffix: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        counter: const SizedBox(),
      ),
    );
  }

  static Widget getGlobalButton({
    required Function() action,
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    double? width,
    double? height,
    double borderRadius = 5,
  }) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
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
