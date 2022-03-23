import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../globals/xarvis.dart';
import '../auth/login.dart';
import '../global_views/webview.dart';
class SocialButtons extends StatelessWidget {
  const SocialButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: LoginHelpingButtonsUI(
                  label: "Facebook Page",
                  imageUrl: "assets/images/facebook.png",
                  action: () {
                    Get.to(() => const GlobalWebView(
                        url:
                        "https://www.facebook.com/mfacademy.gov.bd"));
                  }),
            ),
            Xarvis.customWidth(15),
            Expanded(
              child: LoginHelpingButtonsUI(
                  label: "24/7 Helpline",
                  imageUrl: "assets/images/whatsapp.png",
                  action: () async {
                    const String _phoneNumber = "+8801557636857";
                    if (await canLaunch("https://wa.me/$_phoneNumber?text=Hi")) {
                    // ০১৫৫৭৬৩৬৮৫৭
                      await launch("https://wa.me/$_phoneNumber?text=Hi");
                    } else {
                      Xarvis.showToaster(
                          message: "Could not open WhatsApp");
                    }
                  }),
            ),
          ],
        ),
        Xarvis.customHeight(10),
        Row(
          children: [
            Expanded(
              child: LoginHelpingButtonsUI(
                  label: "Our Website",
                  imageUrl: "assets/images/globe.png",
                  action: () {
                    Get.to(() => const GlobalWebView(
                        url: "https://www.mfacademy.gov.bd/"));
                  }),
            ),
            Xarvis.customWidth(15),
            Expanded(
              child: LoginHelpingButtonsUI(
                  label: "My Gov",
                  imageUrl: "assets/images/globe.png",
                  action: () {
                    Get.to(() => const GlobalWebView(
                        url: "https://www.mygov.bd/"),
                    );
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
