# PalmSage Architecture & Schema Design

## High-Level Architecture Diagram

```mermaid
graph TD
    User([User]) -->|Opens App| FlutterApp[Flutter Mobile App]
    
    subgraph "Frontend (Flutter)"
        UI[UI Layer]
        StateMgt[State Management (Riverpod/Bloc)]
        CameraService[Camera Service]
        MLService[ML Service (Google ML Kit)]
        IPService[Image Processing Service (OpenCV)]
        
        UI --> StateMgt
        StateMgt --> CameraService
        StateMgt --> MLService
        StateMgt --> IPService
    end
    
    subgraph "Backend Services"
        Auth[Firebase Auth]
        DB[(Supabase PostgreSQL)]
        Storage[Supabase Storage]
        EdgeFunc[Supabase Edge Functions]
        
        FlutterApp -->|Auth| Auth
        FlutterApp -->|Data| DB
        FlutterApp -->|Images| Storage
        FlutterApp -->|API Calls| EdgeFunc
    end
    
    subgraph "AI & External"
        LLM[LLM API (OpenAI/Groq)]
        Payment[Stripe/Razorpay]
        
        EdgeFunc -->|Prompt| LLM
        FlutterApp -->|Checkout| Payment
    end
```

## Database Schema (Supabase/PostgreSQL)

### Tables

#### `users`
| Column | Type | Description |
|---|---|---|
| `id` | `uuid` | Primary Key, linked to Auth Auth |
| `email` | `text` | User email |
| `display_name` | `text` | User display name |
| `birth_date` | `date` | Optional, for horoscope |
| `gender` | `text` | Optional, for personalization |
| `is_premium` | `boolean` | Premium subscription status |
| `created_at` | `timestamptz` | Account creation time |

#### `scans`
| Column | Type | Description |
|---|---|---|
| `id` | `uuid` | Primary Key |
| `user_id` | `uuid` | Foreign Key -> users.id |
| `image_path` | `text` | Path to stored image (if consented) |
| `features_json` | `jsonb` | Extracted palm features (line lengths, curves) |
| `created_at` | `timestamptz` | Scan timestamp |
| `is_processed` | `boolean` | Analysis complete flag |

#### `readings`
| Column | Type | Description |
|---|---|---|
| `id` | `uuid` | Primary Key |
| `scan_id` | `uuid` | Foreign Key -> scans.id |
| `user_id` | `uuid` | Foreign Key -> users.id |
| `content` | `text` | Full LLM generated text |
| `category` | `text` | Type: 'General', 'Career', 'Love', 'Health' |
| `summary` | `text` | Short summary for list view |
| `created_at` | `timestamptz` | Creation time |

#### `daily_horoscopes`
| Column | Type | Description |
|---|---|---|
| `id` | `uuid` | Primary Key |
| `zodiac_sign` | `text` | Aries, Taurus, etc. |
| `date` | `date` | Date of horoscope |
| `content` | `text` | Horoscope text |

### JSON Structure for `features_json`
```json
{
  "hand_type": "fire/earth/air/water",
  "lines": {
    "life_line": {
      "length": "long",
      "curve": "deep",
      "breaks": 0,
       "is_present": true
    },
    "heart_line": {
      "length": "medium",
       "end_point": "index_finger",
       "branches": 2
    },
    "head_line": {
       "origin": "joined_with_life_line",
       "slope": "straight"
    }
  },
  "mounts": {
    "venus": "prominent",
    "jupiter": "flat"
  }
}
```
