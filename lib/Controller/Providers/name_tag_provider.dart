import 'package:flutter/foundation.dart';
import '../../Services/user_preference.dart';

class NameTagNotifer extends ChangeNotifier {
  final String _name = 'Wizard ';
  final String _pic = 'girl';
  String get name => UserPreference.getUserName() ?? _name;
  String get pic => UserPreference.getUserPic() ?? _pic;

  setname(String name) async {
    await UserPreference.setUserName(name);
    notifyListeners();
  }

  setPic(String pic) async {
    await UserPreference.setUserPic(pic);
    notifyListeners();
  }
  setBudget(){
    
  }
}
