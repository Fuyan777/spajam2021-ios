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

## 仕様書
https://hackmd.io/@QexHAtZ8RkWJGOBpEEccXA/Hy2n3QbLK

## スライド
https://docs.google.com/presentation/d/1BY6pYvUcCWQ2T4TkhR1Fbp7R4G8xdDAPHiuwSA0UXgU/edit?usp=sharing
