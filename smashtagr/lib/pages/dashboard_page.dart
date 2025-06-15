import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/circular_viewer.dart';
import '../widgets/side_viewport.dart';
import '../widgets/steel_nav_bar.dart';
import '../services/camera_service.dart';
import '../services/icon_generator_service.dart';
import '../models/viewport_data.dart';
import '../utils/steel_gradients.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  late CameraService _cameraService;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  
  int _currentNavIndex = 0;
  ViewportData _centralViewportData = DefaultViewportData.cameraViewport;
  List<ViewportData> _sideViewportsData = DefaultViewportData.defaultSideViewports;
  List<GeneratedIcon> _generatedIcons = [];

  @override
  void initState() {
    super.initState();
    _cameraService = CameraService();
    _initializeCamera();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    
    _fadeController.forward();
  }

  @override
  void dispose() {
    _cameraService.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    await _cameraService.initialize();
  }

  void _handleNavTap(int index) {
    setState(() {
      _currentNavIndex = index;
      
      switch (index) {
        case 0: // Dashboard
          _centralViewportData = DefaultViewportData.cameraViewport;
          break;
        case 1: // Camera
          _centralViewportData = DefaultViewportData.cameraViewport;
          break;
        case 2: // Generator
          _centralViewportData = ViewportData(
            id: 'icon_generator_main',
            type: ViewportType.iconGenerator,
            title: 'Icon Generator',
            backgroundColor: const Color(0xFF3A3A3A),
          );
          break;
        case 3: // Settings
          _centralViewportData = ViewportData(
            id: 'settings_main',
            type: ViewportType.text,
            title: 'Settings',
            textContent: 'dApp Settings\n\nSteel Interface v1.0\nSolana Network Ready',
            backgroundColor: const Color(0xFF2A2A2A),
          );
          break;
      }
    });
  }

  void _handleCentralViewportTap() {
    if (_centralViewportData.type == ViewportType.iconGenerator) {
      _generateIconSet();
    }
  }

  void _generateIconSet() {
    final newIcons = IconGeneratorService.generateIconSet(count: 4);
    setState(() {
      _generatedIcons.addAll(newIcons);
      // Update side viewports with generated icons
      if (_generatedIcons.length >= 2) {
        _sideViewportsData = [
          ViewportData(
            id: 'generated_icon_1',
            type: ViewportType.iconGenerator,
            title: 'Generated Icon',
            backgroundColor: _generatedIcons[_generatedIcons.length - 2].backgroundColor,
          ),
          ViewportData(
            id: 'generated_icon_2',
            type: ViewportType.iconGenerator,
            title: 'Generated Icon',
            backgroundColor: _generatedIcons[_generatedIcons.length - 1].backgroundColor,
          ),
        ];
      }
    });
  }

  void _handleIconGenerated(GeneratedIcon icon) {
    setState(() {
      _generatedIcons.add(icon);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return ChangeNotifierProvider.value(
      value: _cameraService,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: isDark 
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF1A1A1A),
                      Color(0xFF0F0F0F),
                      Color(0xFF050505),
                    ],
                  )
                : const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFF5F5F5),
                      Color(0xFFE8E8E8),
                      Color(0xFFDDDDDD),
                    ],
                  ),
          ),
          child: SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  // Header
                  _buildHeader(context, isDark),
                  
                  // Main content area
                  Expanded(
                    child: _buildMainContent(context, isDark),
                  ),
                  
                  // Steel Navigation Bar
                  SteelNavBar(
                    items: SteelNavItems.defaultItems,
                    currentIndex: _currentNavIndex,
                    onTap: _handleNavTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SteelView',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: isDark ? Colors.white : const Color(0xFF1A1A1A),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                'dApp Interface',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark ? const Color(0xFF8A8A8A) : const Color(0xFF6A6A6A),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isDark 
                  ? SteelGradients.darkBeveledEdge 
                  : SteelGradients.beveledEdge,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.account_balance_wallet,
              size: 28,
              color: isDark ? Colors.white : const Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Central circular viewer and side viewports row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Central Circular Viewer
              CircularViewer(
                viewportData: _centralViewportData,
                cameraService: _cameraService,
                size: 280,
                onTap: _handleCentralViewportTap,
              ),
              
              const SizedBox(width: 24),
              
              // Side Viewports
              Column(
                children: [
                  SideViewport(
                    viewportData: _sideViewportsData[0],
                    width: 120,
                    height: 120,
                    onIconGenerated: _handleIconGenerated,
                  ),
                  const SizedBox(height: 16),
                  SideViewport(
                    viewportData: _sideViewportsData[1],
                    width: 120,
                    height: 120,
                    onIconGenerated: _handleIconGenerated,
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Status info
          _buildStatusInfo(context, isDark),
        ],
      ),
    );
  }

  Widget _buildStatusInfo(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: isDark 
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2A2A2A),
                  Color(0xFF1A1A1A),
                ],
              )
            : const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE8E8E8),
                  Color(0xFFD0D0D0),
                ],
              ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatusItem(
            context,
            isDark,
            Icons.camera_alt,
            'Camera',
            _cameraService.isInitialized ? 'Active' : 'Offline',
            _cameraService.isInitialized,
          ),
          _buildStatusItem(
            context,
            isDark,
            Icons.auto_fix_high,
            'Generator',
            '${_generatedIcons.length} Icons',
            _generatedIcons.isNotEmpty,
          ),
          _buildStatusItem(
            context,
            isDark,
            Icons.hub,
            'Network',
            'Solana Ready',
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(
    BuildContext context,
    bool isDark,
    IconData icon,
    String title,
    String status,
    bool isActive,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive 
                ? (isDark ? Colors.green.withOpacity(0.2) : Colors.green.withOpacity(0.1))
                : (isDark ? Colors.red.withOpacity(0.2) : Colors.red.withOpacity(0.1)),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isActive 
                ? (isDark ? Colors.green : Colors.green.shade700)
                : (isDark ? Colors.red : Colors.red.shade700),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: isDark ? Colors.white : const Color(0xFF1A1A1A),
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          status,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: isDark ? const Color(0xFF8A8A8A) : const Color(0xFF6A6A6A),
          ),
        ),
      ],
    );
  }
}