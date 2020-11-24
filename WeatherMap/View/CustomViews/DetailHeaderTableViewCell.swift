//
//  DetailHeaderTableViewCell.swift
//  WeatherMap
//
//  Created by Niroj Thapa on 11/24/20.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCloudStatus: UILabel!
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblMinTemp: UILabel!
    @IBOutlet weak var lblMaxTEmp: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
