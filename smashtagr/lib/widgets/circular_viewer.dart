import 'package:flutter/material.dart';
import '../utils/steel_gradients.dart';
import '../models/viewport_data.dart';
import '../services/camera_service.dart';

class CircularViewer extends StatefulWidget {
  final ViewportData viewportData;
  final CameraService? cameraService;
  final double size;
  final VoidCallback? onTap;

  const CircularViewer({
    super.key,
    required this.viewportData,
    this.cameraService,
    this.size = 280.0,
    this.onTap,
  });

  @override
  State<CircularViewer> createState() => _CircularViewerState();
}

class _CircularViewerState extends State<CircularViewer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
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

  void _handleTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
    widget.onTap?.call();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SteelGradients.getCircularGradient(isDark),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(isDark ? 0.1 : 0.5),
                      blurRadius: 8,
                      offset: const Offset(-4, -4),
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.9,
                      colors: isDark
                          ? [
                              const Color(0xFF1A1A1A),
                              const Color(0xFF2A2A2A),
                              const Color(0xFF3A3A3A),
                            ]
                          : [
                              const Color(0xFFF0F0F0),
                              const Color(0xFFE0E0E0),
                              const Color(0xFFD0D0D0),
                            ],
                    ),
                    border: Border.all(
                      color: isDark 
                          ? const Color(0xFF5A5A5A)
                          : const Color(0xFFB8B8B8),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: _buildViewportContent(context, isDark),
                  ),
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
      case ViewportType.camera:
        return _buildCameraContent(isDark);
      
      case ViewportType.image:
        return _buildImageContent();
      
      case ViewportType.text:
        return _buildTextContent(isDark);
      
      case ViewportType.iconGenerator:
        return _buildIconGeneratorContent(isDark);
      
      default:
        return _buildEmptyContent(isDark);
    }
  }

  Widget _buildCameraContent(bool isDark) {
    if (widget.cameraService != null && widget.cameraService!.isInitialized) {
      return widget.cameraService!.buildCameraPreview();
    }
    
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: [
            const Color(0xFF3A3A3A),
            const Color(0xFF2A2A2A),
            const Color(0xFF1A1A1A),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt,
            size: 64,
            color: isDark ? const Color(0xFF8A8A8A) : const Color(0xFF6A6A6A),
          ),
          const SizedBox(height: 16),
          Text(
            'Camera\nOffline',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isDark ? const Color(0xFF8A8A8A) : const Color(0xFF6A6A6A),
            ),
            textAlign: TextAlign.center,
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
    return _buildEmptyContent(Theme.of(context).brightness == Brightness.dark);
  }

  Widget _buildTextContent(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.viewportData.textContent ?? 'No Content',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isDark ? const Color(0xFFE8E8E8) : const Color(0xFF1A1A1A),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildIconGeneratorContent(bool isDark) {
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
                size: 48,
                color: Colors.amber.withOpacity(0.8),
              ),
              Positioned(
                top: -8,
                right: -8,
                child: Icon(
                  Icons.star,
                  size: 24,
                  color: Colors.amber.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Icon\nGenerator',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.amber.withOpacity(0.9),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'TAP TO GENERATE',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyContent(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: isDark
              ? [
                  const Color(0xFF2A2A2A),
                  const Color(0xFF1A1A1A),
                  const Color(0xFF0A0A0A),
                ]
              : [
                  const Color(0xFFE8E8E8),
                  const Color(0xFFD0D0D0),
                  const Color(0xFFB8B8B8),
                ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.view_in_ar,
              size: 48,
              color: isDark ? const Color(0xFF5A5A5A) : const Color(0xFF8A8A8A),
            ),
            const SizedBox(height: 12),
            Text(
              widget.viewportData.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isDark ? const Color(0xFF8A8A8A) : const Color(0xFF5A5A5A),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}