# Astarar (Eng. Sami Alfattani)

A new Flutter project.

## Flutter and Android in $PATH (Linux)
```bash
PATH="$PATH:$HOME/Documents/programs/flutter/bin"
PATH="$PATH:$HOME/Documents/programs/flutter/dart-sdk/bin"
PATH="$PATH:$HOME/Documents/programs/flutter/cmake/bin"

export ANDROID_HOME=$HOME/Documents/programs/android_sdk
PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
PATH="$PATH:$ANDROID_HOME/emulator"
PATH="$PATH:$ANDROID_HOME/platform-tools"
```

## Create AVD
`avdmanager` can be found in `/path/to/command-tools/bin/latest`

```bash
# get installed AVDs
> avdmanager list avd 
```

## Run Emulator
`emulator.exe` can be found in `/path/to/sdk/emulator/`

```bash
emulator -list-avds

emulator -avd Resizable_Experimental_API_33

```


## Run
```bash
flutter clean

# get availavle connected (running) devices
> flutter devices

cd "~\Downloads\Dating-kaheelan\astqrar"

flutter build
flutter run
flutter run -d emulator-5554 
flutter run -d R3CN70DBFHL
```

## Run (MacOS)

```bash
# Make sure Pod is working correctly
$ rm -rf ./ios/Podfile.lock
$ pod update


# Run ios Simulator (MacOS)
$ open -a Simulator
$ flutter build ios
$ flutter run
$ flutter run --release
```


## Deploy to Android
1. you can read this [article](https://docs.flutter.dev/deployment/android)
2. Make sure you are using same *.jks file (Upload Sining Key) that is already uploaded toe Google Play.
3. *.jks file need a password to be read properly which can be found in `build/Android/key.properties` file.

4. Create Bundle:
```bash
flutter build apk
# build/app/outputs/bundle/release/app-release.apk

# for AAB file
flutter build appbundle
# build/app/outputs/bundle/release/app-release.aab
```

5. upload Sybmols file. compress all folders in:
```bash
#  build/app/intermediates/merged_native_libs/release/out/lib
(cd build/app/intermediates/merged_native_libs/release/out/lib && zip -r ../../../../../../app/outputs/bundle/release/symbols.zip *)
```

## Deploy to IOS (MacOS)

1. Make sure that `gem` installer is ready to use.
2. Install Flutter 
```bash
# install cocoapods (building tool like Gradle)
$ sudo gem install cocoapods

# check installation 
$ gem which cocoapods
```
3. Edit project configurations using XCode

4. Build IPA (iOS App Store package) package
```bash
$ flutter build ipa

# find the *.ipa file in ./astqrar/build/ios/ipa
```
5. Upload using Transporter, this app can be found in apple store.

## Configure Firebase for (Notifications)
1. Make sure `npm` is ready to use
2. Create a Firebase Project from Google Firebase Console.
```bash
# install Firebase CLI
$ npm install -g firebase-tools

# check ...
$ firebase --version

# login to your Gmail account that contains the Firebase project and authorize it.
$ firebase login 
# login to another user
$ firebase login --reauth

$ cd Downloads/Dating/astqrar/

# Add or Update the flutter package 
$ flutter pub add firebase_core

# Install flutterfire_cli 
$  dart pub global activate flutterfire_cli

# Add it to PATH
export PATH="$PATH":"$HOME/.pub-cache/bin"

# This will creates the 'firebase_options.dart' in your Flutter project.
# This will creates 2 Apps (Android & iOS) in your Firebase Console.
$ flutterfire configure --project=astqrar64

$ flutter clean
$ flutter build
```

6. in flutter initialize the firebase object like this
```dart

WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
  //project name in Firebase Console
  name: "astqrar", /* DON'T USE IT WITH DEFAULT OPTIONS */
  options: DefaultFirebaseOptions.currentPlatform,
);

```

