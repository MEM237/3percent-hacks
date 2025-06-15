import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService extends ChangeNotifier {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isInitialized = false;
  bool _isRecording = false;
  String? _errorMessage;
  int _currentCameraIndex = 0;

  CameraController? get controller => _controller;
  bool get isInitialized => _isInitialized;
  bool get isRecording => _isRecording;
  String? get errorMessage => _errorMessage;
  List<CameraDescription> get cameras => _cameras;
  int get currentCameraIndex => _currentCameraIndex;

  Future<bool> initialize() async {
    try {
      // Request camera permission
      final permission = await Permission.camera.request();
      if (!permission.isGranted) {
        _errorMessage = 'Camera permission denied';
        notifyListeners();
        return false;
      }

      // Get available cameras
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        _errorMessage = 'No cameras available';
        notifyListeners();
        return false;
      }

      // Initialize the first camera
      await _initializeCamera(_currentCameraIndex);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to initialize camera: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> _initializeCamera(int cameraIndex) async {
    if (_controller != null) {
      await _controller!.dispose();
    }

    _controller = CameraController(
      _cameras[cameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      _isInitialized = true;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to initialize camera: $e';
      _isInitialized = false;
      notifyListeners();
    }
  }

  Future<void> switchCamera() async {
    if (_cameras.length <= 1) return;

    _currentCameraIndex = (_currentCameraIndex + 1) % _cameras.length;
    await _initializeCamera(_currentCameraIndex);
  }

  Future<void> startRecording() async {
    if (!_isInitialized || _controller == null) return;

    try {
      await _controller!.startVideoRecording();
      _isRecording = true;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to start recording: $e';
      notifyListeners();
    }
  }

  Future<String?> stopRecording() async {
    if (!_isRecording || _controller == null) return null;

    try {
      final file = await _controller!.stopVideoRecording();
      _isRecording = false;
      notifyListeners();
      return file.path;
    } catch (e) {
      _errorMessage = 'Failed to stop recording: $e';
      notifyListeners();
      return null;
    }
  }

  Future<String?> takePicture() async {
    if (!_isInitialized || _controller == null) return null;

    try {
      final image = await _controller!.takePicture();
      return image.path;
    } catch (e) {
      _errorMessage = 'Failed to take picture: $e';
      notifyListeners();
      return null;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Widget buildCameraPreview() {
    if (!_isInitialized || _controller == null) {
      return Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: [
              Color(0xFF3A3A3A),
              Color(0xFF2A2A2A),
              Color(0xFF1A1A1A),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.camera_alt,
                size: 64,
                color: Color(0xFF8A8A8A),
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage ?? 'Initializing Camera...',
                style: const TextStyle(
                  color: Color(0xFF8A8A8A),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ClipOval(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: CameraPreview(_controller!),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}