//
//  PlatformTextView.swift
//  Runner
//
//  Created by N17 on 2021/6/29.
//

import Foundation
import Flutter
class PlatformTextView: NSObject,FlutterPlatformView {

//    init(_ frame: CGRect,viewID: Int64,args :Any?) {
//        self.frame = frame
//        self.viewId = viewID
//        if(args is NSDictionary){
//            let dict = args as! NSDictionary
//            self.text = dict.value(forKey: "text") as! String
//        }
//    }
//
    override init() {
        NSLog("测试:准备ok!")
        
    }
//    FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"mt_plugin" binaryMessenger:[registrar messenger]];
    
    func view() -> UIView {
        
        let iosView = IOSFlutterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        return iosView
        
    }
    
}
