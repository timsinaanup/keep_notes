import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/screen/notehive.dart';

const NOTES = '_notes';

class HiveManager {
  static initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteAdapter());
    return true;
  }

  static onAddNotes(
      {required String notes,
      required int SelectedColor,
      required bool notification,
      required int date}) async {
    try {
      await Hive.openBox<Note>(NOTES);
      Box<Note> addNote = Hive.box<Note>(NOTES);
      await addNote.add(Note(notes, notification, SelectedColor, date));
    } catch (e) {
      print(e);
    } finally {
      Hive.close();
      print("Adding Succeed");
      return true;
    }
  }

  static onUpdateNotes(Note note) async {
    try {
      Box noteBox = await Hive.openBox(NOTES);
      final modelExists = noteBox.containsKey(note.key);
      if (modelExists) {
        note.save();
      }
    } catch (e) {
      print(e);
    } finally {
      return true;
    }
  }

  static onGetNotes() async {
    try {
      final box = await Hive.openBox<Note>(NOTES);
      List note = <Note>[];
      note = box.values.toList();
      return note;
    } catch (e) {
      print(e);
    } finally {
      Hive.close();
    }
  }
}
