import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekfeed_helper/models/app_account.dart';
import 'package:tekfeed_helper/models/app_data.dart';
import 'package:tekfeed_helper/models/epitech_login.dart';
import 'package:vrouter/vrouter.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    Future<void> loadingData = Provider.of<AppData>(context, listen: false).loadData(context);

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
                  onTap: () async {
                    await loadingData;
                    AppAccount aa = Provider.of<AppAccount>(context, listen: false);
                    if (aa.isLogin) {
                      redirect(context, loadingData);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('To login please provider your Epitech autologin link'),
                                TextField(
                                  controller: _controller,
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                  child: Text('Cancel', style: TextStyle(color: Colors.red),)
                              ),
                              TextButton(
                                onPressed: () async {
                                  EpitechLogin? el = await EpitechLogin.request(_controller.text);
                                  if (el != null) {
                                    AppAccount aa = Provider.of<AppAccount>(context, listen: false);
                                    aa.login = el;
                                    aa.isLogin = true;
                                    aa.saveLogin();
                                  }
                                  VRouter.of(context).to('/unis');
                                  Navigator.of(context).pop();
                                },
                                child: Text('Login', style: TextStyle(color: Colors.green)),
                              ),
                            ],
                          );
                        }
                      );
                    }
                  },
                  child: Center(
                      child: Text('Use AutoLogin !', textAlign: TextAlign.center,)
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