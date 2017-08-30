//
//  View.swift
//  OutlineView
//
//  Created by nathan on 2017. 8. 30..
//  Copyright © 2017년 Seven Years Later. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Frame: Decodable {
    var x: CGFloat
    var y: CGFloat
    var width: CGFloat
    var height: CGFloat
}

struct View: Decodable {
    var name: String
    var layer: String
    var frame: Frame
    var type: String?
    var text: String?
    var children: [View]?
    
    var title: String {
        return "[\(type ?? "view")] \(name)"
    }
}

struct ViewParser {
    
    static func parse(fromJsonString jsonString: String) -> View? {
        if let data = jsonString.data(using: .utf8) {
            do {
                let view = try JSONDecoder().decode(View.self, from: data)
                return view
            } catch let error {
                print(error)
                return nil
            }
        }
        return nil
    }
    
}
