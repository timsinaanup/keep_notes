import 'package:flutter/material.dart';
import 'package:nepali_utils/src/nepali_date_time.dart';
import 'package:notes/screen/global.dart';
import 'package:notes/screen/managenotesir.dart';

import 'screen/notehive.dart';

class Notes extends StatelessWidget {
  Note note;
  Notes(this.note);

  getIconByTime(int noteDate, BuildContext context) {
    int todayDate = DateTime.now().millisecondsSinceEpoch;
    if (todayDate > noteDate) {
      return Icon(
        Icons.check_circle_outline,
        color: Colors.green,
      );
    } else {
      return InkWell(
          onTap: () => {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ManageSir(
                        note: note,
                        notes_manage_mod: NOTES_MANAGE_MOD.EDIT,
                      );
                    })
              },
          child: Icon(Icons.edit));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(note.SelectedColor),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.notes,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.alarm_add_outlined,
                      color: Colors.green,
                    ),
                    Text(
                      DateTime.fromMillisecondsSinceEpoch(note.notificationDate)
                          .toNepaliDateTime()
                          .toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.grey),
                    ),
                  ],
                )
              ],
            )),
            getIconByTime(note.notificationDate, context),
          ],
        ));
  }
}
