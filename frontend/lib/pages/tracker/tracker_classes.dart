import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartify/pages/api_server/api_server.dart';

class Task {
  String title;
  String duration;
  DateTime? deadline;
  bool isCompleted;

  Task({
    required this.title,
    required this.duration,
    required this.deadline,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'duration': duration,
      'deadline': deadline?.toIso8601String(),
      'isCompleted': isCompleted
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    DateTime? dt;
    if (json['deadline'] != null) {
      if (json['deadline'] is DateTime) {
        dt = json['deadline'];
      } else if (json['deadline'] is String) {
        dt = DateTime.tryParse(json['deadline']);
      }
    }
    return Task(
      title: json['title'],
      duration: json['duration'],
      deadline: dt,
      isCompleted: json['isCompleted'] ?? false
    );
  }
}

class TaskCalendar {
  String title;
  String duration;
  Color color;
  String subjectTitle;
  bool isCompleted;

  TaskCalendar({
    required this.title,
    required this.duration,
    required this.color,
    required this.isCompleted,
    required this.subjectTitle
  });

  factory TaskCalendar.fromJson(Map<String, dynamic> jsonData) {
    return TaskCalendar(
      title: jsonData['title'],
      duration: jsonData['duration'],
      color: jsonData['color'],
      isCompleted: jsonData['completed'],
      subjectTitle: jsonData['subject']
    );
  }
}

class Subject {
  List<Task> tasks;
  String title;
  IconData icon;
  Color color;

  static const Map<int, IconData> iconMapping = {
    0xe000: Icons.book,      
    0xe001: Icons.school,     
    0xe002: Icons.work,
    0xe003: Icons.sports_soccer,
  };

  Subject({
    required this.title,
    this.icon = Icons.book,
    this.color = const Color.fromARGB(255, 0, 150, 136),
    this.tasks = const []
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': icon.codePoint, 
      'color': color.value,
      'tasks': tasks.map((task) => task.toJson()).toList()
    };
  }

  factory Subject.fromJson(Map<String, dynamic> json) {
    List<Task> loadTasks = [];
    List<dynamic>? jsonTasks = json['tasks'];
    if (jsonTasks != null) {
      for (var taskJson in json['tasks']) {
        loadTasks.add(Task.fromJson(taskJson));
      }
    }
    
    return Subject(
      title: json['title'] as String,
      icon: iconMapping[json['icon']] ?? Icons.book,
      color: Color(json['color']),
      tasks: loadTasks
    );
  }

  void addTasks(List<Task> newTasks) {
    tasks.addAll(newTasks);
  }
  void removeTasks(int index) {
    if (index < 0 || index >= tasks.length) {
      return;
    }
    tasks.removeAt(index);
  }
}

class SubjectsManager {
  static final SubjectsManager _instance = SubjectsManager._internal();
  factory SubjectsManager() => _instance;
  SubjectsManager._internal();
  List<Subject> subjects = [];

  Future<void> saveAll() async {
    final sharedPref = await SharedPreferences.getInstance();

    List<String> subjectsJson = [];
    for (var sub in subjects) {
      subjectsJson.add(jsonEncode(sub.toJson()));
    }

    await sharedPref.setString("subjects", jsonEncode({
      "data": subjectsJson
    }));
    ApiService.SaveTrackers(this);
    // потом можно будет добавить проверку на то, что записались данные или нет
    // и в зависимости от этого отображать раззные данные
  }

  Future<void> updateFromJSON(List<String> subjectsJson) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString("subjects", jsonEncode({
      "data": subjectsJson
    }));
    ApiService.SaveTrackers(this);
    // потом можно будет добавить проверку на то, что записались данные или нет
    // и в зависимости от этого отображать раззные данные
  }

  List<String> getJSON() {
    List<String> subjectsJson = [];
    for (var sub in subjects) {
      subjectsJson.add(jsonEncode(sub.toJson()));
    }
    return subjectsJson;
  }

  Future<void> loadAll() async {
    final trackers = await ApiService.GetTrackers(this);
    if (trackers != null) {
      await updateFromJSON(trackers);
    }
    final sharedPref = await SharedPreferences.getInstance();
    String? data = sharedPref.getString("subjects");
    if (data == null) {
      return;
    }
    final decoded = jsonDecode(data);
    final List<dynamic> subjectsJson = decoded['data'];
    subjects.clear();
    for (var sub in subjectsJson) {
      final Map<String, dynamic> subJson = jsonDecode(sub);
      subjects.add(Subject.fromJson(subJson));
    }
  }

  void addSubject(Subject subject) {
    subjects.add(subject);
  }
  void removeSubject(int index) {
    if (index < 0 || index >= subjects.length) {
      return;
    }
    subjects.removeAt(index);
  }
}