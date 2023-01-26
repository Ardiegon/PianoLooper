import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piano_looper/screens/home_page.dart';
import 'package:piano_looper/filesystem/file_manager.dart';


class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Records"),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<Widget>>(
        future: createFileButtons(),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
            if (!snapshot.hasData) {
            // while data is loading:
            return Center(
              child: CircularProgressIndicator(),
            );
            } else {
              // data loaded:
              final widgetList = snapshot.data;
              return Center(
                child: ListView(
                  children: widgetList! + [
                    Row(mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          label: const Text('Home'),
                        ),
                        FloatingActionButton.extended(
                          backgroundColor: Colors.grey,
                          onPressed: () {},
                          label: const Text('Merge'),
                        ),
                      ],
                    ),
                  ]
                ),
              );
            }
        },
      )
      );
    }
}

