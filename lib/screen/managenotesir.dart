import 'package:flutter/material.dart';
import 'package:notes/screen/color.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:notes/screen/global.dart';
import 'package:notes/screen/hiveManager.dart';
import 'package:notes/screen/notehive.dart';

class ManageSir extends StatefulWidget {
  late Note note;
  NOTES_MANAGE_MOD notes_manage_mod = NOTES_MANAGE_MOD.ADD;

  ManageSir({required this.note, required this.notes_manage_mod});

  @override
  State<ManageSir> createState() => _ManageSirState();
}

class _ManageSirState extends State<ManageSir> {
  TextEditingController textEditingController = TextEditingController();
  int SelectedColor = List_Colors[0];
  bool Remwanted = true;
  NepaliDateTime? _selectedDateTime = NepaliDateTime.now();

  @override
  void initState() {
    textEditingController.text = widget.note.notes;
    SelectedColor = widget.note.SelectedColor;
    _selectedDateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.note.notificationDate)
            .toNepaliDateTime();
    Remwanted = widget.note.Remwanted;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 2,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                        controller: textEditingController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(SelectedColor),
                          border: InputBorder.none,
                          hintText: 'Enter Your Notes',
                        )),
                    SizedBox(height: 20),
                    Text("Select Color.",
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        ...List_Colors.map(
                          (e) => InkWell(
                            onTap: () {
                              SelectedColor = e;
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.all(2),
                              height: 40,
                              width: 40,
                              child: SelectedColor == e
                                  ? Icon(Icons.check_box_rounded)
                                  : SizedBox.shrink(),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(e),
                                border: Border.all(color: Colors.grey.shade900),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    InkWell(
                      onTap: () {
                        Remwanted = !Remwanted;
                        setState(() {});
                      },
                      child: Row(
                        children: [
                          Remwanted
                              ? Icon(Icons.check_box)
                              : Icon(Icons.crop_square_sharp),
                          SizedBox(width: 10),
                          Text('Want Remainder?',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        _selectedDateTime = await showMaterialDatePicker(
                          context: context,
                          initialDate:
                              _selectedDateTime ?? NepaliDateTime.now(),
                          firstDate: NepaliDateTime(1970, 2, 5),
                          lastDate: NepaliDateTime(2099, 11, 6),
                          initialDatePickerMode: DatePickerMode.day,
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today_outlined),
                          SizedBox(width: 10),
                          Text('Pick Date',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          Expanded(child: SizedBox()),
                          ElevatedButton(
                              onPressed: () async {
                                // print(textEditingController.text);
                                // print(Remwanted);
                                // print(SelectedColor);
                                // print(_selectedDateTime!.millisecondsSinceEpoch);
                                if (widget.notes_manage_mod ==
                                    NOTES_MANAGE_MOD.ADD) {
                                  await HiveManager.onAddNotes(
                                      notes: textEditingController.text,
                                      SelectedColor: SelectedColor,
                                      notification: Remwanted,
                                      date: _selectedDateTime!
                                          .millisecondsSinceEpoch);
                                } else {
                                  widget.note.Remwanted = Remwanted;
                                  widget.note.notificationDate =
                                      _selectedDateTime!.millisecondsSinceEpoch;
                                  widget.note.SelectedColor = SelectedColor;
                                  HiveManager.onUpdateNotes(widget.note);
                                }
                                Navigator.of(context).pop();
                              },
                              child: Text("Add Note"))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
