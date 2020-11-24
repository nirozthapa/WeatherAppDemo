//
//  OnlyLabelTableViewCell.swift
//  WeatherMap
//
//  Created by Niroj Thapa on 11/23/20.
//

import UIKit

class OnlyLabelTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
