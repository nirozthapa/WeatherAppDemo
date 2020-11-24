//
//  ViewController.swift
//  WeatherMap
//
//  Created by Niroj Thapa on 11/4/20.
//



import UIKit
import SwiftSpinner

protocol ModalDelegate {
    func changeValue(value: String)
}


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,ModalDelegate {
    var citiesObj = [CityWithTempModel(id: 4163971), CityWithTempModel(id: 2147714), CityWithTempModel(id: 2174003)]
    var testValue: String = ""
    
    let serviceManager = ServiceManager()
    var delegate: ModalDelegate?
    @IBOutlet weak var tableView: UITableView!
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: "NameAndTemoeratureTableViewCell", bundle: nil), forCellReuseIdentifier: "NameAndTemoeratureTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
        print(self.citiesObj.count)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
    }
    
    func changeValue(value: String) {
        testValue = value
        let intValue = Int(testValue)
        if !self.citiesObj.contains(where: {$0.id == intValue}) {
            self.citiesObj.append(CityWithTempModel(id: intValue!))
        }
    }
    
    private func scheduleTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: false, block: { (timer) in
            self.loadData()
        })
    }
    
    func loadData()  {
        timer.invalidate()
        let group = DispatchGroup()
        SwiftSpinner.show("Please wait while updating data...")
        for var i in 0..<self.citiesObj.count{
            print(i)
            group.enter()
            serviceManager.fetchServerData(id: String(citiesObj[i].id), completion: { [self](resp,err) -> Void in
                i+=1
                if (resp != nil){
                    let serviceModel = resp as! ServiceModel
                    let obj = self.citiesObj.first(where: {$0.id == serviceModel.id!})
                    print(serviceModel)
                    obj?.serviceModel = serviceModel
                    obj?.name = serviceModel.name
                    obj?.temperature = serviceModel.main?.temp
                    DispatchQueue.main.async {
                        if self.tableView != nil{
                            self.tableView.reloadData()
                        }
                    }
                }
                else{
                    print("Data could not be retrived from source")
                }
                group.leave()
            })
            group.notify(queue: .main) {
                SwiftSpinner.hide()
                self.scheduleTimer()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.citiesObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "NameAndTemoeratureTableViewCell") as! NameAndTemoeratureTableViewCell
        cell.lblName.text = self.citiesObj[indexPath.row].name ?? "N/A"
        cell.lblTemperature.text = String(self.citiesObj[indexPath.row].temperature ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as!DetailViewController
        detailView.model = self.citiesObj[indexPath.row].serviceModel
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    
    @IBAction func searchByCities(_ sender: Any) {
        let searchView = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        searchView.delegate = self
        self.navigationController?.pushViewController(searchView, animated: true)
    }
    
    
    class CityWithTempModel {
        var id: Int!
        var name: String?
        var temperature: Float?
        var serviceModel = ServiceModel()
        
        init(id: Int) {
            self.id = id
        }
    }
    
}

