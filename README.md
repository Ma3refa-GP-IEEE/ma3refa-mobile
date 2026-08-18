# 📱 Ma3refa Mobile

> The official Flutter mobile application for **Ma3refa**, developed under **Ma3refa-GP-IEEE** as part of a IEEE graduation project.

---

## 📖 Project Overview

**Ma3refa Mobile** is a Flutter-based mobile application developed as part of a student graduation project under **Ma3refa-GP-IEEE**.

The application provides an interactive quiz-based learning experience where users can explore categories and subcategories, configure quizzes according to their preferences, take quizzes, review their answers, and access their previous quiz history.

The application is organized using a **Feature-Based Architecture**, with shared functionality centralized inside a `core` layer and application-specific modules organized under `features`.

The mobile application was independently designed and developed by **Mahmoud Addelghani** within a focused **10-day development period**.

---

## ✨ Features

### 🔐 Authentication

Handles the application's authentication flows, including user login, registration, and related authentication functionality.

### 🏠 Home

The main application hub where users can browse available learning categories.

Users can select a category to explore its available subcategories and continue toward selecting a quiz.

Provides personalized recommendations tailored to user interests and identified areas for improvement.

### 📚 Categories & Subcategories

Users can:

* Browse available categories.
* Open a category to view its subcategories.
* Select a subcategory to explore the available quizzes.

### 🧠 Quiz Setup

Before starting a quiz, users can configure their quiz according to their preferences:

* Select the quiz difficulty.
* Choose the number of questions from **5 to 20**.
* Choose between a timed or untimed quiz.
* For timed quizzes, select a duration from **1 to 60 minutes**.

### ⏱️ Timed Quiz

In a timed quiz:

* Questions are loaded before the quiz starts.
* The user can navigate and scroll between questions freely.
* The user can complete the quiz within the selected time limit.
* At the end of the quiz, the user can review the complete set of answers.
* Correct and incorrect answers are displayed for review.

### 📝 Untimed Quiz

In an untimed quiz:

* The correct answer is displayed immediately after the user selects an answer.
* Once an answer is selected, it cannot be changed.
* The user cannot return to previous questions.
* The quiz continues until all questions are completed.

### 📊 Quiz Results & Review

After completing a quiz, the user receives a results summary containing:

* Overall quiz score.
* Number of correct answers.
* Number of incorrect answers.
* Review of the quiz questions.
* Explanations for the questions and answers.

After reviewing the result, the user can return to the Home screen.

### 👤 Profile & Quiz History

Through the application's navigation drawer, users can access their profile.

The profile area provides access to quiz history, where users can view:

* Previously completed quiz attempts.
* The subcategories they were tested on.
* Quiz attempts associated with each subcategory.
* The time and related information for previous quiz attempts.

---

## 🔄 App Flow

The main application flow can be summarized as follows:

```text
App Launch
    ↓
Authentication
    ↓
Home
    ↓
Select Category
    ↓
Select Subcategory
    ↓
Select Quiz
    ↓
Quiz Setup
    ├── Difficulty
    ├── Number of Questions (5–20)
    └── Quiz Mode
          ├── Timed (1–60 minutes)
          └── Untimed
    ↓
Quiz Onboarding
    ↓
Fetch Quiz
    ↓
Get Started
    ↓
Take Quiz
    │
    ├── Timed Quiz
    │      ├── Navigate between questions freely
    │      └── Review answers at the end
    │
    └── Untimed Quiz
           ├── Answer is evaluated immediately
           ├── Answer cannot be changed
           └── Cannot return to previous questions
    ↓
Quiz Results
    ↓
Score & Answer Review
    ↓
Question Explanations
    ↓
Return to Home
```

### Profile & History Flow

```text
Navigation Drawer
    ↓
Profile
    ↓
Quiz History
    ↓
Select Subcategory
    ↓
View Previous Quiz Attempts
    ↓
View Quiz Details / Time Information
```

---

## 🎯 How to Use

### 1. Launch the Application

Open the Ma3refa Mobile application.

### 2. Authenticate

Log in or register to access the application's main experience.

### 3. Explore Categories

From the Home screen, browse the available learning categories.

### 4. Select a Subcategory

Open a category and select the subcategory related to the topic you want to study.

### 5. Select a Quiz

Choose the quiz you want to take.

### 6. Configure the Quiz

Before starting, configure the quiz:

* Select the difficulty.
* Select the number of questions from **5 to 20**.
* Choose whether the quiz is timed or untimed.
* For timed quizzes, select a duration from **1 to 60 minutes**.

### 7. Start the Quiz

The application loads the selected quiz and displays the quiz onboarding screen.

Press **Get Started** to begin.

### 8. Complete the Quiz

Depending on the selected mode:

**Timed Quiz**

* Navigate between questions freely.
* Complete the quiz within the selected time limit.
* Review your answers after finishing.

**Untimed Quiz**

* Select an answer for each question.
* The correct answer is shown immediately.
* Answers cannot be changed.
* You cannot return to previous questions.

### 9. Review Your Results

After completing the quiz, view:

* Your score.
* Correct answers.
* Incorrect answers.
* Question review.
* Explanations.

### 10. View Quiz History

Open the navigation drawer and go to your profile.

From the quiz history, you can review previous attempts and explore the quizzes associated with different subcategories.

---

## 🎨 UI/UX Design

The application's UI/UX was independently designed by **Mahmoud Addelghani** using **Stitch / Figma**.

The design was created specifically for Ma3refa with a focus on providing a clean, interactive, and consistent learning experience.

### 🔗 Figma Design

[View the Ma3refa UI/UX Design on Figma](https://www.figma.com/design/RQMM7TM7Z1GR6xG66L0DQ4/Ma3refa-UI?node-id=0-1&t=U5SARSAF51JAVhOV-0)

---

## 🛠 Tech Stack

### Core Technologies

* **Flutter** — Cross-platform mobile application framework
* **Dart** — Programming language
* **Flutter BLoC / Cubit** — State management
* **Dio** — Networking and HTTP communication
* **GetIt** — Dependency injection / service location
* **Flutter Secure Storage** — Secure local storage
* **Shared Preferences** — Local persistence

### Supporting Packages

* **Dartz** — Functional programming utilities
* **Easy Localization** — Localization support
* **Flutter ScreenUtil** — Responsive UI scaling
* **Cached Network Image** — Efficient network image loading
* **Flutter SVG** — SVG rendering
* **Lottie** — Animations
* **Flutter Animate** — UI animations
* **AudioPlayers** — Audio playback
* **Carousel Slider** — Carousel components
* **Flutter Staggered Grid View** — Grid layouts
* **Glassmorphism** — Visual UI effects
* **Confetti** — Celebration effects
* **Intl / Timeago** — Date and time formatting
* **Pretty Dio Logger** — Network request debugging
* **Flutter Launcher Icons** — Application icon configuration

---

## 🏗 Architecture

The project follows a **Feature-Based Architecture** with a shared `core` layer.

This structure separates application features while keeping reusable infrastructure and common functionality centralized.

```text
lib/
├── core/
│   ├── cache/
│   ├── errors/
│   ├── services/
│   ├── settings/
│   └── utils/
│
├── features/
│   ├── auth/
│   ├── home/
│   ├── profile/
│   └── quiz/
│
└── main.dart
```

### Architecture Responsibilities

* `lib/core/`
  Contains shared infrastructure, utilities, caching, error handling, services, and application-wide settings.

* `lib/features/`
  Contains application-specific feature modules.

* **BLoC / Cubit**
  Handles application state management.

* **Dio**
  Handles networking and HTTP communication.

* **GetIt**
  Provides centralized dependency injection / service location.

* **Flutter Secure Storage**
  Handles sensitive local data.

* **Shared Preferences**
  Provides local persistence.

---

## 📂 Project Structure

```text
ma3refa-mobile/
├── android/
├── ios/
├── assets/
│   ├── images/
│   ├── lottie/
│   ├── sounds/
│   └── translations/
│
├── lib/
│   ├── core/
│   │   ├── cache/
│   │   ├── errors/
│   │   ├── services/
│   │   ├── settings/
│   │   └── utils/
│   │
│   ├── features/
│   │   ├── auth/
│   │   ├── home/
│   │   ├── profile/
│   │   └── quiz/
│   │
│   └── main.dart
│
├── pubspec.yaml
└── README.md
```

---

## 🚀 Getting Started

Follow the steps below to run the project locally.

### Prerequisites

Make sure you have:

* Flutter SDK installed and configured
* Dart SDK compatible with the project
* An Android or iOS device/emulator

The project currently specifies:

```text
Dart SDK: ^3.12.2
```

### 1. Clone the Repository

```bash
git clone https://github.com/Ma3refa-GP-IEEE/ma3refa-mobile.git
cd ma3refa-mobile
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the Application

```bash
flutter run
```

Make sure a physical device is connected or an Android/iOS emulator is running.

---


## ⏱️ Development Timeline

**Development Duration: 10 Days**

The Ma3refa Mobile application was developed within a focused **10-day development period** as part of the student project.

The 10-day timeline represents the project's development scope and time constraint.

---

## 👨‍💻 Developer

The overall project was developed under **Ma3refa-GP-IEEE**.

The **Ma3refa Mobile** application in this repository was independently designed and developed by:

### Mahmoud Addelghani

**Role:** Flutter Mobile Application Developer

Responsibilities included:

* Flutter application development
* UI/UX design and implementation
* Feature implementation
* BLoC / Cubit state management
* Networking integration
* Local storage integration
* Project structure and organization
* Mobile application development within the 10-day timeline
