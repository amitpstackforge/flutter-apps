# macOS-এ Flutter সেটআপ (বাংলা গাইড)

এই গাইডে macOS-এ Flutter ডেভেলপমেন্ট এনভায়রনমেন্ট সেটআপ করার সম্পূর্ণ ধাপগুলো বাংলায় দেওয়া হলো।

## ১) সিস্টেম রিকোয়ারমেন্ট

- macOS (সাম্প্রতিক ভার্সন হলে ভালো)
- কমপক্ষে ১০ GB ফ্রি স্টোরেজ
- Git ইনস্টল করা
- টার্মিনাল ব্যবহারের বেসিক ধারণা

## ২) Homebrew ইনস্টল (যদি আগে না থাকে)

টার্মিনালে চালান:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

ইনস্টল শেষে চেক করুন:

```bash
brew --version
```

## ৩) Git ইনস্টল/ভেরিফাই

```bash
git --version
```

যদি Git না থাকে:

```bash
brew install git
```

## ৪) Flutter SDK ডাউনলোড ও সেটআপ

### অপশন A: Homebrew দিয়ে (সহজ)

```bash
brew install --cask flutter
```

### অপশন B: Git দিয়ে Flutter SDK ক্লোন

```bash
cd ~
git clone https://github.com/flutter/flutter.git -b stable
```

## ৫) PATH-এ Flutter যুক্ত করা

### Apple Silicon (M1/M2/M3) হলে সাধারণত `~/.zshrc` এ:

```bash
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.zshrc
source ~/.zshrc
```

### যদি Homebrew ইনস্টল করা Flutter ব্যবহার করেন

অনেক ক্ষেত্রে `brew` নিজেই PATH হ্যান্ডেল করে। সমস্যা হলে:

```bash
echo 'export PATH="$PATH:/opt/homebrew/Caskroom/flutter/latest/flutter/bin"' >> ~/.zshrc
source ~/.zshrc
```

Flutter পাওয়া যাচ্ছে কিনা চেক করুন:

```bash
flutter --version
```

## ৬) Xcode ইনস্টল (iOS ডেভেলপমেন্টের জন্য)

1. App Store থেকে Xcode ইনস্টল করুন
2. প্রথমবার Xcode ওপেন করে অতিরিক্ত কম্পোনেন্ট ইনস্টল হতে দিন
3. টার্মিনালে লাইসেন্স অ্যাকসেপ্ট করুন:

```bash
sudo xcodebuild -license
```

4. Command Line Tools সিলেক্ট করুন:

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```

## ৭) CocoaPods ইনস্টল (iOS dependency manager)

```bash
brew install cocoapods
pod --version
```

## ৮) Android Studio ইনস্টল (Android ডেভেলপমেন্টের জন্য)

1. Android Studio ডাউনলোড ও ইনস্টল করুন
2. Android SDK, SDK Platform, এবং Build Tools ইনস্টল করুন
3. Android Emulator (AVD) সেটআপ করুন
4. Android SDK লাইসেন্স অ্যাকসেপ্ট করুন:

```bash
flutter doctor --android-licenses
```

সব লাইসেন্সে `y` দিন।

## ৯) Flutter Doctor চালিয়ে সমস্যা চেক

```bash
flutter doctor
```

আরও বিস্তারিত চেক:

```bash
flutter doctor -v
```

যেখানে `[!]` দেখাবে, সেই অংশ ঠিক করতে নির্দেশনা অনুসরণ করুন।

## ১০) Editor সেটআপ (VS Code বা Android Studio)

### VS Code

```bash
brew install --cask visual-studio-code
```

এরপর VS Code Extensions থেকে ইনস্টল করুন:
- Flutter
- Dart

### Android Studio

Plugins থেকে ইনস্টল করুন:
- Flutter plugin
- Dart plugin (Flutter plugin ইনস্টল করলে সাধারণত Dart অটো আসে)

## ১১) প্রথম Flutter প্রজেক্ট তৈরি ও রান

```bash
flutter create my_first_app
cd my_first_app
flutter run
```

## ১২) ডিভাইস/সিমুলেটর চালু করা

### iOS Simulator

```bash
open -a Simulator
```

### Android Emulator

Android Studio > Device Manager থেকে Emulator চালু করুন।

## ১৩) সাধারণ সমস্যার দ্রুত সমাধান

- `flutter` কমান্ড না পেলে: PATH আবার সেট করে `source ~/.zshrc` দিন
- Xcode error হলে: Xcode একবার খুলে completion শেষ করুন
- CocoaPods error হলে:

```bash
sudo gem install cocoapods
pod repo update
```

- Android লাইসেন্স error হলে:

```bash
flutter doctor --android-licenses
```

## ১৪) আপডেট কমান্ড

```bash
flutter upgrade
flutter doctor
```

## ১৫) সেটআপ সম্পন্ন কিনা চূড়ান্ত যাচাই

নিচের কমান্ডে যদি বড় কোন error না থাকে, তাহলে আপনার Flutter সেটআপ প্রস্তুত:

```bash
flutter doctor -v
```

---

আপনার macOS-এ Flutter সেটআপ এখন সম্পূর্ণ। চাইলে পরের ধাপে Firebase, state management, বা app release setup-ও করতে পারেন।
