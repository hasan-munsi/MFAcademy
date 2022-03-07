import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/http/custom_http_requests.dart';
import 'package:mf_academy/model/user.dart';
import 'package:mf_academy/views/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoaderView extends StatefulWidget {
  static const String id = "/LoaderView";
  const LoaderView({Key? key}) : super(key: key);

  @override
  State<LoaderView> createState() => _LoaderViewState();
}

class _LoaderViewState extends State<LoaderView> {
  @override
  void initState() {
    loadPreRequisites();
    super.initState();
  }

  void loadPreRequisites() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    String _token = _sharedPrefs.getString("token") ?? "";

    if (_token.isEmpty) {
      Xarvis.loggedInUser = null;
    } else {
      try {
        final _response = await CustomHTTPRequests.me();
        final User _user = User.fromJson(_response);
        Xarvis.loggedInUser = _user;
      } catch (e) {
        Xarvis.logger.i(e);
        _sharedPrefs.clear();
        Xarvis.loggedInUser = null;
      }
    }
    Get.toNamed(HomePage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/logo.png',
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
