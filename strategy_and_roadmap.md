# Strategic Planning & Roadmap

## Monetization Plan (Freemium Model)

### Free Tier ("Seeker")
- **Features**: 
    - Basic Palm Scan (Major lines only).
    - Daily Horoscope (General).
    - 1 Standard Reading per week.
- **Ads**: Non-intrusive banner ads in Results/History.

### Premium Tier ("Sage") - $4.99/mo or $29.99/yr
- **Features**:
    - **Detailed Reports**: Full 300+ word deep-dive readings via LLM.
    - **Unlimited Scans**: Analyze friends and family.
    - **Time Travel**: Compare current scans with past ones.
    - **Ad-Free Experience**.
    - **PDF Exports**: High-res shareable visuals.
- **Payment Gateways**:
    - **Stripe**: Global payments.
    - **Razorpay**: Specific optimization for Indian market (UPI support).

## Privacy & GDPR Compliance

1. **Consent First**:
    - Explicit opt-in required to *store* palm images.
    - Default: Images processed in RAM only and discarded after feature extraction.
2. **Data Minimization**:
    - Send only *anonymized* features (line lengths, etc.) to LLM, not the image itself.
3. **Right to Forget**:
    - "Delete My Data" button in Settings wipes all DB records (PostgreSQL & Storage) immediately.
4. **Encryption**:
    - Images stored in Supabase Storage with Row Level Security (RLS).
    - Metadata encrypted at rest.

## Development Roadmap (4-Week MVP)

### Week 1: Foundation & Camera
- **Goal**: Reliable hand detection and image capture.
- **Tasks**:
    - Setup Flutter project structure + Firebase/Supabase implementation.
    - Implement `CameraPreview` with ML Kit Hand Detection.
    - Build "Hand Guide" overlay UI.
    - *Milestone*: App opens, detects hand, captures image.

### Week 2: Computer Vision & Analysis
- **Goal**: Extract meaningful data from palm images.
- **Tasks**:
    - Integrate `opencv_dart`.
    - Implement basic image pre-processing (Grayscale -> Canny Edge).
    - Build algorithm to identify Life, Heart, and Head lines constraints.
    - *Milestone*: JSON output of palm features generated from scan.

### Week 3: LLM Integration & Backend
- **Goal**: Generate readings from data.
- **Tasks**:
    - Setup backend Edge Function to proxy LLM API keys.
    - Write & Test prompt engineering with various palm data inputs.
    - Connect Flutter frontend to Backend API.
    - *Milestone*: User sees text reading after scan.

### Week 4: UI Polish & Monetization
- **Goal**: Production-ready UX.
- **Tasks**:
    - Build Home, History, and Profile screens.
    - Integrate Stripe/Razorpay SDKs.
    - Add "Premium Lock" logic to UI.
    - Final bug fixes & Release build.
    - *Milestone*: MVP Ready for TestFlight/Play Console.
