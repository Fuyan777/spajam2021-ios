## setup
以下のコマンドを実行

```
$ make install
```

## Project Structure

```
├── spajam-ios
│   ├── App
│   │   ├── AppDelegate.swift
│   │   └── SceneDelegate.swift
│   ├── Info.plist
│   ├── Model // Entity周り
│   │   └── EntityModel.swift
│   ├── Resource
│   │   ├── Assets.xcassets
│   │   │   ├── AccentColor.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── AppIcon.appiconset
│   │   │   │   └── Contents.json
│   │   │   └── Contents.json
│   │   └── Base.lproj
│   │       └── LaunchScreen.storyboard
│   ├── UIKit // UIKitベース
│   │   ├── Base.lproj
│   │   │   └── Main.storyboard
│   │   └── ViewController.swift
│   ├── View // SwiftUIベース
│   │   └── HomeView.swift
│   └── ViewModel // ストア、アクション、ロジック部分
│       └── ViewModel.swift
```