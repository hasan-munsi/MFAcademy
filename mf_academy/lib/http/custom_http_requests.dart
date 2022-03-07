import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mf_academy/globals/xarvis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomHTTPRequests {
  static final client = http.Client();

  static Map<String, String> getDefaultHeader() {
    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
  }

  static Future<Map<String, String>> getHeaderWithToken() async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    final String _token = _sharedPrefs.getString("token") ?? "";
    return {"Accept": "application/json", "Content-Type": "application/json", "Authorization": _token};
  }

  static bool isSuccess(dynamic data) {
    return data["ok"];
  }

  static Future login(Map<String, String> allData) async {
    try {
      final Uri _uri = Uri.parse("${Xarvis.kApiURL}/login");
      final _response = await client.post(
        _uri,
        headers: getDefaultHeader(),
        body: json.encode(allData),
      );

      final _data = json.decode(_response.body);
      if (isSuccess(_data)) {
        return _data;
      } else {
        Xarvis.showToaster(message: _data["message"]);
      }
    } catch (e) {
      Xarvis.showToaster(message: "Something wrong on login: $e");
    }
  }

  static Future me() async {
    try {
      final Uri _uri = Uri.parse("${Xarvis.kApiURL}/me");
      final _response = await client.get(_uri, headers: await getHeaderWithToken());

      final _data = json.decode(_response.body);
      Xarvis.logger.i(_data);
      if (isSuccess(_data)) {
        return _data;
      } else {
        Xarvis.showToaster(message: _data["message"]);
      }
    } catch (e) {
      Xarvis.showToaster(message: "Something wrong on me: $e");
    }
  }

  static Future programList(int page) async {
    try {
      final Uri _uri = Uri.parse("${Xarvis.kApiURL}/program-list?per_page=100&page=$page");
      final _response = await client.get(_uri, headers: await getHeaderWithToken());

      final _data = json.decode(_response.body);
      Xarvis.logger.i(await getHeaderWithToken());
      Xarvis.logger.i(_data);
      if (isSuccess(_data)) {
        return _data;
      } else {
        Xarvis.showToaster(message: _data["message"]);
      }
    } catch (e) {
      Xarvis.showToaster(message: "Something wrong on program list: $e");
    }
  }

  static Future programDetails(int id) async {
    try {
      final Uri _uri = Uri.parse("${Xarvis.kApiURL}/program/1");
      final _response = await client.get(_uri, headers: await getHeaderWithToken());

      final _data = json.decode(_response.body);
      Xarvis.logger.i(await getHeaderWithToken());
      Xarvis.logger.i(_data);
      if (isSuccess(_data)) {
        return _data;
      } else {
        Xarvis.showToaster(message: _data["message"]);
      }
    } catch (e) {
      Xarvis.showToaster(message: "Something wrong on program details: $e");
    }
  }

  static Future notificationList(int page) async {
    try {
      final Uri _uri = Uri.parse("${Xarvis.kApiURL}/notifications?per_page=100&page=$page");
      final _response = await client.get(_uri, headers: await getHeaderWithToken());

      final _data = json.decode(_response.body);
      Xarvis.logger.i(await getHeaderWithToken());
      Xarvis.logger.i(_data);
      if (isSuccess(_data)) {
        return _data;
      } else {
        Xarvis.showToaster(message: _data["message"]);
      }
    } catch (e) {
      Xarvis.showToaster(message: "Something wrong on notification list: $e");
    }
  }

  static Future notificationDetails(String id) async {
    try {
      final Uri _uri = Uri.parse("${Xarvis.kApiURL}/notification/$id");
      final _response = await client.get(_uri, headers: await getHeaderWithToken());

      final _data = json.decode(_response.body);
      Xarvis.logger.i(await getHeaderWithToken());
      Xarvis.logger.i(_data);
      if (isSuccess(_data)) {
        return _data;
      } else {
        Xarvis.showToaster(message: _data["message"]);
      }
    } catch (e) {
      Xarvis.showToaster(message: "Something wrong on notification details: $e");
    }
  }

  static Future readAllNotification() async {
    try {
      final Uri _uri = Uri.parse("${Xarvis.kApiURL}/read-all-notifications");
      final _response = await client.get(_uri, headers: await getHeaderWithToken());

      final _data = json.decode(_response.body);
      Xarvis.logger.i(await getHeaderWithToken());
      Xarvis.logger.i(_data);
      if (isSuccess(_data)) {
        Xarvis.showToaster(message: "All notifications are read");
      } else {
        Xarvis.showToaster(message: _data["message"]);
      }
    } catch (e) {
      Xarvis.showToaster(message: "Something wrong on notification read: $e");
    }
  }

  static Future logout() async {
    try {
      final Uri _uri = Uri.parse("${Xarvis.kApiURL}/logout");
      final _response = await client.post(_uri, headers: await getHeaderWithToken());

      final _data = json.decode(_response.body);
      Xarvis.logger.i(await getHeaderWithToken());
      Xarvis.logger.i(_data);
      if (isSuccess(_data)) {
        Xarvis.logger.i(_data);
        return true;
      } else {
        Xarvis.showToaster(message: _data["message"]);
      }
    } catch (e) {
      Xarvis.showToaster(message: "Something wrong on logout: $e");
    }
  }

  static Future updateToken(Map<String, String> data) async {
    try {
      final Uri _uri = Uri.parse("${Xarvis.kApiURL}/update/token");
      final _response = await client.post(_uri, headers: await getHeaderWithToken(), body: json.encode(data));

      final _data = json.decode(_response.body);
      Xarvis.logger.i(_data);
      if (isSuccess(_data)) {
        return true;
      } else {
        Xarvis.showToaster(message: _data["message"]);
      }
    } catch (e) {
      Xarvis.showToaster(message: "Something wrong on token update: $e");
    }
  }
}
