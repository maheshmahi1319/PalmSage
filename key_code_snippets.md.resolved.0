# Key Code Snippets

## 1. Camera Scanner with ML Kit (Riverpod + CameraController)

This snippet demonstrates initializing the camera and streaming images to ML Kit for hand detection.

```dart
import 'package:camera/camera.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PalmScanner extends ConsumerStatefulWidget {
  @override
  _PalmScannerState createState() => _PalmScannerState();
}

class _PalmScannerState extends ConsumerState<PalmScanner> {
  CameraController? _controller;
  bool _isProcessing = false;
  final PoseDetector _poseDetector = PoseDetector(options: PoseDetectorOptions());

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller!.initialize();
    _controller!.startImageStream(_processImage);
    setState(() {});
  }

  Future<void> _processImage(CameraImage image) async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      final inputImage = _inputImageFromCameraImage(image);
      final poses = await _poseDetector.processImage(inputImage);
      
      if (poses.isNotEmpty) {
        // Check if palm is open and facing camera
        // Logic to validate hand position
        ref.read(scanStateProvider.notifier).updateHandDetected(true);
      }
    } catch (e) {
      print('Error processing image: $e');
    } finally {
      _isProcessing = false;
    }
  }
  
  // Wrapper helper _inputImageFromCameraImage would go here...

  @override
  void dispose() {
    _controller?.dispose();
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return CameraPreview(_controller!);
  }
}
```

## 2. Line Extraction Logic (Conceptual OpenCV Integration)

This outlines how we process the image to find lines. We'd likely use `opencv_dart` for this.

```dart
import 'package:opencv_dart/opencv_dart.dart' as cv;

class LineExtractionService {
  
  Map<String, dynamic> extractPalmLines(String imagePath) {
    // 1. Load Image
    final img = cv.imread(imagePath, cv.IMREAD_COLOR);
    
    // 2. Pre-processing
    // Convert to grayscale
    var gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY);
    
    // Apply Gaussian Blur to reduce noise
    gray = cv.gaussianBlur(gray, (5, 5), 0);
    
    // 3. Edge Detection (Canny)
    // Adjust thresholds for skin/palm contrast
    final edges = cv.canny(gray, 50, 150);
    
    // 4. Morphological operations to close gaps in lines
    final kernel = cv.getStructuringElement(cv.MORPH_RECT, (3, 3));
    final closedEdges = cv.morphologyEx(edges, cv.MORPH_CLOSE, kernel);

    // 5. Line Detection (HoughBodies or probabilistic Hough)
    // Using a simplified heuristic for this snippet
    // In production, we'd use ROI (Region of Interest) based on ML Kit landmarks
    // to search for specific lines (Life, Head, Heart) in their expected zones.
    
    return {
      'life_line': _analyzeROI(closedEdges, 'life_line_zone'),
      'heart_line': _analyzeROI(closedEdges, 'heart_line_zone'),
      'head_line': _analyzeROI(closedEdges, 'head_line_zone'),
    };
  }

  Map<String, dynamic> _analyzeROI(cv.Mat edgeImage, String zone) {
    // Placeholder logic: measure pixel intensity/continuity in the zone
    // Return length, curvature, and depth metrics
    return {
      'is_present': true,
      'length': 'long', 
      'quality': 'deep'
    };
  }
}
```

## 3. LLM Prompt Template

The prompt sent to the LLM API.

```text
SYSTEM_PROMPT:
You are an expert Vedic Palmistry reader with deep knowledge of Samudrika Shastra. 
Your goal is to provide insightful, positive, and culturally sensitive palm readings.
Use the JSON data provided to interpret the user's character and future.
Do not be fatalistic; offer advice and empowering interpretations.

USER_PROMPT:
Analyze the palmistry data for a {age} year old {gender} born on {birth_date}.

Palm Data:
{
  "lines": {
    "life_line": { "length": "{life_line_length}", "quality": "{life_line_quality}" },
    "heart_line": { "end_point": "{heart_line_end}", "branches": "{heart_line_branches}" },
    "head_line": { "slope": "{head_line_slope}", "origin": "{head_line_origin}" }
  },
  "mounts": { "jupiter": "{mount_jupiter_status}" }
}

Task:
Generate a {reading_length} word reading in markdown format. 
Structure the response with these headers:
1. **Dominant Personality Traits** (Based on Head Line & Mounts)
2. **Emotional & Relationship Outlook** (Based on Heart Line)
3. **Vitality & Career Potential** (Based on Life & Fate Lines)
4. **Special Advice** (Synthesis of all signs)

Keep the tone mystical yet grounded. 
```
