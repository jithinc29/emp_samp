class TaskModel {
  String category;
  String name;

  TaskModel({required this.name, required this.category});
  factory TaskModel.fromjson(Map<String, dynamic> json) {
    return TaskModel(
        name: json["taskname"].toString(),
        category: json["taskcatgory"].toString());       
  }}