# About
Ping is the avatar generator for Echo Blockchain accounts by username.

Each Echo Blockchain account has its own unique avatar. Ping will help you get it.

# Installation
## CocoaPods

```shell
pod 'Ping'
```

# Usage

```swift
let imageView = UIImageView()
imageView.frame = CGRect(x: 20, y: 20, width: 100, height: 100)
imageView.image = UIImage.drawAvatar(name: "pixelplex", size: 100)

view.addSubview(imageView)
```

where `pixelplex` - an Echo account name, and `100` - an avatar size.

And as result, you will receive the image with your unique avatar

As example:


![PixelPlex avata](pixelplex-avatar.png)

# Contributing and License
Distributed under the MIT license. See LICENSE for more information.
