import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:checklist_app/models/checklist_item.dart';
import 'package:checklist_app/helpers/preferences_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _textController = TextEditingController();
  List<ChecklistItem> _checklist = [];

  @override
  void initState() {
    super.initState();
    _loadChecklist();
  }

  Future<void> _loadChecklist() async {
    final checklist = await PreferencesHelper.getChecklist();
    setState(() {
      _checklist = checklist;
    });
  }

  void _addChecklistItem() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _checklist.add(ChecklistItem(title: _textController.text));
        _textController.clear();
      });
      PreferencesHelper.saveChecklist(_checklist);
    }
  }

  void _removeChecklistItem(int index) {
    setState(() {
      _checklist.removeAt(index);
    });
    PreferencesHelper.saveChecklist(_checklist);
  }

  Future<void> _pickImage() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      PreferencesHelper.saveImagePath(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Add checklist item',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addChecklistItem,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _checklist.length,
              itemBuilder: (context, index) {
                final item = _checklist[index];
                return ListTile(
                  title: Text(item.title),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeChecklistItem(index),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Select Image'),
          ),
        ],
      ),
    );
  }
}
