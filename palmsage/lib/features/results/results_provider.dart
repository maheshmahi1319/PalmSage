import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

class PalmReading {
  final String title;
  final String content;
  final String summary;
  final String category;
  final DateTime date;

  PalmReading({
    required this.title,
    required this.content,
    required this.summary,
    required this.category,
    required this.date,
  });
}

class PalmistryService {
  final _random = Random();

  Future<PalmReading> generateReading({required String category}) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 3));

    final readings = {
      'General': [
        PalmReading(
          title: 'The Path of Wisdom',
          content: 'Your life line shows a strong and vibrant energy. You are someone who values tradition but isn\'t afraid to forge your own path. The curve of your head line suggests a creative mind that finds solutions in unexpected places.',
          summary: 'A journey of balance and creativity awaits you.',
          category: 'General',
          date: DateTime.now(),
        ),
      ],
      'Love': [
        PalmReading(
          title: 'Heart\'s Reflection',
          content: 'The heart line in your palm is deep and clear, indicating a capacity for profound emotional connections. You seek depth in your relationships and offer unwavering loyalty once your trust is earned.',
          summary: 'Deep emotional fulfillment is on your horizon.',
          category: 'Love',
          date: DateTime.now(),
        ),
      ],
      'Career': [
        PalmReading(
          title: 'Ambition\'s Ascent',
          content: 'Your fate line is distinct and rises toward the finger of Saturn, suggesting a structured approach to your professional goals. Success will come through persistence and a disciplined mindset.',
          summary: 'Steady growth and professional recognition are indicated.',
          category: 'Career',
          date: DateTime.now(),
        ),
      ],
      'Health': [
        PalmReading(
          title: 'Vitality\'s Flow',
          content: 'The clarity of your palm skin suggests a sensitive constitution. It is important for you to maintain a balance between activity and rest. Listening to your body\'s subtle whispers will be your greatest asset.',
          summary: 'Focus on holistic well-being for optimal vitality.',
          category: 'Health',
          date: DateTime.now(),
        ),
      ],
    };

    final categoryReadings = readings[category] ?? readings['General']!;
    return categoryReadings[_random.nextInt(categoryReadings.length)];
  }
}

final palmistryServiceProvider = Provider((ref) => PalmistryService());

class ResultsState {
  final bool isLoading;
  final PalmReading? reading;
  final String? error;

  ResultsState({this.isLoading = false, this.reading, this.error});

  ResultsState copyWith({bool? isLoading, PalmReading? reading, String? error}) {
    return ResultsState(
      isLoading: isLoading ?? this.isLoading,
      reading: reading ?? this.reading,
      error: error ?? this.error,
    );
  }
}

class ResultsNotifier extends Notifier<ResultsState> {
  @override
  ResultsState build() {
    return ResultsState();
  }

  Future<void> fetchReading(String category) async {
    final service = ref.read(palmistryServiceProvider);
    state = state.copyWith(isLoading: true, error: null);
    try {
      final reading = await service.generateReading(category: category);
      state = state.copyWith(isLoading: false, reading: reading);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final resultsProvider = NotifierProvider<ResultsNotifier, ResultsState>(ResultsNotifier.new);


