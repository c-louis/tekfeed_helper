import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekfeed_helper/models/app_data.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AppData>(create: (_) => AppData()),
      ],
      child: TekfeedApp(),
    ),
  );
}

class TekfeedApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tekfeed App',
      themeMode: ThemeMode.dark,
      home: Login(),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tekfeed Helper'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Card(
              child: InkWell(
                onTap: () => redirect(context),
                child: Center(child: Text('No login')),
              ),
            ),
          ),
          Expanded(
            child: Card(
              child: InkWell(
                onTap: () {
                  // TODO Add autologin ?
                  redirect(context);
                },
                child: Center(child: Text('Use AutoLogin')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> redirect(BuildContext context) async {
    await Provider.of<AppData>(context, listen: false).loadUnis();
    await Provider.of<AppData>(context, listen: false).loadCountries();
    // TODO redirect
  }
}