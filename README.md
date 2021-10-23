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
│   │   └── SceneDelegate.swift // 現状SwiftUIベース
│   ├── Info.plist
│   ├── Resource // アセット（画像）とスプラッシュ
│   │   ├── Assets.xcassets
│   │   │   ├── AccentColor.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── AppIcon.appiconset
│   │   │   │   └── Contents.json
│   │   │   └── Contents.json
│   │   └── Base.lproj
│   │       └── LaunchScreen.storyboard
│   ├── UIKit // UIKitで作成するView
│   │   ├── Base.lproj
│   │   │   └── Main.storyboard
│   │   └── ViewController.swift
│   └── View // SwiftUIで作成するView
│       └── HomeView.swift
```