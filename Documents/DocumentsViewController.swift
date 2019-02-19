//
//  DocumentsViewController.swift
//  Documents
//
//  Created by Robert Graman on 1/31/19.
//  Copyright © 2019 Robert Graman. All rights reserved.
//

import UIKit
import CoreData


class DocumentsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    var documents2 = [Doc]()
    let dateFormatter = DateFormatter()

    @IBOutlet weak var documentsTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents2.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "documentCell", for:indexPath)
        dateFormatter.dateFormat = "MMMM d, yyyy HH:mm"
        if let cell = cell as? DocumentsTableViewCell{
            let document = documents2[indexPath.row]
            cell.fileName.text = document.title
            cell.fileSize.text = document.fileSize
            cell.fileDate.text = dateFormatter.string(from: document.dateMod! as Date)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete"){ (action, indexPath) in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            let document = self.documents2[indexPath.row]
            managedContext.delete(document)
            do{
                try managedContext.save()
            }catch{
                print("Error")
                self.documentsTableView.reloadData()
            }
            
            self.documents2.remove(at: indexPath.row)
            self.documentsTableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("ghjhghj")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditorViewController,
            let row = documentsTableView.indexPathForSelectedRow?.row {
            
            if (segue.identifier == "add") {
                destination.document2 = nil
            } else {
                destination.document2 = documents2[row]
            }
            destination.document2 = segue.identifier == "add" ? nil : documents2[row]
            
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<Doc> = Doc.fetchRequest()
        do{
            documents2 = try managedContext.fetch(fetchRequest)
        }
        catch{
            print("fetch failed.")
        }
        documentsTableView.reloadData()
        
    }
}
