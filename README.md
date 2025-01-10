<p align="center"><img src="web/icons/Icon-192.png" style="width:16em"></p>

# Courtly Vendor: Easily order a court or sport field for vendor

**Courtly** is an mobile app for sports field booking with an innovation to overcome traditional booking systems. By utilizing technology, users can make reservations for sports field facilities only through their smartphone gadgets without the need to come to the location or chat via WhatsApp. Courtly can also provide **real-time field availability information**, allowing users to **choose the time they want**, and can make **payments directly with flexible and secure methods**. **Courtly Vendor** is aim specificly for sports vendors.

## 🚀 Key of Features

Courtly Vendor app includes several features, such as:

- **Vendor Dashboard**: View orders and track orders.
- **Customizeable Court System**: Manage your own vendor courts, by creating, adding, updating, or deleting.
- **View Reviews**: See what are people thinks about your courts.

## 🛠️ Technologies Used

- **Flutter SDK**: [Install Flutter](https://docs.flutter.dev/get-started/install).
- **Dart**: Comes with Flutter but ensure it's installed.
- **Backend Server**: [Visit backend repo](https://github.com/bryanfks-dev/Courtly-Service).

## 💻 Local Development

Follow these steps to set up the project locally:

### Requirement(s):

- Flutter
- Android Studio (optional) / VSCode
- Mobile phone emulator

### Steps:

1. Clone the repository:

```bash
git clone https://github.com/bryanfks-dev/Courtly-Vendor.git
cd Courtly-Vendor
```

2. Install depedencies:

```bash
flutter pub get
```

3. Configure configs:

```bash
cd lib/core/config
```

Set the backend server ip address and api version:

```dart
/// [baseUrl] is the base URL of the API server.
static const String baseUrl = '...';

/// [version] is the version of the API server.
/// [version] should always start with 'v' followed by the version number.
static const String version = 'v...';
```

4. Start your emulator:

For AVD Emulator:

```bash
emulator -avd <avd_name>
```

5. Start the app:

```bash
flutter run
```

## 📄 License

This project is licensed under the [MIT License](https://github.com/bryanfks-dev/Courtly-Vendor/blob/main/LICENSE).
