import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekfeed_helper/models/app_account.dart';
import 'package:tekfeed_helper/models/app_data.dart';
import 'package:tekfeed_helper/pages/login.dart';
import 'package:tekfeed_helper/pages/university.dart';
import 'package:vrouter/vrouter.dart';

import 'models/app_state.dart';

String buildMessage(Report report) {
  final StringBuffer stringBuffer = StringBuffer();
  stringBuffer.write("**Error:**\n${report.error}\n\n");
    stringBuffer.write("**Stack trace:**\n ``` ${report.stackTrace} ```\n\n");
  if (report.deviceParameters.isNotEmpty) {
    stringBuffer.write("**Device parameters:**\n ``` ");
    for (final entry in report.deviceParameters.entries) {
      stringBuffer.write("${entry.key}: ${entry.value}\n");
    }
    stringBuffer.write(" ``` \n\n");
  }
  if (report.applicationParameters.isNotEmpty) {
    stringBuffer.write("**Application parameters:**\n ``` ");
    for (final entry in report.applicationParameters.entries) {
      stringBuffer.write("${entry.key}: ${entry.value}\n");
    }
    stringBuffer.write(" ``` \n\n");
  }
  if (report.customParameters.isNotEmpty) {
    stringBuffer.write("**Custom parameters:**\n ``` ");
    for (final entry in report.customParameters.entries) {
      stringBuffer.write("${entry.key}: ${entry.value}\n");
    }
    stringBuffer.write(" ``` \n\n");
  }
  return stringBuffer.toString();
}

void main() {
  CatcherOptions debugOptions = CatcherOptions(SilentReportMode(),
    [
      ConsoleHandler(),
      DiscordHandler(
        "https://discord.com/api/webhooks/890615891350396988/EsXlayV-Lo_LEVk9EV1ZKHN2fK9Gjnsj6EWAQlZmlF_tPevGzbaVQeMudYelJNlFM-5F",
        enableApplicationParameters: true,
        enableStackTrace: true,
        enableDeviceParameters: true,
        enableCustomParameters: true,
        customMessageBuilder: buildMessage
      )
    ]
  );

  CatcherOptions releaseOptions = CatcherOptions(SilentReportMode(),
      [
        ConsoleHandler(),
        DiscordHandler(
          "https://discord.com/api/webhooks/890615891350396988/EsXlayV-Lo_LEVk9EV1ZKHN2fK9Gjnsj6EWAQlZmlF_tPevGzbaVQeMudYelJNlFM-5F",
          enableApplicationParameters: true,
          enableStackTrace: true,
          enableDeviceParameters: true,
          enableCustomParameters: true,
          customMessageBuilder: buildMessage
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
        Provider<AppAccount>(create: (_) => AppAccount()),
        ChangeNotifierProvider(create: (_) => AppState()),
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