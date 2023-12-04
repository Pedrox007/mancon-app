# Mancon App

This is a Flutter app for construction expenses managenment.

## Getting Started

This project connects to a Mancon API instance, so, you need it running. To make Mancon App connects to the instance of [Mancon API](https://github.com/Pedrox007/mancon-back-end), it's necessary configure the above environment variable:

```console
MANCON_API_BASE_URL=mancon_api_host
```

To run the app, just run the next command:
```console
flutter run --dart-define=MANCON_API_BASE_URL=mancon_api_host
```

The app also makes connection to an instance of Firebase Storage. So, you need to configure it. To do it, make sure that you have the flutterfire-cli installed and configurated. If you have it, just run the next command:
```console
flutterfire configure
```
This command will generate the requried files to connect to Firebase Storage, such as the `firebase_options.dart` on `lib` directory.