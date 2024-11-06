import 'package:flutter/material.dart';
import 'package:computadoras/common_widgets/computer_builder.dart';

import 'package:computadoras/models/computer.dart';

import 'package:computadoras/pages/computer_form_page.dart';
import 'package:computadoras/services/database_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomePram extends StatefulWidget {
  const HomePram({Key? key}) : super(key: key);

  @override
  _HomePramState createState() => _HomePramState();
}

class _HomePramState extends State<HomePram> {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Computer>> _getComputers() async {
    return await _databaseService.computers();
  }


  Future<void> _onComputerDelete(Computer computer) async {
    await _databaseService.deleteComputer(computer.id!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Computer Database'),
          centerTitle: true,

        ),
        body: TabBarView(
          children: [
            ComputerBuilder(
              future: _getComputers(),
              onEdit: (value) {
                {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) => ComputerFormPram(computer: value),
                          fullscreenDialog: true,
                        ),
                      )
                      .then((_) => setState(() {}));
                }
              },
              onDelete: _onComputerDelete,
            ),

          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            SizedBox(height: 12.0),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (_) => ComputerFormPram(),
                        fullscreenDialog: true,
                      ),
                    )
                    .then((_) => setState(() {}));
              },
              heroTag: 'addComputer',
              child: FaIcon(FontAwesomeIcons.paw),
            ),
          ],
        ),
      ),
    );
  }
}
