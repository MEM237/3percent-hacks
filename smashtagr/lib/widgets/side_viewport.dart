import 'package:flutter/material.dart';
import '../utils/steel_gradients.dart';
import '../models/viewport_data.dart';
import '../services/icon_generator_service.dart';

class SideViewport extends StatefulWidget {
  final ViewportData viewportData;
  final double width;
  final double height;
  final VoidCallback? onTap;
  final Function(GeneratedIcon)? onIconGenerated;

  const SideViewport({
    super.key,
    required this.viewportData,
    this.width = 140.0,
    this.height = 140.0,
    this.onTap,
    this.onIconGenerated,
  });

  @override
  State<SideViewport> createState() => _SideViewportState();
}

class _SideViewportState extends State<SideViewport>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  GeneratedIcon? _currentGeneratedIcon;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.92,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _animationController.forward().then((_) {
      _animationController.reverse();
      
      if (widget.viewportData.type == ViewportType.iconGenerator) {
        _generateNewIcon();
      }
      
      widget.onTap?.call();
    });
  }

  void _generateNewIcon() {
    setState(() {
      _currentGeneratedIcon = IconGeneratorService.generateRandomIconWithDetails();
    });
    
    if (widget.onIconGenerated != null && _currentGeneratedIcon != null) {
      widget.onIconGenerated!(_currentGeneratedIcon!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: SteelGradients.getBrushedGradient(isDark),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(isDark ? 0.05 : 0.3),
                    blurRadius: 6,
                    offset: const Offset(-2, -2),
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [
                            const Color(0xFF1A1A1A),
                            const Color(0xFF2A2A2A),
                          ]
                        : [
                            const Color(0xFFF0F0F0),
                            const Color(0xFFE0E0E0),
                          ],
                  ),
                  border: Border.all(
                    color: isDark 
                        ? const Color(0xFF4A4A4A)
                        : const Color(0xFFB8B8B8),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: _buildViewportContent(context, isDark),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildViewportContent(BuildContext context, bool isDark) {
    switch (widget.viewportData.type) {
      case ViewportType.iconGenerator:
        return _buildIconGeneratorContent(context, isDark);
        
      case ViewportType.image:
        return _buildImageContent();
        
      case ViewportType.text:
        return _buildTextContent(context, isDark);
        
      default:
        return _buildEmptyContent(context, isDark);
    }
  }

  Widget _buildIconGeneratorContent(BuildContext context, bool isDark) {
    if (_currentGeneratedIcon != null) {
      return Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: [
              _currentGeneratedIcon!.backgroundColor.withOpacity(0.3),
              _currentGeneratedIcon!.backgroundColor.withOpacity(0.1),
              Colors.transparent,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentGeneratedIcon!.backgroundColor.withOpacity(0.2),
                border: Border.all(
                  color: _currentGeneratedIcon!.color.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                _currentGeneratedIcon!.icon,
                size: 32,
                color: _currentGeneratedIcon!.color,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _currentGeneratedIcon!.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _currentGeneratedIcon!.category.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: _currentGeneratedIcon!.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: [
            Color(0xFF4A4A4A),
            Color(0xFF3A3A3A),
            Color(0xFF2A2A2A),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.auto_fix_high,
                size: 28,
                color: Colors.amber.withOpacity(0.8),
              ),
              Positioned(
                top: -4,
                right: -4,
                child: Icon(
                  Icons.star,
                  size: 12,
                  color: Colors.amber.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Generate',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.amber.withOpacity(0.9),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'TAP',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 8,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageContent() {
    if (widget.viewportData.imagePath != null) {
      return Image.asset(
        widget.viewportData.imagePath!,
        fit: BoxFit.cover,
      );
    }
    return _buildEmptyContent(context, Theme.of(context).brightness == Brightness.dark);
  }

  Widget _buildTextContent(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Text(
          widget.viewportData.textContent ?? 'Empty',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isDark ? const Color(0xFFB8B8B8) : const Color(0xFF4A4A4A),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildEmptyContent(BuildContext context, bool isDark) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.crop_square,
            size: 24,
            color: isDark ? const Color(0xFF5A5A5A) : const Color(0xFF8A8A8A),
          ),
          const SizedBox(height: 6),
          Text(
            'Empty\nViewport',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isDark ? const Color(0xFF6A6A6A) : const Color(0xFF8A8A8A),
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}