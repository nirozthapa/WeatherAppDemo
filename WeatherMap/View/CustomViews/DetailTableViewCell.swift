//
//  DetailTableViewCell.swift
//  WeatherMap
//
//  Created by Niroj Thapa on 11/23/20.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var mainSummary: UILabel!
    @IBOutlet weak var humidity: UILabel!

    @IBOutlet weak var pressure: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
