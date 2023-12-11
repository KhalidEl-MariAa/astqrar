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
#  build/app/outputs/bundle/release/app-release.aab
```

5. upload Sybmols file. compress all folders in:
```
  astqrar/build/app/intermediates/merged_native_libs/release/out/lib
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

$ cd Downloads/Dating/astqrar/

# Add or Update the flutter package 
$ flutter pub add firebase_core

# Install flutterfire_cli 
$  dart pub global activate flutterfire_cli

# Add it to PATH
export PATH="$PATH":"$HOME/.pub-cache/bin"

# This will creates the 'firebase_options.dart' in your Flutter project
$ flutterfire configure --project=astqrar-b5dbd
```

6. in flutter initialize the firebase object like this
```dart
WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
  name: "astqrar", //project name in Firebase Console
  options: DefaultFirebaseOptions.currentPlatform,
);

```


التحديث الجديد

1-اضافة صور شخصيه ✅
-  امكانية عرض الصورة في صفحة خاصة مع امكانية التكبير والتصغير باستخدام اصبعين ✅

2- تعديل الوقت الزمني لملف العملاء من اسبوعين الى مفتوح ع طول( يصير معاد يختفي ملف العميل يكون موجود حتى لو اخر ظهور قبل سنتين ) ✅

3- تعديل الرسائل لان اخر الرسائل تكون في اخر القائمة ✅

4- وضع علامة وصول رساله جديدة بالرسائل مثل الواتس. ✅
- بمجرد الدخول الى الرسائل الجديدة سيتم تعديل رقم العلامة الى صفر


5- الدخول على الرسائل كذلك عن طريق الاشعار. 

 6- مشكلة تحديد الجنس كثير نساء احصلهم في قسم رجال ( لو يكون فيه خيار ضمن الملف الشخصي يكون افضل ) ✅

7- نحذف رقم الهويه ونعتمد رقم الجوال في التسجيل ✅
- سيتم ارسال كود التفعيل عن طريق الاشعارات ✅
- ملاحظة: المفروض يكون لكل حساب رقم جوال غير مكرر، ولكن حاليا لدينا مستخدمين الذين لديهم حسابين بنفس رقم الجوال ولذلك سيكون واحد برقم جواله الحالي والحساب الاخر رقم جواله يكون هو نفسه رقم هويته ✅

8- ملف تعريف العملاء يكون اجباري الاختيار .

9- خانة الشروط تلغى الأرقام ( العربيه او الانجليزيه ) ✅

10- توجد مشكله في قيمة المهر ( كما في الصوره اعلاه ) ✅
  
11- توجد مشكله في نبذه في مظهرك (كما في الصوره اعلاه ) ✅

12- مشكلة اشعار العملاء في حال نشر ملف.

13- مشكلة اشعار الاداره لايوصل اشعار الا داخل التطبيق سابقا يوجد اشعار خارج التطبيق ك تنويه بتحديث جديد او عروض وهكذا .

14- حذف الاشعارات مثل حذف المحادثات ✅