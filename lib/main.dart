import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(OutrunVpnApp());
}

class OutrunVpnApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Outrun VPN',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      supportedLocales: [
        const Locale('en', ''), // English
        const Locale('es', ''), // Spanish
        // Add other locales here
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(
        appBar: AppBar(
          title: Text('Outrun VPN'),
        ),
        body: Center(
          child: Text('Welcome to Outrun VPN!'),
        ),
      ),
    );
  }
}