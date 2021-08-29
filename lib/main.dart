import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekfeed_helper/models/app_data.dart';
import 'package:tekfeed_helper/pages/university.dart';
import 'package:vrouter/vrouter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AppData>(create: (_) => AppData()),
      ],
      child: TekfeedRoutes(),
    ),
  );
}

class TekfeedRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VRouter(
      routes: [
        VWidget(
          path: '/',
          widget: LoginPage(),
          name: 'Login',
        ),
        VWidget(
          path: '/unis',
          widget: UniversityPage(),
          name: 'Login',
        ),
      ],
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      mode: VRouterMode.history,
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> loadingData = Provider.of<AppData>(context, listen: false).loadData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tekfeed Helper'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: Card(
                child: InkWell(
                  onTap: () => redirect(context, loadingData),
                  child: Center(child: Text('No login')),
                ),
              ),
            ),
            Expanded(
              child: Card(
                child: InkWell(
                  child: Center(
                    child: Text('Use AutoLogin\nNot Yet available !', textAlign: TextAlign.center,)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> redirect(BuildContext context, data) async {
    await data;
    VRouter.of(context).to('/unis');
  }
}