import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/globals/enums.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/model/user.dart';
import 'package:mf_academy/views/attendance/attendance_list.dart';
import 'package:mf_academy/views/auth/login.dart';
import 'package:mf_academy/views/cadet/cadet_list.dart';
import 'package:mf_academy/views/global_views/webview.dart';
import 'package:mf_academy/views/notice/notice_list.dart';
import 'package:mf_academy/views/notifications/notifications_list.dart';
import 'package:mf_academy/views/program/program_list.dart';
import 'package:mf_academy/views/result/result_list.dart';
import 'package:mf_academy/views/utils/pdf_viewer.dart';
import 'package:mf_academy/views/utils/social_buttons.dart';
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Xarvis.genericText(
                    text: "MARINE FISHERIES",
                    textColor: Xarvis.appBgColor,
                    height: 1),
                Xarvis.genericText(
                  text: "ACADEMY",
                  textColor: Xarvis.appBgColorLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  height: 1,
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
                case DrawerOptions.officerAdminList:
                  Get.to(() => const GlobalPdfViewer(
                      url: "${Xarvis.kURL}/storage/employee/employee.pdf"));
                  break;
                case DrawerOptions.cadetList:
                  Get.to(() => const CadetList(type: 1));
                  break;
                case DrawerOptions.cadetActivities:
                  Get.to(() => const CadetList(
                        type: 2,
                        title: "Recent Cadet Activities",
                      ));
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
                value: DrawerOptions.noticeList,
                child: Xarvis.genericText(
                    text: "General Notice", textColor: Xarvis.appBgColor),
              ),
              PopupMenuItem<DrawerOptions>(
                value: DrawerOptions.programList,
                child: Xarvis.genericText(
                    text: "Program List", textColor: Xarvis.appBgColor),
              ),
              if (_user != null)
                PopupMenuItem<DrawerOptions>(
                  value: DrawerOptions.cadetList,
                  child: Xarvis.genericText(
                      text: "Cadet List", textColor: Xarvis.appBgColor),
                ),
              PopupMenuItem<DrawerOptions>(
                value: DrawerOptions.officerAdminList,
                child: Xarvis.genericText(
                    text: "Officers and Admin List",
                    textColor: Xarvis.appBgColor),
              ),
              if (_user != null)
                PopupMenuItem<DrawerOptions>(
                  value: DrawerOptions.cadetActivities,
                  child: Xarvis.genericText(
                      text: "Recent Cadet Activities",
                      textColor: Xarvis.appBgColor),
                ),
              if (_user != null)
                PopupMenuItem<DrawerOptions>(
                  value: DrawerOptions.resultList,
                  child: Xarvis.genericText(
                      text: "Cadet Results", textColor: Xarvis.appBgColor),
                ),
              if (_user?.role == 1 || _user?.role == 3)
                PopupMenuItem<DrawerOptions>(
                  value: DrawerOptions.notificationList,
                  child: Xarvis.genericText(
                      text: "Message", textColor: Xarvis.appBgColor),
                ),
              if (_user?.role == 2)
                PopupMenuItem<DrawerOptions>(
                  value: DrawerOptions.attendanceList,
                  child: Xarvis.genericText(
                      text: "Attendance", textColor: Xarvis.appBgColor),
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
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/banner.jpeg",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Xarvis.customHeight(20),

                  ///History
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Xarvis.dark),
                              ),
                            ),
                            child: Xarvis.genericText(
                              text: "History:",
                              textColor: Xarvis.dark,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Xarvis.genericText(
                            text: Xarvis.homeText,
                            maxLines: 3,
                            overflow: TextOverflow.clip,
                            height: 1,
                            fontSize: 14),
                        Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () async {
                                Get.dialog(
                                  Scaffold(
                                    backgroundColor: Colors.transparent,
                                    body: Center(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.9,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        padding: const EdgeInsets.only(
                                            top: 20, left: 20, right: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Xarvis.fair,
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: SingleChildScrollView(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                child: Xarvis.genericText(
                                                  text: Xarvis.homeText,
                                                  maxLines: 10000,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Xarvis.genericText(
                                                      text: "Okay",
                                                      textColor: Xarvis
                                                          .appBgColorLight)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: Xarvis.appBgColor),
                                  ),
                                ),
                                child: Xarvis.genericText(
                                  text: "Read more...",
                                  textColor: Xarvis.appBgColor,
                                  fontSize: 14,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),

                  ///Vision
                  Expanded(
                    child: Container(
                      color: Colors.grey.withOpacity(0.2),
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Xarvis.dark),
                                ),
                              ),
                              child: Xarvis.genericText(
                                text: "Vision:",
                                textColor: Xarvis.dark,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Xarvis.genericText(
                              text: Xarvis.visionText,
                              maxLines: 50,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Xarvis.customHeight(10),

                  ///Objectives
                  Expanded(
                    child: Container(
                      color: Colors.grey.withOpacity(0.2),
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Xarvis.dark),
                                ),
                              ),
                              child: Xarvis.genericText(
                                text: "Objectives:",
                                textColor: Xarvis.dark,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Xarvis.genericText(
                              text: Xarvis.objectivesText,
                              maxLines: 50,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Xarvis.customHeight(10),
                ],
              ),
            ),
            const SizedBox(
              height: 120,
              child: SocialButtons(),
            )
          ],
        ),
      ),
    );
  }
}
