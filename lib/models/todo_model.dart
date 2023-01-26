// To parse this JSON data, do
//
//     final todoModel = todoModelFromJson(jsonString);

import 'dart:convert';

List<TodoModel> todoModelFromJson(String str) => List<TodoModel>.from(json.decode(str).map((x) => TodoModel.fromJson(x)));

String todoModelToJson(List<TodoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoModel {
    TodoModel({
        this.id,
        this.title,
        this.completed,
        this.date,
    });

    final String? id;
    late final String? title;
    final bool? completed;
    final DateTime? date;

    factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json["_id"],
        title: json["title"],
        completed: json["completed"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "completed": completed,
        "date": date?.toIso8601String(),
    };
}
