//
//  DocumentsViewController.swift
//  Documents
//
//  Created by Robert Graman on 1/31/19.
//  Copyright © 2019 Robert Graman. All rights reserved.
//

import UIKit


class DocumentsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    var documents = [Document]()
    let dateFormatter = DateFormatter()
//    var newFile:Document
//    var filename: String
    @IBOutlet weak var documentsTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "documentCell", for:indexPath)
        dateFormatter.dateFormat = "MMMM d, yyyy HH:mm"
        if let cell = cell as? DocumentsTableViewCell{
            let document = documents[indexPath.row]
            cell.fileName.text = document.name
            cell.fileSize.text = document.size
            cell.fileDate.text = dateFormatter.string(from: document.dateModified)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditorViewController,
            let row = documentsTableView.indexPathForSelectedRow?.row {
            
            if (segue.identifier == "add") {
                destination.document = nil
            } else {
                destination.document = documents[row]
            }
            destination.document = segue.identifier == "add" ? nil : documents[row]
            
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        print("hello")
        documents = [Document]()
        let fileManager = FileManager.default
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let path = documentsURL.path
        
        do {
            let files = try fileManager.contentsOfDirectory(atPath: path)
            
            for file in files {
                var documentSize: UInt64
                var documentDate: Date? = nil
                let documentPath = path + "/" + file
                var documentSizeString: String = "0 bytes"
                
                do {
                    let file = try FileManager.default.attributesOfItem(atPath: documentPath)
                    
                    documentDate = file[FileAttributeKey.modificationDate] as? Date
                    documentSize = file[FileAttributeKey.size] as! UInt64
                    documentSizeString = "\(documentSize) bytes"
                } catch let error{
                    print("Failed to retrieve file attributes")
                    print(error)
                }
                documents.append(Document (name: file, size: documentSizeString, dateModified: documentDate!))
                documentsTableView.reloadData()
            }
        } catch let error {
            print("ERROR")
            print(error)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        documents = [Document]()
//        let fileManager = FileManager.default
//        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let path = documentsURL.path
//
//        do {
//            let files = try fileManager.contentsOfDirectory(atPath: path)
//
//            for file in files {
//                var documentSize: UInt64
//                var documentDate: Date? = nil
//                let documentPath = path + "/" + file
//                var documentSizeString: String = "0 bytes"
//
//                do {
//                    let file = try FileManager.default.attributesOfItem(atPath: documentPath)
//
//                    documentDate = file[FileAttributeKey.modificationDate] as? Date
//                    documentSize = file[FileAttributeKey.size] as! UInt64
//                    documentSizeString = "\(documentSize) bytes"
//                } catch let error{
//                    print("Failed to retrieve file attributes")
//                    print(error)
//                }
//                documents.append(Document (name: file, size: documentSizeString, dateModified: documentDate!))
//            }
//        } catch let error {
//            print("ERROR")
//            print(error)
//        }
        // Do any additional setup after loading the view.
    }
    

    
 
}
