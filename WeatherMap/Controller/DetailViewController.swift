//
//  DetailViewController.swift
//  WeatherMap
//
//  Created by Niroj Thapa on 11/23/20.
//


import Foundation
import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var model = ServiceModel()
    
    @IBOutlet weak var detailTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
        self.detailTableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        self.detailTableView.register(UINib(nibName: "DetailHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailHeaderTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = self.detailTableView.dequeueReusableCell(withIdentifier: "DetailHeaderTableViewCell") as! DetailHeaderTableViewCell
            cell.lblCloudStatus.text =  self.model.weather![0].main ?? "N/A"
            cell.lblMinTemp.text =  String(self.model.main?.temp_min ?? 0)
            cell.lblMaxTEmp.text =  String(self.model.main?.temp_max ?? 0)
            cell.lblCity.text = self.model.name ?? "N/A"
            
            return cell
        default:
            let cell = self.detailTableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell") as! DetailTableViewCell
            cell.humidity.text = String(self.model.main?.humidity ?? 0)
            cell.pressure.text = String(self.model.main?.presssure ?? 0)
            cell.mainSummary.text = self.model.weather![0].main
            
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
