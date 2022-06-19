import 'package:hive/hive.dart';
part 'notehive.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  Note(
    this.notes,
    this.Remwanted,
    this.SelectedColor,
    this.notificationDate,
  );

  @HiveField(0)
  late String notes;

  @HiveField(1)
  late bool Remwanted;

  @HiveField(2)
  late int SelectedColor;

  @HiveField(3)
  late int notificationDate;
}
// flutter 