# Flutter Lab Assignment 3

This Flutter application fetches and displays a list of albums and photos from the [JSONPlaceholder API](https://jsonplaceholder.typicode.com). The app demonstrates clean architecture using the MVVM pattern, Bloc state management, GoRouter for navigation, and proper error handling.

## 🚀 Features

- Fetch albums and photos from remote API
- Display albums in a scrollable list
- Navigate to a detail screen on item tap
- Show full album details including photo
- Loading and error states with retry option

## 🧱 Architecture

This app is structured using the MVVM (Model-View-ViewModel) architecture:

- **Model**: Defines the data structure for Album and Photo
- **View**: UI components built using Flutter widgets
- **ViewModel (Bloc)**: Handles logic, state management, and API calls

## 📦 Tech Stack

| Layer            | Technology                     |
|------------------|--------------------------------|
| UI               | Flutter Widgets                |
| Networking       | `http` package (httpClient)    |
| State Management | Bloc                           |
| Navigation       | GoRouter                       |
| Architecture     | MVVM                           |

## 🔗 API Endpoints

- Albums: [`https://jsonplaceholder.typicode.com/albums`](https://jsonplaceholder.typicode.com/albums)
- Photos: [`https://jsonplaceholder.typicode.com/photos`](https://jsonplaceholder.typicode.com/photos)

## 🧪 Error Handling

- Displays error messages when network fails
- Retry button allows users to re-fetch data

## 📂 Folder Structure

