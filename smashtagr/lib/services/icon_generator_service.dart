import 'dart:math';
import 'package:flutter/material.dart';

class IconGeneratorService {
  static final Random _random = Random();
  
  // Categorized icon collections for better random generation
  static const Map<String, List<IconData>> _iconCategories = {
    'tech': [
      Icons.computer,
      Icons.smartphone,
      Icons.tablet,
      Icons.watch,
      Icons.headphones,
      Icons.camera,
      Icons.wifi,
      Icons.bluetooth,
      Icons.usb,
      Icons.memory,
      Icons.storage,
      Icons.router,
      Icons.developer_mode,
      Icons.code,
      Icons.terminal,
    ],
    'business': [
      Icons.business,
      Icons.work,
      Icons.attach_money,
      Icons.trending_up,
      Icons.bar_chart,
      Icons.pie_chart,
      Icons.analytics,
      Icons.account_balance,
      Icons.credit_card,
      Icons.receipt,
      Icons.shopping_bag,
      Icons.store,
      Icons.inventory,
      Icons.local_shipping,
      Icons.handshake,
    ],
    'communication': [
      Icons.message,
      Icons.chat,
      Icons.email,
      Icons.phone,
      Icons.video_call,
      Icons.forum,
      Icons.comment,
      Icons.announcement,
      Icons.campaign,
      Icons.share,
      Icons.send,
      Icons.call,
      Icons.contacts,
      Icons.group,
      Icons.person_add,
    ],
    'entertainment': [
      Icons.music_note,
      Icons.movie,
      Icons.games,
      Icons.sports_esports,
      Icons.theaters,
      Icons.library_music,
      Icons.play_circle,
      Icons.pause_circle,
      Icons.shuffle,
      Icons.repeat,
      Icons.volume_up,
      Icons.radio,
      Icons.tv,
      Icons.camera_roll,
      Icons.photo_library,
    ],
    'utilities': [
      Icons.settings,
      Icons.lock,
      Icons.security,
      Icons.vpn_key,
      Icons.shield,
      Icons.backup,
      Icons.sync,
      Icons.update,
      Icons.refresh,
      Icons.power_settings_new,
      Icons.battery_full,
      Icons.signal_wifi_4_bar,
      Icons.network_check,
      Icons.data_usage,
      Icons.speed,
    ],
    'creative': [
      Icons.palette,
      Icons.brush,
      Icons.color_lens,
      Icons.draw,
      Icons.edit,
      Icons.create,
      Icons.design_services,
      Icons.auto_fix_high,
      Icons.tune,
      Icons.filter,
      Icons.gradient,
      Icons.texture,
      Icons.style,
      Icons.format_paint,
      Icons.colorize,
    ],
  };

  // Color palettes for generated icons
  static const List<Color> _iconColors = [
    Color(0xFF6F61EF), // Purple
    Color(0xFF39D2C0), // Teal
    Color(0xFFEE8B60), // Orange
    Color(0xFF4A90E2), // Blue
    Color(0xFF50E3C2), // Mint
    Color(0xFFF5A623), // Yellow
    Color(0xFFBD10E0), // Magenta
    Color(0xFF7ED321), // Green
    Color(0xFFD0021B), // Red
    Color(0xFF9013FE), // Deep Purple
    Color(0xFF00BCD4), // Cyan
    Color(0xFFFF9800), // Amber
  ];

  // Background colors for icon containers
  static const List<Color> _backgroundColors = [
    Color(0xFFE8E8E8),
    Color(0xFFD0D0D0),
    Color(0xFFB8B8B8),
    Color(0xFFA0A0A0),
    Color(0xFF8A8A8A),
  ];

  static IconData generateRandomIcon({String? category}) {
    if (category != null && _iconCategories.containsKey(category)) {
      final categoryIcons = _iconCategories[category]!;
      return categoryIcons[_random.nextInt(categoryIcons.length)];
    }
    
    // Generate from all categories
    final allIcons = _iconCategories.values.expand((icons) => icons).toList();
    return allIcons[_random.nextInt(allIcons.length)];
  }

  static Color generateRandomIconColor() {
    return _iconColors[_random.nextInt(_iconColors.length)];
  }

  static Color generateRandomBackgroundColor() {
    return _backgroundColors[_random.nextInt(_backgroundColors.length)];
  }

  static List<String> getAvailableCategories() {
    return _iconCategories.keys.toList();
  }

  static GeneratedIcon generateRandomIconWithDetails({String? category}) {
    return GeneratedIcon(
      icon: generateRandomIcon(category: category),
      color: generateRandomIconColor(),
      backgroundColor: generateRandomBackgroundColor(),
      category: category ?? _getRandomCategory(),
      timestamp: DateTime.now(),
    );
  }

  static String _getRandomCategory() {
    final categories = _iconCategories.keys.toList();
    return categories[_random.nextInt(categories.length)];
  }

  static List<GeneratedIcon> generateIconSet({int count = 6, String? category}) {
    return List.generate(
      count,
      (index) => generateRandomIconWithDetails(category: category),
    );
  }

  // Generate themed icon set based on color harmony
  static List<GeneratedIcon> generateThemedIconSet({
    int count = 6,
    String? category,
    Color? baseColor,
  }) {
    final Color primaryColor = baseColor ?? generateRandomIconColor();
    final List<Color> harmonicColors = _generateHarmonicColors(primaryColor);
    
    return List.generate(count, (index) {
      return GeneratedIcon(
        icon: generateRandomIcon(category: category),
        color: harmonicColors[index % harmonicColors.length],
        backgroundColor: generateRandomBackgroundColor(),
        category: category ?? _getRandomCategory(),
        timestamp: DateTime.now(),
      );
    });
  }

  static List<Color> _generateHarmonicColors(Color baseColor) {
    final HSVColor hsvBase = HSVColor.fromColor(baseColor);
    return [
      baseColor,
      hsvBase.withHue((hsvBase.hue + 60) % 360).toColor(),
      hsvBase.withHue((hsvBase.hue + 120) % 360).toColor(),
      hsvBase.withHue((hsvBase.hue + 180) % 360).toColor(),
      hsvBase.withHue((hsvBase.hue + 240) % 360).toColor(),
      hsvBase.withHue((hsvBase.hue + 300) % 360).toColor(),
    ];
  }
}

class GeneratedIcon {
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final String category;
  final DateTime timestamp;
  final String id;

  GeneratedIcon({
    required this.icon,
    required this.color,
    required this.backgroundColor,
    required this.category,
    required this.timestamp,
    String? id,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'iconCodePoint': icon.codePoint,
      'colorValue': color.value,
      'backgroundColorValue': backgroundColor.value,
      'category': category,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory GeneratedIcon.fromJson(Map<String, dynamic> json) {
    return GeneratedIcon(
      id: json['id'],
      icon: IconData(json['iconCodePoint'], fontFamily: 'MaterialIcons'),
      color: Color(json['colorValue']),
      backgroundColor: Color(json['backgroundColorValue']),
      category: json['category'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  @override
  String toString() {
    return 'GeneratedIcon(id: $id, category: $category, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GeneratedIcon && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}