//
//  document.swift
//  Documents
//
//  Created by Robert Graman on 1/31/19.
//  Copyright © 2019 Robert Graman. All rights reserved.
//

import Foundation

struct Document {
    let name: String
    let size: String
    let dateModified: Date
    
    init(name: String, size: String, dateModified: Date) {
        self.name = name
        self.size = size
        self.dateModified = dateModified
    }
}
