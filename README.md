# 📊 SurveyApp - Flutter Firebase Survey Application

A complete Flutter application for creating and managing surveys with real-time Firebase Firestore integration, offline persistence, and professional architecture.


<img width="240" height="520" alt="image" src="https://github.com/user-attachments/assets/a771c9b1-eb4f-425e-9b12-ee83a234e142" />


## 🚀 Features

- **3 Complete Screens**: Home, Survey Form, Confirmation
- **Firebase Firestore Integration**: Real-time data sync
- **Offline Persistence**: Works without internet connection
- **Professional Architecture**: UI → Provider → Repository → Firebase
- **Form Validation**: Comprehensive input validation
- **State Management**: Provider for efficient state handling
- **Reusable Widgets**: Modular and maintainable code structure

## 🏗️ Architecture

```
UI (Screens) → Provider (State) → Repository (Data) → Firebase (Cloud)
```

- **Separation of Concerns**: Each layer has specific responsibilities
- **Testable**: Easy to unit test each component
- **Scalable**: Easy to add new features and screens

## 📱 Screens

### Home Screen
- Displays available surveys from Firestore
- Real-time updates when new surveys are added
- Error handling and loading states

### Survey Screen
- Interactive form with validation
- Required fields: Name, Email, Rating
- Optional comments field
- Professional UI with error states

### Confirmation Screen
- Success message after submission
- Navigation back to home screen
- Summary of submitted answers

## 🔥 Firebase Integration

### Firestore Structure
```
surveys/ {surveyId}/
  ├── title: string
  ├── description: string
  └── responses/ {responseId}/
        ├── createdAt: timestamp
        └── answers: map
```

### Features
- **Repository Pattern**: No direct Firebase calls in UI
- **Offline Persistence**: Automatic data sync when connection restored
- **Real-time Updates**: Instant survey list updates

## 🛠️ Installation

### Prerequisites
- Flutter SDK 3.0+
- Firebase account
- Android/iOS device or emulator

### Setup Steps

1. **Clone the repository**
```bash
git clone https://github.com/alnazareth/survey-app-flutter.git
cd survey-app-flutter
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Firebase Configuration**
   - Create project in [Firebase Console](https://console.firebase.google.com)
   - Enable Firestore Database
   - Add Android app and download `google-services.json`
   - Place `google-services.json` in `android/app/`

4. **Run the application**
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── app/                 # App configuration
├── data/
│   ├── models/         # Data models (Survey, SurveyResponse)
│   └── repositories/   # Firebase data operations
├── providers/          # State management (SurveyProvider)
├── screens/            # App screens (3 total)
└── widgets/
    ├   # Reusable form components and  # Common widgets
            
```

## 🎯 Technical Implementation

### State Management
- **Provider**: Centralized state management
- **ChangeNotifier**: Efficient UI updates
- **Loading States**: Professional user feedback

### Form Handling
- **GlobalKey<FormState>**: Form validation
- **Custom Validators**: Email format, required fields
- **Real-time Validation**: Immediate user feedback

### Widget Architecture
- **Reusable Components**: Each form field is independent
- **Custom Form Fields**: Name, Email, Comments, Rating
- **Responsive Design**: Works on different screen sizes

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1      # State management
  firebase_core: ^2.24.0 # Firebase core
  cloud_firestore: ^4.13.0 # Firestore database
```

## 🔧 Development

### Key Features Implemented
- ✅ 3 separate screens with navigation
- ✅ Firebase Firestore integration
- ✅ Repository pattern implementation
- ✅ Form validation and error handling
- ✅ Offline persistence
- ✅ Professional architecture
- ✅ Reusable widgets
- ✅ State management with Provider


## 🚀 Getting Started for Developers

1. **Explore the architecture**: Start with `lib/main.dart` and follow the flow
2. **Understand data flow**: UI → Provider → Repository → Firebase
3. **Add new features**: Follow the existing patterns
4. **Testing**: Each component is independently testable

