# Synd Innovate Admin
![codemagic](https://api.codemagic.io/apps/5d7aeda7ef074c25be70d4d4/5d7aeda7ef074c25be70d4d3/status_badge.svg)

**Note:** The app is configured for both **iOS** and **Android**, and will run on both platforms smoothly.

## Installing
* First of all, you should have **Flutter** and **Dart SDK** set up on your system. You should also have **Android Studio** installed on your system because with it comes the Android toolchain, without which you cannot run it on any Android device or emulator. 

* For running it on an iOS device, you should have a desktop or laptop with **Mac OS**, with **Xcode** installed and configured.

**1.** You have to first clone this repo, using the command:
```bash
git clone https://github.com/sbis04/synd_innovate.git
```

**2.** Then, go into the project directory:
```bash
cd synd_innovate
```

**3.** To run it on an emulator or physical device, use this command:
```bash
flutter run
```

## Login Screen
The Admin version of the app will also have a splash screen after which they will be taken to the Login Screen. The Admin can also login with their Bank Credentials, their Social accounts or their registered mobile number as a Bank Admin. (This can be changed as per the requirement of the bank).

## Dashboard Screen
* This dashboard will be visible to the user / agents, and they can edit the products available for referral from the Bank. They can edit the reward points for each product and add new products in that will be shown in the dashboard of the user version of the app.

* They can also add or edit the discount and offers available to the user which will be shown in the user version of the app in their respective dashboards.

* In the bottom app bar there will be two options: 1. Dashboard 2. User profiles (sorted by their rewards and Partner Level)

* The Dashboard option is selected by default when the Admin version of the app is first started.

## Profiles Screen
When the profiles option is selected from the dashboard, various user profiles will be shown those who have used the app for generating leads. The User name, partner level, number of leads generated and their respective badges will be visible to the admin.

## User Screen
* Clicking on any user will show more information of the user to the admin, Here, the Admin can make some changes to that particular profile also.

* The admin can edit the Number of Leads Generated & the Reward Points of the user, Badge of the user & the Green Tick Mark beside the user name.

* The admin can also give some bonus to the any user by clicking on the Add Bonus button.
## Screenshots
<img src="https://github.com/sbis04/synd_innovate_prototype/blob/master/Admin%20Screenshot/Admin_1.png" height="280" alt="Screenshot"/> | <img src="https://github.com/sbis04/synd_innovate_prototype/blob/master/Admin%20Screenshot/Admin_2.png" height="280" alt="Screenshot"/> | <img src="https://github.com/sbis04/synd_innovate_prototype/blob/master/Admin%20Screenshot/Admin_3.png" height="280" alt="Screenshot"/> | <img src="https://github.com/sbis04/synd_innovate_prototype/blob/master/Admin%20Screenshot/Admin_4.png" height="280" alt="Screenshot"/> | <img src="https://github.com/sbis04/synd_innovate_prototype/blob/master/Admin%20Screenshot/Admin_5.png" height="280" alt="Screenshot"/>

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
