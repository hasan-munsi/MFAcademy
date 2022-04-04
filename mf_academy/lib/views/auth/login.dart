import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/http/custom_http_requests.dart';
import 'package:mf_academy/views/loader/loader.dart';
import 'package:mf_academy/views/utils/social_buttons.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  static const String id = "/Login";

  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;

  final _emailC = TextEditingController();

  final _passC = TextEditingController();

  bool _isEyeOpen = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.6, 1],
                    colors: [
                      Color(0xFF82000C),
                      Color(0xFF94010f),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Xarvis.genericText(
                        text: "Welcome",
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        textColor: Xarvis.fair),
                    Image.asset(
                      "assets/images/logo.png",
                      width: 150,
                      height: 150,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Xarvis.customHeight(20),
                      Xarvis.getTextField(
                          controller: _emailC,
                          hint: 'Username or Phone Number'),
                      Xarvis.customHeight(20),
                      Xarvis.getTextField(
                        controller: _passC,
                        hint: 'Password',
                        obscureText: !_isEyeOpen,
                        suffix: InkWell(
                          onTap: switchEye,
                          child: Icon(
                            _isEyeOpen
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                            size: 20,
                          ),
                        ),
                      ),
                      Xarvis.customHeight(20),
                      Xarvis.getGlobalButton(
                        action: loginAction,
                        child: SizedBox(
                          width: 250,
                          height: 50,
                          child: Center(
                            child: Xarvis.genericText(
                                text: "LOG IN",
                                textColor: Xarvis.fair,
                                textAlign: TextAlign.center,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async{
                          await Get.dialog(
                            const ForgetPasswordForm(),
                          );
                        },
                        child: const Text(
                          "Forget Password?",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Xarvis.appBgColor),
                        ),
                      ),
                      Xarvis.customHeight(20),
                      const SocialButtons(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void switchEye() {
    setState(() {
      _isEyeOpen = !_isEyeOpen;
    });
  }

  loginAction() async {
    if (_emailC.text.trim().isEmpty) {
      Xarvis.showToaster(message: "Username or Email required");
    } else if (_passC.text.isEmpty) {
      Xarvis.showToaster(message: "Password is required");
    } else {
      setState(() {
        _isLoading = true;
      });

      try {
        Map<String, String> _allData = {
          "username": _emailC.text.trim(),
          "password": _passC.text,
        };

        final _response = await CustomHTTPRequests.login(_allData);

        Xarvis.logger.i(_response);

        final SharedPreferences _sharedPrefs =
            await SharedPreferences.getInstance();
        _sharedPrefs.setString(
            "token", "Bearer ${_response["data"]["access_token"]}");

        ///
        FirebaseMessaging fcm = FirebaseMessaging.instance;
        String? _fcmToken = await fcm.getToken();

        Map<String, String> _data = {"token": _fcmToken ?? ""};
        await CustomHTTPRequests.updateToken(_data);
      } catch (e) {
        Xarvis.logger.i(e);
      }

      setState(() {
        _isLoading = false;
      });

      Get.offAllNamed(LoaderView.id);
    }
  }
}

class LoginHelpingButtonsUI extends StatelessWidget {
  final String label;
  final String imageUrl;
  final Function() action;

  const LoginHelpingButtonsUI(
      {Key? key,
      required this.label,
      required this.imageUrl,
      required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Xarvis.getGlobalButton(
      action: action,
      height: 45,
      child: SizedBox(
        height: 35,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                imageUrl,
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
            ),
            Xarvis.customWidth(5),
            Expanded(
              child: Xarvis.genericText(
                  text: label.toUpperCase(),
                  textColor: Xarvis.fair,
                  textAlign: TextAlign.start,
                  fontSize: 14,
                  height: 1,
                  fontWeight: FontWeight.bold,
                  maxLines: 5),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final _phoneC = TextEditingController();
  final String _mainMsg = "I forgot my password. Therefore, I am requesting to reset my password. Here is my phone number - ";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width*0.8,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Xarvis.fair,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Xarvis.genericText(text: _mainMsg+_phoneC.text, maxLines: 50),
                Xarvis.customHeight(10),
                Xarvis.getTextField(
                  controller: _phoneC,
                  maxLine: 1,
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  onChange: (_){
                    setState(() {});
                  },
                  validator: (String? val){
                    return val?.trim().length!=11?"11 digit phone number required":null;
                  },
                ),
                Xarvis.customHeight(10),
                LoginHelpingButtonsUI(
                    label: "Send Password Reset Request",
                    imageUrl: "assets/images/whatsapp.png",
                    action: () async {
                      if(_formKey.currentState?.validate()??false){
                        const String _phoneNumber = "+8801557636857";
                        if (await canLaunch("https://wa.me/$_phoneNumber?text=${_mainMsg+_phoneC.text}")) {
                          // ০১৫৫৭৬৩৬৮৫৭
                          await launch("https://wa.me/$_phoneNumber?text=${_mainMsg+_phoneC.text}");
                          Get.back();
                        } else {
                          Xarvis.showToaster(
                              message: "Could not open WhatsApp");
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

