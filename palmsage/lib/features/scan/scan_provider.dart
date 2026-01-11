import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScanState {
  final bool isHandDetected;
  final bool isProcessing;

  ScanState({this.isHandDetected = false, this.isProcessing = false});

  ScanState copyWith({bool? isHandDetected, bool? isProcessing}) {
    return ScanState(
      isHandDetected: isHandDetected ?? this.isHandDetected,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

class ScanNotifier extends Notifier<ScanState> {
  @override
  ScanState build() {
    return ScanState();
  }

  void updateHandDetected(bool detected) {
    // Avoid unnecessary rebuilds
    if (state.isHandDetected != detected) {
      state = state.copyWith(isHandDetected: detected);
    }
  }

  void setProcessing(bool processing) {
    state = state.copyWith(isProcessing: processing);
  }
}

final scanStateProvider = NotifierProvider<ScanNotifier, ScanState>(ScanNotifier.new);
