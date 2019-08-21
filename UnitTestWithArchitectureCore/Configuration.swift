//
//  Configuration.swift
//  UnitTestWithArchitectureCore
//
//  Created by EquipeSuporteAplicacao on 5/30/18.
//  Copyright © 2018 Thufik. All rights reserved.
//

import UIKit

class Configuration: NSObject {
    static func baseUrl() -> String?{
        
        guard let pathForInfoList = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            return nil
        }
        
        let dicFromInfoList = NSDictionary(contentsOfFile: pathForInfoList)
        
        guard let unwrappedDicFromInfoList = dicFromInfoList else {
            return nil
        }
        
        let baseUrl = unwrappedDicFromInfoList.object(forKey: "base_url") as? String

        return baseUrl
    }
}
