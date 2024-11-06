
import 'package:flutter/material.dart';
import '../models/computer.dart';
import '../services/database_service.dart';
import 'computer_form_screen.dart';

class ComputerListScreen extends StatefulWidget {
  @override
  _ComputerListScreenState createState() => _ComputerListScreenState();
}

class _ComputerListScreenState extends State<ComputerListScreen> {
  final DatabaseService _databaseService = DatabaseService();
  late Future<List<Computer>> _computerList;

  @override
  void initState() {
    super.initState();
    _computerList = _databaseService.computers();
  }

  void _refreshComputerList() {
    setState(() {
      _computerList = _databaseService.computers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Computer List')),
      body: FutureBuilder<List<Computer>>(
        future: _computerList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No computers found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final computer = snapshot.data![index];
                return ListTile(
                  title: Text(computer.procesador),
                  subtitle: Text('RAM: ${computer.ram}, Disco Duro: ${computer.discoDuro}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          await Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ComputerFormScreen(computer: computer),
                          ));
                          _refreshComputerList();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await _databaseService.deleteComputer(computer.id!);
                          _refreshComputerList();
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ComputerFormScreen(),
          ));
          _refreshComputerList();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
