// To parse this JSON data, do
//
//     final todoItem = todoItemFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

class TodoItem {
  TodoItem({
    this.id,
    this.title,
    this.detail,
    this.startAt,
    this.endAt,
    this.createAt,
    this.updateAt,
    this.completeAt,
    this.complete = 0,
  });

  final int id;
  final String title;
  final String detail;
  final int startAt;
  final int endAt;
  final int createAt;
  final int updateAt;
  final int completeAt;
  final int complete;

  TodoItem copyWith({
    int id,
    String title,
    String detail,
    int startAt,
    int endAt,
    int createAt,
    int updateAt,
    int completeAt,
    int complete,
  }) =>
      TodoItem(
        id: id ?? this.id,
        title: title ?? this.title,
        detail: detail ?? this.detail,
        startAt: startAt ?? this.startAt,
        endAt: endAt ?? this.endAt,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
        completeAt: completeAt ?? this.completeAt,
        complete: complete ?? this.complete,
      );

  factory TodoItem.fromRawJson(String str) =>
      TodoItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TodoItem.fromJson(Map<String, dynamic> json) => TodoItem(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        detail: json["detail"] == null ? null : json["detail"],
        startAt: json["startAt"] == null ? null : json["startAt"],
        endAt: json["endAt"] == null ? null : json["endAt"],
        createAt: json["createAt"] == null ? null : json["createAt"],
        updateAt: json["updateAt"] == null ? null : json["updateAt"],
        completeAt: json["completeAt"] == null ? null : json["completeAt"],
        complete: json["complete"] == null ? null : json["complete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "detail": detail == null ? null : detail,
        "startAt": startAt == null ? null : startAt,
        "endAt": endAt == null ? null : endAt,
        "createAt": createAt == null ? null : createAt,
        "updateAt": updateAt == null ? null : updateAt,
        "completeAt": completeAt == null ? null : completeAt,
        "complete": complete == null ? null : complete,
      };
}
