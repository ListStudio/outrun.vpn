import 'package:flutter/material.dart';

class Server {
  final String name;
  final String location;
  final int ping; // in ms
  bool isFavorite;

  Server(this.name, this.location, this.ping, {this.isFavorite = false});
}

class ServersScreen extends StatefulWidget {
  @override
  _ServersScreenState createState() => _ServersScreenState();
}

class _ServersScreenState extends State<ServersScreen> {
  List<Server> servers = [
    Server('Server 1', 'USA', 20),
    Server('Server 2', 'Germany', 50),
    Server('Server 3', 'France', 30),
    // Add more servers as needed
  ];
  
  String searchQuery = '';
  List<Server> filteredServers = [];

  @override
  void initState() {
    super.initState();
    filteredServers = servers;
  }

  void filterServers() {
    setState(() {
      filteredServers = servers.where((server) {
        return server.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
               server.location.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    });
  }

  Color getPingColor(int ping) {
    if (ping < 30) return Colors.green;
    if (ping < 100) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servers'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (value) {
                searchQuery = value;
                filterServers();
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredServers.length,
        itemBuilder: (context, index) {
          final server = filteredServers[index];
          return ListTile(
            title: Text(server.name),
            subtitle: Text('${server.location} - Ping: ${server.ping} ms',
              style: TextStyle(color: getPingColor(server.ping))),
            trailing: IconButton(
              icon: Icon(
                server.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: server.isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  server.isFavorite = !server.isFavorite;
                });
              },
            ),
          );
        },
      ),
    );
  }
}