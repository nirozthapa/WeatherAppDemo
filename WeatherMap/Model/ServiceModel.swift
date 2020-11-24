//
//  ServiceModel.swift
//  WeatherMap
//
//  Created by Niroj Thapa on 11/4/20.
//

import Foundation
class ServiceModel:NSObject,Codable{
    var ccord: Coordinates?
    var weather:[WeatherDescriptions]?
    var base: String?
    var main : MainDescription?
    var visibility: Int?
    var wind: WindDetails?
    var cloud:CloudDetails?
    var dt:Int?
    var sys: SystemDetails?
    var timezone:Int?
    var id:Int?
    var name: String?
    var cod:Int?
    
    class Coordinates:NSObject,Codable{
        var lon:Float?
        var lat: Float?
    }
    
    class WeatherDescriptions: NSObject,Codable{
        var id: Int?
        var main: String?
        var _description: String?
        var icon: String?
    }
    
    class MainDescription:NSObject,Codable{
        var temp: Float?
        var feels_like: Float?
        var temp_min:Float?
        var temp_max:Float?
        var presssure: Int?
        var humidity: Int?
    }
    
    class WindDetails:NSObject,Codable{
        var speed: Float?
        var deg: Int?
    }
    
    class CloudDetails:NSObject,Codable{
        var all:Int?
    }
    
    class SystemDetails: NSObject,Codable{
        var type:Int?
        var id: Int?
        var country: String?
        var sunrise: Double?
        var sunset: Double?
    }
    
    
    
}
