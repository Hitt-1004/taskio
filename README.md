# taskio

## Overview

taskio is a task manager application built using Flutter, designed to help users keep track of their day-to-day tasks efficiently. With Taskio, users can seamlessly add, remove, or edit tasks, view tasks based on their status tags (Ongoing, Completed, Not Started), set deadlines, manage subtasks, and monitor progress. Additionally, Taskio includes a calendar functionality for scheduling tasks and viewing tasks due on specific dates. Users can securely log in and out, access their profile details, and experience smooth data persistence through Flutter's built-in shared preferences mechanism.

## Features

### Task Management
- **Add Tasks**: Users can add new tasks with a title, description, status tag, deadline, number of subtasks, and completion status.
- **Edit Tasks**: Task details can be modified, including the title, description, status tag, deadline, and subtask information.
- **Remove Tasks**: Users can delete tasks they no longer need.
- **Tagging**: Tasks can be categorized into tags such as Ongoing, Completed, or Not Started for easy organization and retrieval.
- **Subtasks**: Each task can have multiple subtasks, and completion of no. of subtasks can be tracked.

### Calendar Functionality
- **Date Selection**: Users can select specific dates on the calendar to view tasks scheduled or due on that date.
- **Task Scheduling**: Tasks with deadlines set to the present day, are automatically reflected on the calendar for easy visualization.

### Profile Management
- **Secure Authentication**: Users can securely log in and out of the application.
- **Profile Details**: Users have access to their profile information, (such as name and email).

### Task Details
- **Comprehensive View**: Users can view detailed information about each task, including its title, description, status, deadline, subtasks, and completion percentage.

## Data Persistence

taskio implements local data persistence using Flutter's built-in storage mechanism, shared preferences. This ensures that user data is securely stored on the device and can be accessed even when offline. Data persistence is crucial for maintaining task information across app sessions and device restarts.

## State Management

taskio efficiently manages app-wide state using the Provider state management solution. Two main providers are utilized:

- **AuthProvider**: Manages user authentication state, ensuring secure login and logout functionality.
- **TaskProvider**: Handles task-related state management, including adding, editing, removing, and retrieving tasks. This ensures smooth and responsive task management operations while considering performance and scalability.

## Conclusion

taskio offers a comprehensive task management solution for users to streamline their daily activities effectively. With features such as task tagging, subtask management, calendar integration, and secure authentication, Taskio empowers users to stay organized and productive. Powered by Flutter's data persistence and state management capabilities, Taskio delivers a seamless user experience for managing tasks on the go.


## Running the Application Locally

To run Taskio locally, follow these steps:

1. Clone the repository from GitHub:
git clone https://github.com/Hitt-1004/taskio.git
2. Navigate to the project directory:
cd taskio 
3. Ensure you have Flutter installed. If not, follow the [Flutter installation instructions](https://flutter.dev/docs/get-started/install).
4. run: flutter pub get (to get all the dependencies). 
5. Run the application on a connected device or emulator:
