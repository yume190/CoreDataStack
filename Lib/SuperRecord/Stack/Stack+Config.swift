//
//  Stack+Config.swift
//  CoreDataStack
//
//  Created by Yume on 2018/2/23.
//  Copyright © 2018年 Yume. All rights reserved.
//

import Foundation

extension SuperCoreDataStack {
    struct Config {
        let type: CoreDataType
        let stackName: String // BusAPP
        let prefixName: String
        
        let userDocumentURL: URL
        
        var copyTargetName: String { return self.prefixName + self.stackName}
        var storeName: String { return self.stackName + ".sqlite" }
        var storeNameURL: URL { return self.userDocumentURL.appendingPathComponent(self.storeName) }
        
        init?(type: CoreDataType, stackName: String, prefixName: String) {
            guard let userDocumentURL:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
                return nil
            }
        
            self.type = type
            self.stackName = stackName
            self.prefixName = prefixName
            self.userDocumentURL = userDocumentURL
        }
    }
}
