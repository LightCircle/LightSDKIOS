# SmartSDK

<!-- [![Version](http://cocoapod-badges.herokuapp.com/v/SmartSDK/badge.png)](http://cocoadocs.org/docsets/SmartSDK)
[![Platform](http://cocoapod-badges.herokuapp.com/p/SmartSDK/badge.png)](http://cocoadocs.org/docsets/SmartSDK)
 -->
## Usage

To run the example project; clone the repo, and run `pod install` from the Example directory first.

## Requirements

依赖以下Cocoapod模块:

    s.dependency 'AFNetworking',               '2.2.4'
    s.dependency 'AFNetworking-RACExtensions', '0.1.4'
    s.dependency 'jastor',                     '0.2.1'
    s.dependency 'CocoaLumberjack',            '1.8.1'
    s.dependency 'ReactiveCocoa',              '2.3'
    s.dependency 'libextobjc',                 '0.4'
    s.dependency 'SocketRocket',               '0.3.1-beta2'
    s.dependency 'SDWebImage',                 '3.6'
    s.dependency 'Underscore.m',               '0.2.1'

## Installation

SmartSDK is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "SmartSDK"

## Documents

本工程包含如下模块:

  - Config    : 用于存储配置信息.
  - Entity    : 映射 Smart 平台的数据接口.
  - Logger    : Log 模块,支持 operation log.
  - Rest      : 用于跟后台 REST API 交互.
  - Storable  : 用户 App 中的数据存储,可直接存储 `DAEntity` 的子类.
  - UI        : 封装页面相关逻辑.
  - Util      : 工具类.
  - WebSocket : 用于跟 Web socket server 通信.


## Author

fzcs, fzcs@live.cn

## License

SmartSDK is available under the MIT license. See the LICENSE file for more info.

