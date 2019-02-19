//
//  EditorViewController.swift
//  Documents
//
//  Created by Robert Graman on 1/31/19.
//  Copyright © 2019 Robert Graman. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var navigationBar: UINavigationItem!
//    var document: Document?
    var document2: Doc?
    
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (document2 != nil) {
            var text = document2!.title
            name.text = text
            contents.text = document2?.body
            
        }
    }
    
    
    @IBAction func saveFile(_ sender: Any) {
        let size = contents.text!.count
        let sizeString = "\(size) bytes"
        let title = name.text!
        let body = contents.text!
        document2 = Doc(title: title, size: sizeString, body: body, dateMod: Date(timeIntervalSinceNow: 0))
        let managedContext = document2?.managedObjectContext
        do{
            try managedContext?.save()
        }
        catch{
            print("Failed to save file.")
        }
        self.navigationController?.popViewController(animated: true)
        
        
        
//        if let fileName = name.text, let fileContents = contents.text
//        {
//        if fileName != ""
//        {
//            let fileURL = documentsURL.appendingPathComponent(fileName).appendingPathExtension("txt")
//
////            print("saving file:\(fileName)" )
////            print("file Path: \(fileURL)")
//            do{
//                try fileContents.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
//            }catch let error as NSError
//            {
//                print("failed to write to URL")
//                print(error)
//            }
//            //update array(name)
//            self.navigationController?.popViewController(animated: true)
//        }
//        else
//        {
//            navigationBar.title = "File requires name"
//            print("There is no name for the file")
//        }
//        }
    }
    @IBAction func fileNameChanged(_ sender: Any) {
        navigationBar.title = name.text
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? DocumentsViewController , let newName = name.text
//        {
//            destination.filename = newName
//        }
//    }
    
}
