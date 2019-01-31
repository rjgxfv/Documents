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
    var document: Document?
    
    
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(document?.name) != nil{
            name.text = document!.name
            do{
                let fileURL = documentsURL.appendingPathComponent(document!.name).appendingPathExtension("txt")
                contents.text = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)
            }catch let error as NSError
            {
                print("failed to read File")
                print(error)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveFile(_ sender: Any) {
        if let fileName = name.text, let fileContents = contents.text
        {
        if fileName != ""
        {
            let fileURL = documentsURL.appendingPathComponent(fileName).appendingPathExtension("txt")
            
            print("saving file:\(fileName)" )
            print("file Path: \(fileURL)")
            do{
                try fileContents.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            }catch let error as NSError
            {
                print("failed to write to URL")
                print(error)
            }
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            navigationBar.title = "File requires name"
            print("There is no name for the file")
        }
        }
    }
    @IBAction func fileNameChanged(_ sender: Any) {
        navigationBar.title = name.text
    }
    
}
