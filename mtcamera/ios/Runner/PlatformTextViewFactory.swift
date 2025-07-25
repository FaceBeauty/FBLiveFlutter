//
//  PlatformTextViewFactory.swift
//  Runner
//
//  Created by N17 on 2021/6/29.
//

import Foundation
import Flutter

class PlatformTextViewFactory: NSObject,FlutterPlatformViewFactory {
        
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
//        return PlatformTextView(frame,viewID: viewId,args: args)
        return PlatformTextView()
    }
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
    
}
