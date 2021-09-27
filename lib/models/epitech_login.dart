import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'epitech_login.g.dart';

@JsonSerializable()
class EpitechLogin {
  final String? login;
  final String? title;
  final String? internal_email;
  final String? lastname;
  final String? firstname;
  final int? promo;
  final int? semester;
  final String? location;
  final List<Gpa>? gpa;

  EpitechLogin(this.login, this.title, this.internal_email, this.lastname, this.firstname, this.promo, this.semester, this.location, this.gpa);
  factory EpitechLogin.fromJson(Map<String, dynamic> json) => _$EpitechLoginFromJson(json);
  Map<String, dynamic> toJson() => _$EpitechLoginToJson(this);

  static Future<EpitechLogin?> request(String autoLogin) async {
    if (!autoLogin.contains("https://intra.epitech.eu/auth-")) {
      return null;
    }
    String url = 'https://tekfeed-middle-api.cl-dev.ovh/epitech/login?login=$autoLogin';
    var uri = Uri.parse(url);
    print(uri);
    var response = await http.get(uri);
    if (response.statusCode != 200) {
      return null;
    }
    return EpitechLogin.fromJson(jsonDecode(response.body));
  }

}

@JsonSerializable()
class Gpa {
  final String? gpa;
  final String? cycle;

  Gpa(this.gpa, this.cycle);
  factory Gpa.fromJson(Map<String, dynamic> json) => _$GpaFromJson(json);
  Map<String, dynamic> toJson() => _$GpaToJson(this);
}