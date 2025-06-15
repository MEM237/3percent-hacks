import 'package:flutter/material.dart';

enum ViewportType {
  camera,
  iconGenerator,
  empty,
  image,
  text,
}

class ViewportData {
  final String id;
  final ViewportType type;
  final String title;
  final Widget? content;
  final String? imagePath;
  final String? textContent;
  final IconData? iconData;
  final Color? backgroundColor;
  final DateTime createdAt;
  final bool isActive;

  ViewportData({
    required this.id,
    required this.type,
    required this.title,
    this.content,
    this.imagePath,
    this.textContent,
    this.iconData,
    this.backgroundColor,
    DateTime? createdAt,
    this.isActive = true,
  }) : createdAt = createdAt ?? DateTime.now();

  ViewportData copyWith({
    String? id,
    ViewportType? type,
    String? title,
    Widget? content,
    String? imagePath,
    String? textContent,
    IconData? iconData,
    Color? backgroundColor,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return ViewportData(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      content: content ?? this.content,
      imagePath: imagePath ?? this.imagePath,
      textContent: textContent ?? this.textContent,
      iconData: iconData ?? this.iconData,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'title': title,
      'imagePath': imagePath,
      'textContent': textContent,
      'iconData': iconData?.codePoint,
      'backgroundColor': backgroundColor?.value,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
    };
  }

  factory ViewportData.fromJson(Map<String, dynamic> json) {
    return ViewportData(
      id: json['id'],
      type: ViewportType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => ViewportType.empty,
      ),
      title: json['title'],
      imagePath: json['imagePath'],
      textContent: json['textContent'],
      iconData: json['iconData'] != null 
          ? IconData(json['iconData'], fontFamily: 'MaterialIcons')
          : null,
      backgroundColor: json['backgroundColor'] != null 
          ? Color(json['backgroundColor'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      isActive: json['isActive'] ?? true,
    );
  }

  @override
  String toString() {
    return 'ViewportData(id: $id, type: $type, title: $title, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ViewportData && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Default viewport data for initialization
class DefaultViewportData {
  static ViewportData get cameraViewport => ViewportData(
    id: 'camera_main',
    type: ViewportType.camera,
    title: 'Live Camera',
    backgroundColor: const Color(0xFF2A2A2A),
  );

  static ViewportData get iconGeneratorViewport => ViewportData(
    id: 'icon_generator',
    type: ViewportType.iconGenerator,
    title: 'Icon Generator',
    backgroundColor: const Color(0xFF3A3A3A),
  );

  static ViewportData get emptyViewport => ViewportData(
    id: 'empty_viewport',
    type: ViewportType.empty,
    title: 'Empty Viewport',
    backgroundColor: const Color(0xFF4A4A4A),
  );

  static List<ViewportData> get defaultSideViewports => [
    iconGeneratorViewport,
    emptyViewport,
  ];
}