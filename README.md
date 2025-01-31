# User Management iOS App

A simple iOS application that displays user information fetched from the JSONPlaceholder API. The app is built using Swift and follows the MVVM (Model-View-ViewModel) architecture pattern.

## Features

- Fetches user data from JSONPlaceholder API
- Displays user information in a table view
- Built with programmatic UI (no storyboards)
- Implements MVVM architecture
- Uses protocols for dependency injection
- Custom UITableViewCell for user display
- When selected show UserDetailViewController

## Architecture

The project follows the MVVM (Model-View-ViewModel) architecture pattern:

- **Model**: Represents the data structure 
- **View**: Contains the UI elements 
- **ViewModel**: Handles the business logic and data manipulation 

## Networking

The app uses `URLSession` for network requests through the `UserWebService` class, which conforms to the `UserWebServiceProtocol`. This allows for easy testing and dependency injection.

## UI Implementation

The UI is built programmatically using Auto Layout constraints. A custom extension on `UIView` provides convenient methods for setting up constraints.

## Author

Turker Alan

## Acknowledgments

- [JSONPlaceholder](https://jsonplaceholder.typicode.com/) for providing the API
- Swift and UIKit documentation

## Requirements

- iOS 14.0+
- Xcode 14.0+
- Swift 5.0+
