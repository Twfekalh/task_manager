# Task Manager App

##Overview

This is a Task Manager application built using Flutter, designed to help users manage their tasks efficiently. The app incorporates modern design principles and technologies to ensure a seamless user experience with robust functionality.

##Key Features

- **User Authentication**: Secure login functionality using the [DummyJSON API](https://dummyjson.com/docs/auth).
- **Task Management**: Users can view, add, edit, and delete tasks with seamless API integration.
- **Pagination**: Efficient handling of large data sets using API pagination.
- **Local Storage**: Persistent data storage using `SharedPreferences` to retain user tasks even when offline.
- **State Management**: Implemented with `Bloc` for a centralized and scalable approach to managing application state.
- **Navigation**: Managed using `go_router` for declarative and dynamic navigation.
- **Offline Support**: Integration of `network_info` to handle connectivity issues gracefully.



## Design Decisions

### **1. Clean Architecture**
- Adopted **Clean Architecture** to separate concerns and ensure modularity.
- Divided the app into **Data**, **Domain**, and **Presentation** layers:
 - **Data Layer**: Responsible for remote and local data operations (e.g., API calls, shared preferences).
 - **Domain Layer**: Contains core business logic and use cases.
 - **Presentation Layer**: Manages the UI and Bloc for state management.

### **2. Block for State Management**
- Choose `Bloc` to handle state transitions efficiently, ensuring a reactive and predictable UI.
-Advantages:
 - Centralized state handling.
 - Clear separation between events, state, and business logic.

### **3. go_router for Navigation**
- Used `go_router` for its dynamic routing capabilities and declarative structure.
- Benefits:
 - Simplifies navigation logic.
 - Supports deep linking and path parameters easily.

### **4. Local Storage with SharedPreferences**
- Utilized `SharedPreferences` for lightweight and quick storage of user tasks locally.
- Ensures persistence of user data even after app closure.

### **5. Reusability and Scalability**
- Designed reusable components and widgets for commonly used functionalities.
- Avoided redundancy by implementing scalable patterns (e.g., generic Bloc templates, shared utilities).

### **6. Network Handling**
- Integrated `network_info` to check for internet connectivity before making API requests.
- Gracefully handles offline scenarios with appropriate error messages.


## Challenges Faced and Solutions

### **1. State Management Complexity**
- Challenge: Managing state transitions for multiple features like task CRUD operations and pagination.
- Solution: Centralized state management using `Bloc`, consistent state updates across the app.

### **2. Offline and Online Synchronization**
- Challenge: Ensuring smooth transitions between offline and online modes.
- Solution: Combined `SharedPreferences` for local storage with `network_info` to manage connectivity.

### **3. Modular Design**
- Challenge: Maintaining clean architecture while integrating multiple features.
- Solution: Followed strict separation of concerns and leveraged Clean Architecture principles to organize code effectively.



##Additional Features

- **Error Handling**: Implemented detailed error handling for network and API failures.
- **Reusable Components**: Created generic components for lists, forms, and error messages.
- **Scalability**: Designed the app to accommodate future features easily.


## How to Run the Project

1. Clone the repository:

 git clone https://github.com/Twfekalh/task_manager