import 'package:flutter/material.dart';
import '../utils/steel_gradients.dart';

class SteelNavBar extends StatefulWidget {
  final List<SteelNavItem> items;
  final int currentIndex;
  final Function(int) onTap;
  final double height;

  const SteelNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.height = 64.0,
  });

  @override
  State<SteelNavBar> createState() => _SteelNavBarState();
}

class _SteelNavBarState extends State<SteelNavBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _scaleAnimations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.items.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 150),
        vsync: this,
      ),
    );

    _scaleAnimations = _controllers
        .map((controller) => Tween<double>(
              begin: 1.0,
              end: 0.85,
            ).animate(CurvedAnimation(
              parent: controller,
              curve: Curves.easeInOut,
            )))
        .toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleTap(int index) {
    _controllers[index].forward().then((_) {
      _controllers[index].reverse();
      widget.onTap(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: widget.height,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: isDark 
            ? SteelGradients.darkNavBarSteel 
            : SteelGradients.navBarSteel,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(isDark ? 0.1 : 0.4),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    const Color(0xFF2A2A2A),
                    const Color(0xFF1A1A1A),
                  ]
                : [
                    const Color(0xFFE8E8E8),
                    const Color(0xFFD0D0D0),
                  ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.items.length, (index) {
            return Expanded(
              child: AnimatedBuilder(
                animation: _scaleAnimations[index],
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimations[index].value,
                    child: _buildNavItem(
                      context,
                      widget.items[index],
                      index,
                      isDark,
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    SteelNavItem item,
    int index,
    bool isDark,
  ) {
    final isSelected = widget.currentIndex == index;
    
    return GestureDetector(
      onTap: () => _handleTap(index),
      child: Container(
        height: double.infinity,
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: isDark 
                    ? SteelGradients.darkBeveledEdge 
                    : SteelGradients.beveledEdge,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? (isDark ? const Color(0xFF4A4A4A) : const Color(0xFFB8B8B8))
                    : Colors.transparent,
              ),
              child: Icon(
                item.icon,
                size: 24,
                color: isSelected
                    ? (isDark ? Colors.white : const Color(0xFF1A1A1A))
                    : (isDark ? const Color(0xFF8A8A8A) : const Color(0xFF6A6A6A)),
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: isSelected
                    ? (isDark ? Colors.white : const Color(0xFF1A1A1A))
                    : (isDark ? const Color(0xFF8A8A8A) : const Color(0xFF6A6A6A)),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 11,
              ),
              child: Text(
                item.label,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SteelNavItem {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const SteelNavItem({
    required this.icon,
    required this.label,
    this.onTap,
  });
}

// Predefined nav items for common dApp functions
class SteelNavItems {
  static const SteelNavItem dashboard = SteelNavItem(
    icon: Icons.dashboard,
    label: 'Dashboard',
  );

  static const SteelNavItem camera = SteelNavItem(
    icon: Icons.camera_alt,
    label: 'Camera',
  );

  static const SteelNavItem generator = SteelNavItem(
    icon: Icons.auto_fix_high,
    label: 'Generate',
  );

  static const SteelNavItem settings = SteelNavItem(
    icon: Icons.settings,
    label: 'Settings',
  );

  static const SteelNavItem wallet = SteelNavItem(
    icon: Icons.account_balance_wallet,
    label: 'Wallet',
  );

  static const SteelNavItem network = SteelNavItem(
    icon: Icons.hub,
    label: 'Network',
  );

  static List<SteelNavItem> get defaultItems => [
    dashboard,
    camera,
    generator,
    settings,
  ];
}