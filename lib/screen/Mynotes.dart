import 'package:flutter/material.dart';
import 'package:notes/screen/color.dart';
import 'package:notes/screen/global.dart';
import 'package:notes/screen/hiveManager.dart';
import 'package:notes/screen/managenotes.dart';
import 'package:notes/screen/managenotesir.dart';
import 'package:notes/screen/notehive.dart';

import '../notes.dart';

class Mynotes extends StatefulWidget {
  const Mynotes({Key? key}) : super(key: key);

  @override
  State<Mynotes> createState() => _MynotesState();
}

class _MynotesState extends State<Mynotes> {
  List notes = <Note>[];

  getNotes() async {
    notes = await HiveManager.onGetNotes();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My notes"),
      ),
      floatingActionButton: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.amber,
          child: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return ManageSir(
                      notes_manage_mod: NOTES_MANAGE_MOD.ADD,
                      note: new Note('', true, List_Colors[0],
                          DateTime.now().millisecondsSinceEpoch),
                    );
                  }).then((value) => getNotes());
            },
          )),
      body: ListView(
        children: [...notes.map((e) => Notes(e))],
      ),
    );
  }
}
