# Holics - Complete Flutter Application

A production-ready Flutter mobile and web application for a dual-service lifestyle platform with two sub-brands: **Body Holics** (gym subscriptions & fitness) and **Skin Holics** (skincare appointments & beauty treatments).

## Features

### User Roles
- **Member**: Regular users who can subscribe, book appointments, and access content
- **Admin**: Management dashboard with full CRUD operations
- **Guest**: View-only access (extensible)

### Core Features
- 🔐 **Firebase Authentication** - Email/password sign-in with secure auth management
- 📱 **Responsive Design** - Mobile-first design with web optimization
- 💳 **Stripe Payments** - Subscription payments and plan management
- 📅 **Appointment Booking** - 4-step booking flow with date/time/specialist selection
- 💪 **Fitness Plans** - Subscription tiers with workout tracking
- 💅 **Beauty Services** - Skincare appointments with specialist selection
- 📊 **Admin Dashboard** - Comprehensive management interface
- 🔔 **Push Notifications** - Firebase Cloud Messaging integration
- 🎨 **Dark Theme** - Modern dark UI with brand-specific color schemes

## Tech Stack

### Framework & State Management
- **Flutter** (latest stable, null-safe)
- **Riverpod** for reactive state management
- **GoRouter** for navigation with deep linking

### Backend
- **Firebase Auth** - Authentication
- **Cloud Firestore** - Database
- **Firebase Storage** - File storage
- **Firebase Cloud Messaging** - Push notifications
- **Firebase Cloud Functions** - Scheduled tasks (notifications, reminders)

### UI & Design
- **Google Fonts** - Typography (Inter font family)
- **Shimmer** - Loading skeletons
- **FL Chart** - Data visualization
- **Cached Network Image** - Image caching
- **Lottie** - Animations

### Payments
- **Flutter Stripe** - Payment processing

### Utilities
- **Flutter Dotenv** - Environment configuration
- **Intl** - Localization support

## Project Structure

```
lib/
├── core/
│   ├── theme/              # App theme and design system
│   ├── constants/          # Constants and strings
│   ├── utils/              # Utility functions
│   ├── router/             # Navigation configuration
│   └── config/             # App configuration
├── features/
│   ├── auth/               # Authentication (login, signup, password reset)
│   ├── home/               # Home screen & dashboard
│   ├── body_holics/        # Body Holics (gym & fitness)
│   ├── skin_holics/        # Skin Holics (beauty & skincare)
│   ├── admin/              # Admin dashboard
│   └── profile/            # User profile
├── shared/
│   ├── models/             # Data models
│   ├── providers/          # Riverpod providers
│   ├── services/           # Firebase & utility services
│   └── widgets/            # Reusable components
└── main.dart               # App entry point
```

## Setup Instructions

### 1. Prerequisites
- Flutter SDK (latest stable)
- Dart SDK
- Firebase account (create at https://firebase.google.com)
- Stripe account (for payments - https://stripe.com)
- IDE: VSCode with Flutter extension or Android Studio

### 2. Flutter Setup
```bash
# Verify Flutter installation
flutter doctor

# Get dependencies
cd <project-root>
flutter pub get

# If issues with dependencies
flutter clean
flutter pub get
```

### 3. Firebase Configuration

#### 3.1 Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click "Create a new project"
3. Name it "Holics" (or your preferred name)
4. Enable Google Analytics (optional)
5. Create project

#### 3.2 Add Firebase to Flutter App

**For Android:**
1. In Firebase Console, go to Project Settings
2. Click "Add App" → Select Android
3. Enter package name: `com.example.the_holics`
4. Register the app
5. Download `google-services.json`
6. Place it in: `android/app/`

**For iOS:**
1. Click "Add App" → Select iOS
2. Enter bundle ID: `com.example.theHolics`
3. Register the app
4. Download `GoogleService-Info.plist`
5. Place it in: `ios/Runner/`
6. Add to Xcode: Right-click Runner → Add Files → Select the plist file

**For Web:**
1. Click "Add App" → Select Web
2. Register web app
3. Copy the Firebase config
4. Add to your web/index.html or environment configuration

#### 3.3 Enable Firebase Services

In Firebase Console, go to Build and enable:

1. **Authentication**
   - Go to Authentication → Sign-in method
   - Enable "Email/Password"

2. **Firestore Database**
   - Go to Firestore Database
   - Create database in test mode (development)
   - Select region (us-central1 recommended)

3. **Storage**
   - Go to Storage
   - Create bucket with default location

4. **Cloud Messaging**
   - Go to Cloud Messaging
   - Note the Sender ID (used in app)

#### 3.4 Set Firestore Security Rules

```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Users can read/write their own document
    match /users/{uid} {
      allow read, write: if request.auth.uid == uid;
      allow read: if request.auth.token.admin == true;
    }
    
    // Admins only
    match /subscriptions/{uid} {
      allow read, write: if request.auth.uid == uid;
      allow read: if request.auth.token.admin == true;
    }
    
    match /appointments/{document=**} {
      allow read, write: if request.auth != null;
      allow read: if request.auth.token.admin == true;
    }
    
    // Public collections
    match /body_holics/{document=**} {
      allow read: if request.auth != null;
      allow write: if request.auth.token.admin == true;
    }
    
    match /skin_holics/{document=**} {
      allow read: if request.auth != null;
      allow write: if request.auth.token.admin == true;
    }
  }
}
```

### 4. Stripe Configuration

1. Create Stripe account at [stripe.com](https://stripe.com)
2. Get your API keys from Stripe Dashboard
3. Update `.env` file:
   ```
   STRIPE_PUBLISHABLE_KEY=pk_test_YOUR_KEY
   STRIPE_SECRET_KEY=sk_test_YOUR_KEY
   ```

### 5. Environment Setup

1. Update `.env` file in project root:
```env
FIREBASE_API_KEY=YOUR_FIREBASE_API_KEY
FIREBASE_APP_ID=YOUR_FIREBASE_APP_ID
FIREBASE_MESSAGING_SENDER_ID=YOUR_SENDER_ID
FIREBASE_PROJECT_ID=the-holics
STRIPE_PUBLISHABLE_KEY=pk_test_YOUR_KEY
STRIPE_SECRET_KEY=sk_test_YOUR_KEY
APP_NAME=Holics
ENVIRONMENT=development
```

### 6. Initialize Sample Data (Optional)

Create sample data in Firestore:

**Users Collection:**
```json
{
  "users/{uid}": {
    "name": "Test User",
    "email": "test@example.com",
    "role": "member",
    "createdAt": "2026-03-18T00:00:00Z",
    "isActive": true
  }
}
```

**Body Holics Workouts:**
```json
{
  "body_holics/workouts/items/{id}": {
    "title": "Chest & Triceps",
    "durationMin": 45,
    "difficulty": "Intermediate",
    "isLocked": false,
    "requiredPlan": "monthly"
  }
}
```

**Skin Holics Services:**
```json
{
  "skin_holics/services/items/{id}": {
    "name": "Hydration Facial",
    "durationMin": 60,
    "price": 89,
    "badge": "popular",
    "isActive": true
  }
}
```

**Specialists:**
```json
{
  "skin_holics/specialists/items/{id}": {
    "name": "Dr. Layla Hassan",
    "title": "Lead Specialist",
    "specialty": "Anti-Aging & Hydration",
    "isAvailable": true
  }
}
```

## Running the Application

### Development Mode
```bash
# Run on Android
flutter run -d android

# Run on iOS
flutter run -d ios

# Run on Web (requires web support enabled)
flutter run -d chrome

# Run on specific device
flutter run -d <device_id>
```

### Web Deployment
```bash
# Build web release
flutter build web --release

# Output: build/web/
```

### Android Build
```bash
# Build APK
flutter build apk --release

# Build App Bundle (for Play Store)
flutter build appbundle --release
```

### iOS Build
```bash
# Build iOS app
flutter build ios --release

# Create IPA for testing
cd ios
xcodebuild -workspace Runner.xcworkspace -scheme Runner -configuration Release -derivedDataPath build -archivePath build/Runner.xcarchive -archive
xcodebuild -exportArchive -archivePath build/Runner.xcarchive -exportOptionsPlist ExportOptions.plist -exportPath build
```

## Key Screens & Features

### Authentication
- **Login Screen** - Email/password sign-in with role selection
- **Signup Screen** - New user registration with validation
- **Password Reset** - Firebase password recovery flow

### Home Screen
- Greeting with user name
- Quick navigation to Body/Skin Holics
- Upcoming appointments preview
- Bottom tab navigation (mobile)

### Body Holics
- Subscription plan selection (Monthly, Quarterly, Yearly)
- Workout library with lock states based on plan
- Nutrition plans preview

### Skin Holics
- **4-Step Booking Flow:**
  1. Service selection
  2. Date & time selection with calendar
  3. Specialist chooser with availability
  4. Booking review & confirmation
- Real-time appointment tracking

### Admin Dashboard
- Overview statistics (members, subscriptions, appointments)
- Member management table
- Subscription tracking
- Appointment administration
- Workout/Service/Specialist CRUD
- Settings management

### Profile
- User info & avatar
- Current subscription status
- Upcoming appointments
- Change password & logout

## Design System

### Colors
**Body Holics:**
- Primary: #FF6B00 (Orange)
- Background gradient: #1A0A00 → #0D0D0D

**Skin Holics:**
- Primary: #E91E8C (Hot Pink)
- Background gradient: #1A0020 → #0D0D0D

**Shared:**
- Background: #0D0D0D
- Surface: #1A1A1A
- Border: #2A2A2A
- Text Primary: #FFFFFF
- Text Secondary: #888888

### Typography
- Font Family: Inter (Google Fonts)
- Heading: Bold 24-28px
- Body: Regular 14px
- Small: Regular 12px

### Components
- Button border radius: 50px (pill shape)
- Card border radius: 12px
- Input field radius: 12px

## Troubleshooting

### Common Issues

**Firebase Initialization Error**
- Ensure `.env` file has correct Firebase credentials
- Verify Firebase project ID
- Check `google-services.json` and `GoogleService-Info.plist` are in correct locations

**Stripe Not Working**
- Verify publishable key is correct
- Check Stripe account is not in test mode restrictions
- Ensure payment methods are configured in Stripe Dashboard

**Permissions Issues (Android)**
- Run `flutter clean && flutter pub get`
- Invalidate Android Studio caches
- Rebuild Gradle: `cd android && ./gradlew clean`

**iOS Build Issues**
- Run `pod install` in `ios/` directory
- Clean derived data: `xcode-select --reset`
- Update CocoaPods: `pod repo update`

## API & Service Documentation

### AuthService
Handles Firebase authentication operations including sign-up, sign-in, password reset, and profile updates.

### FirestoreService
Manages all Firestore CRUD operations for users, subscriptions, appointments, workouts, services, and specialists.

### StorageService
Handles Firebase Storage operations for profile images, workout videos, and specialist photos.

### FCMService
Manages Firebase Cloud Messaging for push notifications.

## Security Best Practices

1. **Firebase Rules** - Strictly enforce role-based access
2. **.env Protection** - Never commit `.env` to version control
3. **Stripe Keys** - Use publishable key on client, secret key on backend only
4. **Token Management** - Handle Firebase tokens securely
5. **Data Validation** - Validate all user input before submission

## Performance Optimization

- Image caching with CachedNetworkImage
- Shimmer loaders for perceived performance
- Lazy loading for lists
- Firestore offline persistence enabled
- Code splitting for web

## Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Generate coverage report
flutter test --coverage
```

## Deployment Checklist

- [ ] Update app version in `pubspec.yaml`
- [ ] Update `.env` with production credentials
- [ ] Review Firestore security rules
- [ ] Enable app signing for Android
- [ ] Configure code signing for iOS
- [ ] Test on multiple devices
- [ ] Review analytics & tracking
- [ ] Set up error reporting (Sentry/Firebase Crashlytics)
- [ ] Create user documentation
- [ ] Deploy to app stores

## Support & Contributing

For issues, feature requests, or contributions, please create an issue or pull request in your project repository.

## License

This project is proprietary and confidential. All rights reserved © 2026.

## Contact

For support, contact: support@holics.app

---

**Last Updated:** March 18, 2026
**Flutter Version:** 3.7.0+
**Dart Version:** 3.0.0+
