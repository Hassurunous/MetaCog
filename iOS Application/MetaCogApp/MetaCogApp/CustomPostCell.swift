//
//  CustomPostCell.swift
//  MetaCogApp
//
//  Created by Guti on 10/20/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit

class CustomPostCell: UITableViewCell {
    
    var titlePost: String?
    var contentPost: String?
    var comments: [String]?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
