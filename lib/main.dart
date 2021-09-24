import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekfeed_helper/models/app_data.dart';
import 'package:tekfeed_helper/pages/university.dart';
import 'package:vrouter/vrouter.dart';

void main() {
  CatcherOptions debugOptions = CatcherOptions(SilentReportMode(),
    [
      ConsoleHandler(),
      DiscordHandler(
        "https://discord.com/api/webhooks/890615891350396988/EsXlayV-Lo_LEVk9EV1ZKHN2fK9Gjnsj6EWAQlZmlF_tPevGzbaVQeMudYelJNlFM-5F",
        enableApplicationParameters: true,
        enableStackTrace: true,
        enableDeviceParameters: true,
        enableCustomParameters: true
      )
    ]
  );

  CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(),
      [
        ConsoleHandler(),
        DiscordHandler(
          "https://discord.com/api/webhooks/890615891350396988/EsXlayV-Lo_LEVk9EV1ZKHN2fK9Gjnsj6EWAQlZmlF_tPevGzbaVQeMudYelJNlFM-5F",
          enableApplicationParameters: true,
          enableStackTrace: true,
          enableDeviceParameters: true,
          enableCustomParameters: true
        )
      ],
  );

  Catcher(
    rootWidget: AppRoot(),
    debugConfig: debugOptions,
    releaseConfig: releaseOptions,
  );
}

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppData>(create: (_) => AppData()),
      ],
      child: TekfeedRoutes(),
    );
  }
}

class TekfeedRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VRouter(
      navigatorKey: Catcher.navigatorKey,
      routes: [
        VWidget(
          path: '/',
          widget: LoginPage(),
          name: 'Login',
        ),
        VWidget(
          path: '/unis',
          widget: UniversityPage(),
          name: 'unis',
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
                  onTap: () async {
                    redirect(context, loadingData);
                  },
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