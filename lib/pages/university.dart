import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tekfeed_helper/models/app_data.dart';
import 'package:tekfeed_helper/pages/university_mobile.dart';
import 'package:tekfeed_helper/pages/university_web.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class UniversityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);
    if (data.unis.isEmpty) {
      VRouter.of(context).to('/');
    }
    if (kIsWeb) {
      return Scaffold(
        body: UniversityWebPage(),
      );
    } else {
      return Scaffold(
        body: UniversityMobilePage(),
      );
    }
  }

}