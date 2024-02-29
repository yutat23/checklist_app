import 'package:checklist_app/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:checklist_app/models/checklist_item.dart';
import 'package:checklist_app/helpers/preferences_helper.dart';
import 'package:checklist_app/screens/image_display_screen.dart';

class ChecklistScreen extends StatefulWidget {
  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  List<ChecklistItem> _checklist = [];

  @override
  void initState() {
    super.initState();
    _loadChecklist();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadChecklist();
  }

  Future<void> _loadChecklist() async {
    final checklist = await PreferencesHelper.getChecklist();
    setState(() {
      _checklist = checklist;
    });
  }

  void _toggleItem(int index) async {
    setState(() {
      _checklist[index].isChecked = !_checklist[index].isChecked;
    });
    await PreferencesHelper.saveChecklist(_checklist);
    if (_checklist.every((item) => item.isChecked)) {
      // すべての項目がチェックされている場合、画像表示画面に遷移する前にチェックを外す
      for (var item in _checklist) {
        item.isChecked = false;
      }
      await PreferencesHelper.saveChecklist(_checklist);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ImageDisplayScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadChecklist();
    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _checklist.length,
        itemBuilder: (context, index) {
          final item = _checklist[index];
          return CheckboxListTile(
            title: Text(item.title),
            value: item.isChecked,
            onChanged: (_) => _toggleItem(index),
          );
        },
      ),
    );
  }
}
