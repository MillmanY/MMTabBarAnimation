# MMTabBarAnimation

[![CI Status](http://img.shields.io/travis/Millman YANG/MMTabBarAnimation.svg?style=flat)](https://travis-ci.org/Millman YANG/MMTabBarAnimation)
[![Version](https://img.shields.io/cocoapods/v/MMTabBarAnimation.svg?style=flat)](http://cocoapods.org/pods/MMTabBarAnimation)
[![License](https://img.shields.io/cocoapods/l/MMTabBarAnimation.svg?style=flat)](http://cocoapods.org/pods/MMTabBarAnimation)
[![Platform](https://img.shields.io/cocoapods/p/MMTabBarAnimation.svg?style=flat)](http://cocoapods.org/pods/MMTabBarAnimation)

## Demo
    
  ![demo](https://github.com/MillmanY/MMTabBarAnimation/blob/master/demoGood.gif)
  
  
  
## Requirements

    iOS 8.0+
    Xcode 8.0+
    Swift 3.0+
    
## Use
    
    1. Inherit MMTabBarAnimation on your TabBarController
        class BaseTabBarViewController: MMTabBarAnimateController {
        }
    
    2. Set function
        // Default duration = 0.3
        public func setAnimateAllItem(animate: MMTabBarAnimation.ItemAnimateType, duration: TimeInterval)
        public func setAnimateAllItem(animate: MMTabBarAnimation.ItemAnimateType)
        public func setAnimate(index: Int, animate: MMTabBarAnimation.ItemAnimateType, duration: TimeInterval)
        public func setAnimate(index: Int, animate: MMTabBarAnimation.ItemAnimateType)
        public func setBadgeAnimate(index: Int, animate: MMTabBarAnimation.AnimateType)
        public func setAllBadgeAnimate(animate: MMTabBarAnimation.AnimateType)

        
    3. Choose Animation Type
    
          public enum AnimateType {
            case scale(rate: Float)
            case jump
            case rotation(type: MMTabBarAnimation.RotationType) // .left .right .circle
            case shake
            case none // Disable Animation
          }
         
    4. Choose Animation on which item
          
           public enum ItemAnimateType {
              case content(type: MMTabBarAnimation.AnimateType) // tabBarView
              case icon(type: MMTabBarAnimation.AnimateType)    // tabBarIcon
              case label(type: MMTabBarAnimation.AnimateType)   // tabBarTitleLabel
              case iconExpand(image: UIImage)                   // Expand Select Image with Animation (Dont Set selectImage on storyBoard)
           }
 
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

MMTabBarAnimation is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MMTabBarAnimation'
```

## Author

Millman YANG, millmanyang@gmail.com

## License

MMTabBarAnimation is available under the MIT license. See the LICENSE file for more info.
