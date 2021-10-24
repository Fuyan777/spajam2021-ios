## Achievement
SPAJAM2021 第5回予選
→ **優秀賞**

## App
|打刻|バッテリー|結果|
|:--:|:--:|:--:|
|<img src="https://user-images.githubusercontent.com/29572313/138615312-eb3e60ac-fd51-4ceb-b0b2-fa3006a8eb37.PNG" width=300>|<img src="https://user-images.githubusercontent.com/29572313/138615324-20497a58-bbc7-4e93-a02f-052b5d5cad35.PNG" width=300>|<img src="https://user-images.githubusercontent.com/29572313/138615332-e7ea9dea-67c8-4a43-8a31-0c6a36f6dd1e.PNG" width=300>|


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
