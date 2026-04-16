import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _language = 'English';
  bool _autoConnect = false;
  bool _killSwitch = false;
  bool _splitTunneling = false;
  String _protocol = 'OpenVPN';
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _language = prefs.getString('language') ?? 'English';
      _autoConnect = prefs.getBool('autoConnect') ?? false;
      _killSwitch = prefs.getBool('killSwitch') ?? false;
      _splitTunneling = prefs.getBool('splitTunneling') ?? false;
      _protocol = prefs.getString('protocol') ?? 'OpenVPN';
      _darkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', _language);
    await prefs.setBool('autoConnect', _autoConnect);
    await prefs.setBool('killSwitch', _killSwitch);
    await prefs.setBool('splitTunneling', _splitTunneling);
    await prefs.setString('protocol', _protocol);
    await prefs.setBool('darkMode', _darkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _language,
              items: <String>['English', 'Russian', 'Kazakh', 'Belarusian', 'Ukrainian']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _language = newValue!;
                  _saveSettings();
                });
              },
            ),
            SwitchListTile(
              title: Text('Auto Connect'),
              value: _autoConnect,
              onChanged: (bool value) {
                setState(() {
                  _autoConnect = value;
                  _saveSettings();
                });
              },
            ),
            SwitchListTile(
              title: Text('Kill Switch'),
              value: _killSwitch,
              onChanged: (bool value) {
                setState(() {
                  _killSwitch = value;
                  _saveSettings();
                });
              },
            ),
            SwitchListTile(
              title: Text('Split Tunneling'),
              value: _splitTunneling,
              onChanged: (bool value) {
                setState(() {
                  _splitTunneling = value;
                  _saveSettings();
                });
              },
            ),
            DropdownButton<String>(
              value: _protocol,
              items: <String>['OpenVPN', 'IKEv2', 'WireGuard']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _protocol = newValue!;
                  _saveSettings();
                });
              },
            ),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: _darkMode,
              onChanged: (bool value) {
                setState(() {
                  _darkMode = value;
                  _saveSettings();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}