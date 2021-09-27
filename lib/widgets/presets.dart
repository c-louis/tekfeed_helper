import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekfeed_helper/models/app_account.dart';
import 'package:tekfeed_helper/models/app_state.dart';

class Presets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppAccount appAccount = Provider.of<AppAccount>(context, listen: false);
    TextEditingController _newPresetController = TextEditingController();
    return StatefulBuilder(
      builder: (context, setStateDialog) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Preset name : '),
                          TextField(
                            controller: _newPresetController,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Cancel', style: TextStyle(color: Colors.red)),
                        ),
                        TextButton(
                          onPressed: () async {
                            Provider.of<AppState>(context, listen: false).name = _newPresetController.text;
                            appAccount.saveNewPresets(Provider.of<AppState>(context, listen: false));
                            setStateDialog(() {});
                            Navigator.of(context).pop();
                          },
                          child: Text('Save', style: TextStyle(color: Colors.green)),
                        ),
                      ],
                    ),
                  );
                },
                title: Row(
                  children: [
                    Icon(Icons.save),
                    Text('Save current filter and sorter'),
                  ],
                ),
              ),
              for (var preset in appAccount.savedPresets)
                ListTile(
                  onTap: () {
                    Provider.of<AppState>(context, listen: false).load(preset);
                  },
                  title: Text(preset.name ?? 'No Name'),
                  trailing: IconButton(
                    splashRadius: 30,
                    onPressed: () {
                      appAccount.removePreset(preset.name!);
                      setStateDialog(() {});
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ),
            ],
          ),
        );
      }
    );
  }

}