//
//  SearchViewController.swift
//  WeatherMap
//
//  Created by Niroj Thapa on 11/5/20.
//

import Foundation
import UIKit
import SwiftyJSON

struct CityModel {
    var id: Int
    var name: String
}

class SearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate , UISearchResultsUpdating , UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var delegate: ModalDelegate?
    var testValue: String = ""
    let serviceManager = ServiceManager()
    var serviceModel = ServiceModel()
    
    
    var dataArray = [CityModel]()
    var filteredArray = [CityModel]()
    var shouldShowSearchResults = false
    var searchController: UISearchController!
    
    
    override func viewDidLoad() {
        self.loadCities()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadCities(){
        // Specify the path to the countries list file.
        self.dataArray = []
        let pathToFile = Bundle.main.path(forResource: "cityList", ofType: "json")
        
        if let path = pathToFile {
            // Load the file contents as a string.
            
            do{
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [Dictionary<String, AnyObject>] {
                    for item in jsonResult {
                        if let name = item["name"] as? String, let id = item["id"] as? Int{
                            if !self.dataArray.contains(where: {$0.id == id}) {
                                let cityObj = CityModel(id: id, name: name)
                                self.dataArray.append(cityObj)
                            }
                        }
                    }
                    print("Data array = \(dataArray)")
                }
            }
            catch{
                print("try-catch error is catched!!")
            }
            self.tableView.reloadData()
        }
        
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        
        self.tableView.register(UINib(nibName: "OnlyLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "OnlyLabelTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableHeaderView = searchController.searchBar
    }
    //MARK:- table datasource
    //MARK:-
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return dataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityId = String(self.dataArray[indexPath.row].id)
        navivateParentView(id: cityId)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnlyLabelTableViewCell", for: indexPath) as! OnlyLabelTableViewCell
        
        if shouldShowSearchResults {
            cell.lblTitle?.text = filteredArray[indexPath.row].name
        }
        else {
            cell.lblTitle?.text = dataArray[indexPath.row].name
        }
        
        return cell
    }
    
    //MARK:- search update delegate
    //MARK:-
    
    public func updateSearchResults(for searchController: UISearchController){
        let searchString = searchController.searchBar.text
        
        // Filter the data array and get only those countries that match the search text.
        
        filteredArray = dataArray.filter({ (city) -> Bool in
            let countryText: NSString = city.name as NSString
            return (countryText.range(of: searchString!, options: .caseInsensitive).location) != NSNotFound
        })
        tableView.reloadData()
    }
    
    //MARK:- search bar delegate
    //MARK:-
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }

    func navivateParentView(id:String){
        
        DispatchQueue.main.async {
            if let delegate = self.delegate {
                delegate.changeValue(value: id)
            }
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.popViewController(animated: true)
            self.searchController.dismiss(animated: true, completion: nil)

            
        }
    }
}
