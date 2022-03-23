import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/views/attendance/attendance_list.dart';
import 'package:mf_academy/views/attendance/single_student_attendance.dart';
import 'package:mf_academy/views/auth/login.dart';
import 'package:mf_academy/views/cadet/cadet_list.dart';
import 'package:mf_academy/views/home/home_page.dart';
import 'package:mf_academy/views/loader/loader.dart';
import 'package:mf_academy/views/notice/notice_list.dart';
import 'package:mf_academy/views/notice/notice_list.dart';
import 'package:mf_academy/views/notifications/notifications_list.dart';
import 'package:mf_academy/views/program/program_list.dart';
import 'package:mf_academy/views/result/result_list.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getToken();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  } else {
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Get.snackbar(
        "${message.notification?.title}",
        "${message.notification?.body}",
        duration: const Duration(seconds: 300),
        backgroundColor: Xarvis.fair,
        backgroundGradient: LinearGradient(colors: [Xarvis.fair, Xarvis.fair.withOpacity(0.5)], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        borderColor: Xarvis.dark,
        borderWidth: 1,
        borderRadius: 15,
        icon: const Icon(CupertinoIcons.bell),
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        titleText: Xarvis.genericText(text: message.notification?.title ?? "", textColor: Xarvis.appBgColor, fontWeight: FontWeight.bold, fontSize: 14),
        messageText: Xarvis.genericText(text: message.notification?.body ?? "", textColor: Xarvis.appBgColor, fontSize: 14),
        onTap: (sb){
          if(Get.isSnackbarOpen){
            Get.closeAllSnackbars();
          }
          Get.toNamed(NotificationsList.id);
        }
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Marine Fisheries Academy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoaderView.id,
      routes: {
        LoaderView.id: (context) => const LoaderView(),
        Login.id: (context) => const Login(),
        HomePage.id: (context) => HomePage(),
        ProgramList.id: (context) => const ProgramList(),
        ResultList.id: (context) => const ResultList(),
        NoticeList.id: (context) => const NoticeList(),
        NotificationsList.id: (context) => const NotificationsList(),
        AttendanceList.id: (context) => const AttendanceList(),
        SingleStudentAttendance.id: (context) => const SingleStudentAttendance(),
      },
    );
  }
}
