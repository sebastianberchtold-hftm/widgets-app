
# Blog App

This is a Flutter-based blog application that integrates with Firebase for authentication and Firestore for real-time data management. Users can log in, view a list of blogs, create new blogs, and like/unlike blogs. The app provides a seamless real-time experience with a clean UI and smooth animations.

## Features

- **Firebase Authentication**: Secure user login and signup.
- **Real-Time Blog List**: Automatically updates with new blogs, likes, and content changes.
- **Add New Blog**: Create new blogs with a title, content, and optional image upload.
- **Like/Unlike Blogs**: Users can like/unlike blogs with a simple tap on the heart icon.
- **Dark Mode**: Switch between light and dark mode using the toggle switch in the app's top-right corner.
- **Animations**: Blog items fade in as they load, providing a smooth user experience.

## Demo

Here’s a quick guide on how the app works:

1. **Authentication**: 
   - Users must log in or sign up to view and interact with the blogs.
2. **Real-Time Blog List**: 
   - See blogs added by other users or yourself in real time.
3. **Blog Details**: 
   - Click any blog to view its full details and like/unlike the post.
4. **Add Blog**: 
   - Create a new blog by clicking the "Add" button at the bottom of the screen.
5. **Dark Mode**: 
   - Switch between light and dark themes using the toggle button in the app bar.

## Getting Started

To get started with the project, follow these instructions.

### Prerequisites

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install) for your platform.
- **Firebase Account**: Set up a Firebase project to use Firebase services like Authentication and Firestore.

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/sebastianberchtold-hftm/widgets-app.git
   ```

2. **Set up Firebase:**

   - Go to the [Firebase Console](https://console.firebase.google.com/) and create a new Firebase project.
   - Enable **Firebase Authentication** (with email/password) and **Firestore Database**.
   - Download the `google-services.json` file and place it in the `android/app` directory.

3. **Install dependencies:**

   Run the following command to install the necessary Flutter dependencies:

   ```bash
   flutter pub get
   ```

4. **Run the app:**

   Connect your device or emulator and use the following command to run the app:

   ```bash
   flutter run
   ```

### Firebase Setup

Follow these steps to configure Firebase for your project:

1. **Create a Firebase project**:
   - Go to the Firebase Console and create a new project.
   
2. **Enable Firebase Authentication**:
   - Navigate to **Authentication** in Firebase and enable **Email/Password** sign-in method.

3. **Enable Firestore**:
   - Go to **Firestore Database** in the Firebase console and create a new database in test mode.

4. **Add `google-services.json`**:
   - Download the `google-services.json` file from Firebase and place it in the `android/app` folder of your Flutter project.

### Usage

After running the app, you will be prompted to either log in or sign up. Once authenticated, you will have access to the blog list where you can view, add, and interact with blog posts.

### Folder Structure

```bash
lib/
│
├── features/
│   ├── auth/
│   │   └── page/
│   │       └── sign_in_page.dart        # Sign-in and sign-up UI
│   ├── blog/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── blog_model.dart      # Blog data model
│   │   │   └── repositories/
│   │   │       └── blog_repository.dart # Blog data handling with Firestore
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   └── add_blog_page.dart   # Add blog page UI
│   │   │   └── widgets/
│   │   │       └── slidable_blog_tile.dart # Blog tile with slide and like/unlike functionality
│   └── theme/
│       └── widgets/
│           └── toggle_theme.dart        # Dark/light theme toggle switch
│
├── main.dart                            # App entry point
```

## Dependencies

- **Flutter**: Framework for building the app.
- **Firebase Auth**: Manages user authentication.
- **Firebase Firestore**: Stores and retrieves blog data in real time.
- **firebase_storage**: Uploads blog images to Firebase.
- **flutter_slidable**: Enables swipe actions for blog items.
- **image_picker**: Allows users to pick images for blog posts.

## Future Improvements

- **Comments Feature**: Allow users to comment on blogs.
- **User Profiles**: Display user information along with their posted blogs.
- **Search Functionality**: Add the ability to search for specific blogs by title or content.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Author

- **Sebastian Berchtold**

Feel free to reach out for any questions or feedback!
