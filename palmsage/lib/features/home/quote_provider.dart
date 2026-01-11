import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _quotes = [
  "The lines in your hand are a map of your soul's journey.",
  "Your fate is in your hands, but your destiny is in your choices.",
  "A clear mind reflects a clear path on the palm.",
  "The heart line reveals not just love, but how we connect with the world.",
  "Every line tells a story; listen closely to what your hand has to say.",
  "The mount of Jupiter speaks of ambition, but the thumb shows the will to achieve it.",
  "Healing begins when we understand the patterns written in our palms.",
  "Life is a mixture of destiny and free will.",
];

class QuoteNotifier extends Notifier<String> {
  Timer? _timer;
  int _currentIndex = 0;

  @override
  String build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    _startTimer();
    return _quotes[_currentIndex];
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _currentIndex = (_currentIndex + 1) % _quotes.length;
      state = _quotes[_currentIndex];
    });
  }
}

final quoteProvider = NotifierProvider<QuoteNotifier, String>(QuoteNotifier.new);
