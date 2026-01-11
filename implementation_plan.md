# PalmSage Implementation Plan

## Goal Description
Design and outline "PalmSage", an AI-powered palmistry app for Android and iOS using Flutter. The app will use computer vision to scan palms and an LLM to generate personalized readings.

## User Review Required
- **Privacy Policy**: Handling of user palm images (GDPR compliance).
- **Monetization**: Confirmation of Stripe/Razorpay integration details.
- **LLM Choice**: specific model preference (Grok vs GPT-4o-mini) cost/performance trade-off.

## Proposed Changes & Architecture

### Architecture
- **Frontend**: Flutter (Mobile).
- **Backend / API Layer**: Cloud Functions (Firebase) or Supabase Edge Functions.
- **ML/CV**: 
    - On-device: Google ML Kit (Hand detection).
    - Image Processing: OpenCV (Dart FFI or platform channels) for line extraction.
- **AI/LLM**: External API (OpenAI/Anthropic) proxied via backend.
- **Database**: 
    - Supabase (PostgreSQL) for user data, scan history, and cached readings.
    - Local Storage (Isar/Hive) for offline caching.

### Key Components to Implement
1. **Camera Scanner**: Custom Flutter widget using `camera` and `google_mlkit_pose_detection`.
2. **Line Extraction Service**: Dart service handling image processing.
3. **Palmistry Service**: Service to format prompts and call LLM API.
4. **UI Screens**: 
    - `OnboardingScreen`
    - `ScanScreen`
    - `ResultsScreen`
    - `HistoryScreen`
    - `ProfileScreen`

## Verification Plan
### Manual Verification
- **Architecture Review**: User validates the high-level diagram.
- **Code Review**: Verify key snippets for correctness (Flutter widgets, API calls).
- **Design Review**: Wireframes meet UX goals.

