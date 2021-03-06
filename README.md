# Push Weather

A Weather notification app

<p align="center"><img src="./assets/thumbnail.png" alt="IMG" width="50%" /></p>

## Description
This is a simple weather notification application. Through this app, users can check weather information based on their current location. The app also sends notifications to check the weather at a specific time set by the user.

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You should install:

* Flutter ^2.8

Please following the official [Flutter Installation Guide](https://docs.flutter.dev/get-started/install).

!Important: you should have two files before build this app.

1. "google-services.json" from [Google Firebase Firestore](https://firebase.google.com/)
2. ".env" from [Weatherapi](https://www.weatherapi.com)
   1. Sign-up for Weatherapi and get and API key
   2. Make a file named ".env"
   3. Enter the key by following this format ```WEATHER_API_KEY='<YOUR API KEY HERE>'``` in the .env file 

### How to use
<img width="250" alt="feedback" src="https://user-images.githubusercontent.com/76894761/151682852-17af9c50-7368-4a64-ab5a-d2a0caaf8744.png">
This is the Home screen that you see when you open the application. 
You will see 

* Temperature in F and C  
* Weather  
* Feels like temperature   
* Humidity  
* Probability of rain  
* Probability of snow  
* Today's date  
* Notification setting timer  
* Feedback Icon  

<img width="250" alt="Setting" src="https://user-images.githubusercontent.com/76894761/151682851-2f453170-a418-4489-a8bf-cf41c2090c8a.png">
Once you click the feedback Icon, you can find a container that you can send the feedbacks to the developer.

## Built with
* Flutter - Dart
* VIPER - Design Pattern
* External libraries used in this project

## Authors
Daewoong Ko  
Haesun Lee  

## Version History

- 1.0.0
  - Initial Release

## License
This project is licensed under the MIT License

## Acknowledgments
- [Implementing Local Notification](https://blog.logrocket.com/implementing-local-notifications-in-flutter/)
- [Flutter App Icon Change](https://www.geeksforgeeks.org/flutter-changing-app-icon/)
- [Flutter App Release](https://here4you.tistory.com/198)
