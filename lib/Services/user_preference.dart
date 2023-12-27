import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static SharedPreferences? _prefrences;
  static const _userName = 'UserName';
  static const _userPic = 'UserPic';
  static const _userBudget = 'UserBudget';
  static Future init() async {
    _prefrences = await SharedPreferences.getInstance();
  }

  static Future setUserName(String userName) async {
    await _prefrences!.setString(_userName, userName);
  }

  static Future setUserBudget(data) async {
    final jsonString = json.encode(data);
    await _prefrences!.setString(_userBudget, jsonString);
  }

  static getUserBudget() {
    var val = _prefrences!.getString(_userBudget);
    if (val == null) {
      return null;
    } else {
      return jsonDecode(val);
    }
  }

  static getUserName() {
    return _prefrences!.getString(_userName);
  }

  static getUserPic() {
    return _prefrences!.getString(_userPic);
  }

  static Future setUserPic(String userPic) async {
    await _prefrences!.setString(_userPic, userPic);
  }
}
