//
//  ServiceManager.swift
//  WeatherMap
//
//  Created by Niroj Thapa on 11/4/20.
//

import Foundation

import Foundation
import UIKit
class ServiceManager {
    func fetchServerData(id: String,completion: @escaping responseBlock) {
        guard let gitUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=\(id)&units=metric&APPID=a175db5717590070d4b8132341ac6c72") else { return }
             URLSession.shared.dataTask(with: gitUrl) { (data, response
                 , error) in
                 guard let data = data else { return }
                 do {
                     let decoder = JSONDecoder()
                     let data = try decoder.decode(ServiceModel.self, from: data)
                    completion(data,error)
                     
                 } catch let err {
                    completion(response,error)

                 }
                 }.resume()
    }
    
    
}
