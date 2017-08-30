//
//  Utils.swift
//  OutlineView
//
//  Created by nathan on 2017. 8. 30..
//  Copyright © 2017년 Seven Years Later. All rights reserved.
//

import Foundation
import SwiftyJSON

extension String {
    
    func convertJson() -> JSON? {
        if let data = self.data(using: .utf8) {
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: [])
                return JSON(dict)
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}

