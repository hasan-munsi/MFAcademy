import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/globals/enums.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/model/user.dart';
import 'package:mf_academy/views/attendance/attendance_list.dart';
import 'package:mf_academy/views/auth/login.dart';
import 'package:mf_academy/views/global_views/webview.dart';
import 'package:mf_academy/views/notice/notice_list.dart';
import 'package:mf_academy/views/notifications/notifications_list.dart';
import 'package:mf_academy/views/program/program_list.dart';
import 'package:mf_academy/views/result/result_list.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  static const String id = "/HomePage";

  HomePage({Key? key}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final User? _user = Xarvis.loggedInUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Image.asset("assets/images/logo.png", width: 50),
            Xarvis.customWidth(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Xarvis.genericText(
                    text: "MARINE FISHERIES", textColor: Xarvis.appBgColor),
                Xarvis.genericText(
                  text: "ACADEMY",
                  textColor: Xarvis.appBgColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<DrawerOptions>(
            onSelected: (DrawerOptions result) {
              switch (result) {
                case DrawerOptions.login:
                  Get.toNamed(Login.id);
                  break;
                case DrawerOptions.programList:
                  Get.toNamed(ProgramList.id);
                  break;
                case DrawerOptions.notificationList:
                  Get.toNamed(NotificationsList.id);
                  break;
                case DrawerOptions.resultList:
                  Get.toNamed(ResultList.id);
                  break;
                case DrawerOptions.noticeList:
                  Get.toNamed(NoticeList.id);
                  break;
                case DrawerOptions.attendanceList:
                  Get.toNamed(AttendanceList.id);
                  break;
                case DrawerOptions.logout:
                  Xarvis.logoutKicker();
                  break;
                default:
                  break;
              }
            },
            icon: const Icon(
              Icons.menu,
              color: Xarvis.appBgColor,
            ),
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<DrawerOptions>>[
              PopupMenuItem<DrawerOptions>(
                value: DrawerOptions.homepage,
                child: Xarvis.genericText(
                    text: "Home Page", textColor: Xarvis.appBgColor),
              ),
              PopupMenuItem<DrawerOptions>(
                value: DrawerOptions.programList,
                child: Xarvis.genericText(
                    text: "Program List", textColor: Xarvis.appBgColor),
              ),
              PopupMenuItem<DrawerOptions>(
                value: DrawerOptions.cadetList,
                child: Xarvis.genericText(
                    text: "Cadet List", textColor: Xarvis.appBgColor),
              ),
              if (_user?.role == 1)
                PopupMenuItem<DrawerOptions>(
                  value: DrawerOptions.notificationList,
                  child: Xarvis.genericText(
                      text: "Notification List", textColor: Xarvis.appBgColor),
                ),
              if (_user?.role == 1)
                PopupMenuItem<DrawerOptions>(
                  value: DrawerOptions.resultList,
                  child: Xarvis.genericText(
                      text: "Result List", textColor: Xarvis.appBgColor),
                ),
              if (_user?.role == 1)
                PopupMenuItem<DrawerOptions>(
                  value: DrawerOptions.noticeList,
                  child: Xarvis.genericText(
                      text: "Notice List", textColor: Xarvis.appBgColor),
                ),
              if (_user?.role == 2)
                PopupMenuItem<DrawerOptions>(
                  value: DrawerOptions.attendanceList,
                  child: Xarvis.genericText(
                      text: "Attendance List", textColor: Xarvis.appBgColor),
                ),
              if (_user == null)
                PopupMenuItem<DrawerOptions>(
                  value: DrawerOptions.login,
                  child: Xarvis.genericText(
                      text: "Login", textColor: Xarvis.appBgColor),
                ),
              if (_user != null)
                PopupMenuItem<DrawerOptions>(
                  value: DrawerOptions.logout,
                  child: Xarvis.genericText(
                      text: "Logout", textColor: Xarvis.appBgColor),
                ),
            ],
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Xarvis.genericText(
                text: Xarvis.homeText,
                maxLines: 15,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Xarvis.getGlobalButton(
                    action: () async {
                      Get.dialog(
                        Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.9,
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Xarvis.fair,
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Xarvis.genericText(
                                        text: Xarvis.homeText,
                                        maxLines: 10000
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(onPressed: (){
                                      Get.back();
                                    }, child: Xarvis.genericText(text: "Okay", textColor: Xarvis.appBgColorLight)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    height: 35,
                    child: Xarvis.genericText(
                        text: "Read more",
                        textColor: Xarvis.fair,
                        fontSize: 12)),
              ),
              Xarvis.customHeight(20),
              Row(
                children: [
                  Expanded(
                    child: LoginHelpingButtonsUI(
                        label: "Follow Facebook Page",
                        imageUrl: "assets/images/facebook.png",
                        action: () {
                          Get.to(() => const GlobalWebView(
                              url:
                                  "https://www.facebook.com/mfacademy.gov.bd"));
                        }),
                  ),
                  Xarvis.customWidth(5),
                  Expanded(
                    child: LoginHelpingButtonsUI(
                        label: "24/7 Helpline",
                        imageUrl: "assets/images/whatsapp.png",
                        action: () async {
                          if (await canLaunch("https://wa.me")) {
                            await launch("https://wa.me");
                          } else {
                            Xarvis.showToaster(
                                message: "Could not open WhatsApp");
                          }
                        }),
                  ),
                  Xarvis.customWidth(5),
                  Expanded(
                    child: LoginHelpingButtonsUI(
                        label: "Our Website",
                        imageUrl: "assets/images/globe.png",
                        action: () {
                          Get.to(() => const GlobalWebView(
                              url: "https://www.mfacademy.gov.bd/"));
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
