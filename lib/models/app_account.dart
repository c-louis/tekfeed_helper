import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tekfeed_helper/models/app_state.dart';
import 'package:tekfeed_helper/models/epitech_login.dart';

class AppAccount {
  bool isLogin = false;
  late EpitechLogin login;
  late List<AppState> savedPresets;

  Future<void> loadLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('tekfeed.login') != null) {
      String logSaved = prefs.getString('tekfeed.login')!;
      login = EpitechLogin.fromJson(jsonDecode(logSaved));
      isLogin = true;
    }
  }

  Future<void> saveLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tekfeed.login', jsonEncode(login.toJson()));
  }

  Future<void> loadPresets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('tekfeed.presets') == null) {
      savedPresets = [];
    } else {
      savedPresets = [];
      List<String> savedPresetsStr = prefs.getStringList('tekfeed.presets')!;
      for (var str in savedPresetsStr) {
        savedPresets.add(AppState.fromJson(jsonDecode(str)));
      }
    }
  }

  Future<void> saveNewPresets(AppState state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<AppState> presets = [];
    if (prefs.getStringList('tekfeed.presets') != null) {
      for (var preset in prefs.getStringList('tekfeed.presets')!) {
        presets.add(AppState.fromJson(jsonDecode(preset)));
      }
    }
    presets.add(state);
    prefs.setStringList('tekfeed.presets', presets.map((e) => jsonEncode(e.toJson())).toList());
    loadPresets();
  }

  Future<void> removePreset(String appStateName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<AppState> presets = [];
    if (prefs.getStringList('tekfeed.presets') != null) {
      for (var preset in prefs.getStringList('tekfeed.presets')!) {
        presets.add(AppState.fromJson(jsonDecode(preset)));
      }
    }
    presets.removeWhere((element) => element.name == appStateName);
    prefs.setStringList('tekfeed.presets', presets.map((e) => jsonEncode(e.toJson())).toList());
    loadPresets();
  }
}