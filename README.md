# Task Track - Flutter Firebase Todo App

Task Track is a Flutter-based Android todo application that allows users to easily create, manage, and track their tasks with real-time synchronization using Firebase.

## Features

- Task creation and editing
- Categorization of tasks (Newly Added, Ongoing, Completed)
- Task priority setting
- Custom icons for tasks
- User profile management
- Real-time data synchronization with Firebase integration

## Screenshots


![welcomee](https://github.com/user-attachments/assets/780ef39e-75a9-4638-83ca-64183c249a99)
![loginn](https://github.com/user-attachments/assets/2bc72885-d724-4386-a9d7-dfb46498827b)
![register](https://github.com/user-attachments/assets/ea8f16e5-6067-4c9b-bad6-6fe6b8a64f53)
![homee](https://github.com/user-attachments/assets/bfae5133-37f3-4088-bc25-cf2f1d69031f)
![list](https://github.com/user-attachments/assets/2332b026-bd6d-43cb-9cd3-43ffd40f8878)
![listt](https://github.com/user-attachments/assets/730e43a8-eb9a-4968-85d7-fb424d5a3a2d)
![finis](https://github.com/user-attachments/assets/00c670c4-f579-468b-9a12-31a6f172ca3f)
![detail](https://github.com/user-attachments/assets/61bb787f-2e6a-4c79-84f0-aa371fc4739f)
![edit](https://github.com/user-attachments/assets/31d3057d-9671-434b-89a3-4b4ca502be2c)
![new](https://github.com/user-attachments/assets/4c983629-d588-4202-9f47-c107df6f12c7)
![profile](https://github.com/user-attachments/assets/49a03b5c-9887-4595-b2dd-268b6ea391db)
![name](https://github.com/user-attachments/assets/bc0e04f1-9651-4402-9c95-eefcba8f8910)



## Dependencies

Key packages used in the project:

- State Management: flutter_hooks, flutter_riverpod, hooks_riverpod
- Navigation: auto_route
- UI/UX: animated_bottom_navigation_bar, lottie, fluttertoast, flutter_rating_bar, flutter_slidable
- Firebase: firebase_core, cloud_firestore, firebase_auth, google_sign_in, firebase_messaging
- Others: equatable, intl, flutter_local_notifications, shared_preferences

For a complete list, please refer to the `pubspec.yaml` file.

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/mustafanarin/Task-Track.git
   ```
2. Navigate to the project directory:
   ```
   cd Task-Track
   ```
3. Install dependencies:
   ```
   flutter pub get
   ```
4. Run the app:
   ```
   flutter run
   ```


## Firebase Setup

1. Create a new Firebase project in the [Firebase Console](https://console.firebase.google.com/).
2. Add an Android app to your Firebase project and follow the setup instructions.
3. Download the `google-services.json` file and place it in the `android/app` directory of your Flutter project.
4. Enable Authentication, Firestore, and Cloud Messaging in your Firebase project.
