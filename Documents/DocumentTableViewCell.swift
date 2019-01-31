//
//  DocumentTableViewCell.swift
//  Documents
//
//  Created by Robert Graman on 1/30/19.
//  Copyright © 2019 Robert Graman. All rights reserved.
//

import UIKit

class DocumentTableViewCell: UITableViewCell {

    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Size: UILabel!
    @IBOutlet weak var Date: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
