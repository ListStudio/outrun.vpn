import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Subscription {
  String id;
  String name;
  bool isActive;

  Subscription({required this.id, required this.name, this.isActive = true});
}

class SubscriptionsScreen extends StatefulWidget {
  @override
  _SubscriptionsScreenState createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  List<Subscription> subscriptions = [];
  late Timer timer; // Timer for auto-update

  @override
  void initState() {
    super.initState();
    fetchSubscriptions();
    // Set up auto-update every 30 seconds
    timer = Timer.periodic(Duration(seconds: 30), (Timer t) => fetchSubscriptions());
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> fetchSubscriptions() async {
    // Replace with actual GitHub RAW URL
    final response = await http.get(Uri.parse('https://raw.githubusercontent.com/ListStudio/outrun.vpn/main/subscriptions.json'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        subscriptions = data.map((sub) => Subscription(id: sub['id'], name: sub['name'], isActive: sub['isActive'])).toList();
      });
    } else {
      throw Exception('Failed to load subscriptions');
    }
  }

  void addSubscription(String name) {
    setState(() {
      subscriptions.add(Subscription(id: DateTime.now().toString(), name: name));
    });
  }

  void editSubscription(String id, String newName) {
    setState(() {
      Subscription sub = subscriptions.firstWhere((s) => s.id == id);
      sub.name = newName;
    });
  }

  void deleteSubscription(String id) {
    setState(() {
      subscriptions.removeWhere((s) => s.id == id);
    });
  }

  void toggleSubscription(String id) {
    setState(() {
      Subscription sub = subscriptions.firstWhere((s) => s.id == id);
      sub.isActive = !sub.isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subscriptions')),
      body: ListView.builder(
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          final sub = subscriptions[index];
          return ListTile(
            title: Text(sub.name),
            trailing: Switch(
              value: sub.isActive,
              onChanged: (value) {
                toggleSubscription(sub.id);
              },
            ),
            onTap: () {
              // You can add edit functionality by tap
            },
            onLongPress: () {
              deleteSubscription(sub.id);
            },
          );
        },
      ),
    );
  }
}