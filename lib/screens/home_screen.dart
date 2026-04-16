import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String status = 'Disconnected';
  String serverInfo = 'Server: Not Connected';
  String ping = 'Ping: -- ms';
  String speed = 'Speed: -- Mbps';
  String ip = 'IP: --';

  void toggleConnection() {
    setState(() {
      if (status == 'Disconnected') {
        status = 'Connected';
        serverInfo = 'Server: Example Server';
        ping = 'Ping: 20 ms';
        speed = 'Speed: 50 Mbps';
        ip = 'IP: 192.168.1.1';
      } else {
        status = 'Disconnected';
        serverInfo = 'Server: Not Connected';
        ping = 'Ping: -- ms';
        speed = 'Speed: -- Mbps';
        ip = 'IP: --';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VPN Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[  
            ElevatedButton(
              onPressed: toggleConnection,
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: status == 'Disconnected' ? Colors.red : Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(serverInfo),
            Text(ping),
            Text(speed),
            Text(ip),
          ],
        ),
      ),
    );
  }
}