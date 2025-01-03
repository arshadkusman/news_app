# Flutter News App with Clean Architecture, BLoC, and SQLite

This is a Flutter-based news app built using **Clean Architecture**, **BLoC (Business Logic Component)** for state management, and **Floor** as a lightweight SQLite database for local data storage.

## Features:
- **Clean Architecture**: A well-structured project that separates concerns into layers, ensuring maintainability, scalability, and testability.
- **BLoC**: The app uses the BLoC pattern for managing the state and handling business logic in a scalable way.
- **Floor SQLite Database**: Persistent data storage using the Floor SQLite database for offline support, allowing users to access news articles even without an internet connection.
- **News Fetching**: Retrieves news from an external API, displaying articles with rich information like title, description, and image.
- **Offline Mode**: News articles are stored locally and can be viewed offline.
- **Responsive UI**: The app provides a responsive user interface, optimized for both mobile and tablet devices.

## Technologies Used:
- **Flutter**: Cross-platform mobile development framework.
- **Clean Architecture**: Layered architecture that separates data, domain, and presentation logic.
- **BLoC**: State management solution to handle complex states.
- **Floor**: An abstraction over SQLite for persistent local data storage.
- **HTTP**: Fetching news data from external APIs.

## Setup:
1. Clone the repository.
2. Run `flutter pub get` to install the dependencies.
3. Run the app on your emulator or physical device using `flutter run`.

## Contributing:
Feel free to fork the repository, raise issues, and submit pull requests. Contributions are welcome!
