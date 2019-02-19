//
//  Doc+CoreDataClass.swift
//  Documents
//
//  Created by Robert Graman on 2/19/19.
//  Copyright © 2019 Robert Graman. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Doc)
public class Doc: NSManagedObject {
    
    var date: Date?{
        get{
            return dateMod as Date?
        }
        set{
            dateMod = newValue as NSDate?
        }
    }
    convenience init?(title: String, size: String, body:String, dateMod:Date){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{
            return nil
        }
        self.init(entity: Doc.entity(), insertInto: managedContext)
        self.body = body
        self.fileSize = size
        self.date = dateMod
        self.title = title
    }
}
