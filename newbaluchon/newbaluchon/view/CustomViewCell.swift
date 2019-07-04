//
//  CustomViewCell.swift
//  AutocompleteSearch
//
//  Created by Fiona on 29/06/2019.
//  Copyright © 2019 Aman Aggarwal. All rights reserved.
//

import UIKit

class CustomViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        initCell()
    }

    func initCell() {
        self.layer.masksToBounds = true
        self.separatorInset = UIEdgeInsets.zero
        self.layer.cornerRadius = 5.0
        self.backgroundColor = UIColor.white.withAlphaComponent(0.4)
    }

}
