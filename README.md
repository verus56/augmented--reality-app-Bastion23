
# Bastion23 Augmented Reality App

## Introduction
Welcome to Bastion23, the cutting-edge augmented reality application that seamlessly integrates the virtual and physical worlds. Built on Flutter and Firebase, Bastion23 delivers an unparalleled AR experience, enabling users to interact with digital elements overlaid onto their real-world surroundings. From educational tools to entertainment and social interaction, Bastion23 is designed to captivate, engage, and amaze.



## Features
Bastion23 boasts a myriad of features that make the AR experience intuitive and fascinating:

- **Firebase Authentication**: Robust user authentication ensures secure access and a personalized experience.
- **Camera Integration**: Utilizes the device's camera to bring AR objects to life in the user's environment.
- **Responsive UI**: Meticulously designed user interface that adapts fluidly to different screen sizes and orientations.
- **Dynamic Content**: Users can explore a variety of AR content that is both informative and entertaining.
- **State Management**: Implements GetX for efficient state management, ensuring a smooth and responsive user journey.
- **Social Sharing**: Integration with social media platforms allows users to share their AR experiences with ease.
- **Offline Accessibility**: Certain features are available offline, providing continuous user engagement without constant internet access.

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running Tests](#running-tests)
- [Usage Guide](#usage-guide)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Getting Started

### Prerequisites
Before diving into the world of Bastion23, make sure you have the following set up:

- Flutter (version X.X.X or higher recommended)
- Dart (version X.X.X or higher recommended)
- Android Studio or Visual Studio Code with Flutter and Dart plugins
- A Firebase account with a project set up for Android/iOS

### Installation
To install Bastion23 on your local development machine, follow these instructions:

```bash
# Clone the Bastion23 repository from GitHub
git clone https://github.com/yourusername/bastion23.git

# Change directory into the cloned repository
cd bastion23

# Fetch and install all necessary dependencies
flutter pub get

# Run the app on a connected emulator or physical device
flutter run
```

### Running Tests
Bastion23 maintains a high standard of quality through extensive testing:

```bash
# Execute the automated test suite
flutter test
```

## Usage Guide
After installation, explore various features of Bastion23:

- Authentication: Securely log in to access and personalize your AR experience.
- Home Page: Discover a curated selection of AR experiences tailored to your interests.
- AR Viewer: Engage with interactive AR content using your device's camera.
- Favorites: Keep track of your preferred AR scenes and revisit them anytime.
- Profile Management: Update your user profile and customize your app settings.

## Project Structure
```text
 ├── assets
 |   ├── Model
 |    
 ├── lib
     ├── Post                  
     |   ├── camera   
     |   ├── post
     |
     ├── models                  
     ├── screens                 # User Interfaces
     ├── services                
     |   ├── auth.dart           # Firebase Authenticattion Service
     |   |── database.dart       # Firebase Cloud Firestore Service
     |   |── storage.dart        # Firebase Storage Service
     |
     ├── Artscreens
     |   ├── Qrcode.dart           
     |   |── ArtHome.dart       
     |   |── ArtData.dart
     |   |── ArtHome.dart
     |   |── ArkCore.dart
     |
     ├── Controler
     |   |── navigation_controller.dart
     |   |── Post_controller.dart              
     ├── introduction_animation         
     └── main.dart            # User auth checker. 
```

## Project Details

### Home Screen
Welcoming interface introducing Palais des Rais.
Quick access to Explore, Scan, Favorites, and User Profile.

### Explore Screen
List of exhibits with filters for categories/themes.
Brief descriptions with an option for augmented reality exploration.

### Scan Screen
Camera interface for QR code scanning.
Real-time feedback and instructions.
Transition to AR mode for 3D models or additional information.

### Favorites Screen
Display saved photos and favorited exhibits.
Organize favorites into albums.
Quick access to share or download content.

### Profile Screen
User login and profile info.
History of visited exhibits or scanned objects.
Customize user preferences.

### Features

1. **Post Photo:**
   - Camera interface for photo capture.
   - Caption, filter, and geotag options.
   - Social sharing for various platforms.

2. **AR Exploration:**
   - Augmented reality for 3D exhibit exploration.
   - Interactive info overlays.
   - Switch between AR and regular views.

3. **QR Scan Result:**
   - Detailed exhibit info post QR scan.
   - Explore related content.
   - Navigate to exhibit location.

4. **Log In/Sign Up:**
   - User-friendly forms for Sign Up and Log In.
   - Password recovery and security features.
   - Third-party account login (Google, Facebook).

5. **Favorites Management:**
   - View, organize, and delete favorited content.
   - Create and manage custom collections.
   - Quick actions for sharing and downloading.

6. **Download Images:**
   - Gallery view of downloaded images.
   - Manage and delete downloaded content.
   - Share or set images as wallpaper.


## Screenshots

![Screen 1](https://github.com/verus56/augmented--reality-app-Bastion23/blob/Fin/screen/s.png)


![Screen 2](https://github.com/verus56/augmented--reality-app-Bastion23/blob/Fin/screen/s2.png)
![Screen 2](https://github.com/verus56/augmented--reality-app-Bastion23/blob/Fin/screen/s3.png)
![Screen 2](https://github.com/verus56/augmented--reality-app-Bastion23/blob/Fin/screen/s4.png)


<!-- Add more screenshots as needed -->


## Contributing
We welcome contributions from the community. If you wish to contribute to Bastion23, please review our [CONTRIBUTING.md](CONTRIBUTING.md) document for guidelines on how to proceed.

## License
Bastion23 is released under the MIT License. Please review our [LICENSE](LICENSE) file for more details.

## Contact
For any further queries or feedback, please contact us 
## enjoy
We hope you enjoy exploring and using Bastion23 as much as we enjoyed creating it!

© 2023 Bastion23 Team. All Rights Reserved.


