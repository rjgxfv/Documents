//
//  Doc+CoreDataProperties.swift
//  Documents
//
//  Created by Robert Graman on 2/19/19.
//  Copyright © 2019 Robert Graman. All rights reserved.
//
//

import Foundation
import CoreData


extension Doc {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Doc> {
        return NSFetchRequest<Doc>(entityName: "Doc")
    }

    @NSManaged public var body: String?
    @NSManaged public var dateMod: NSDate?
    @NSManaged public var fileSize: String?
    @NSManaged public var title: String?

}
