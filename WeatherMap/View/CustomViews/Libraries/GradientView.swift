//
//  GradientView.swift
//  WeatherMap
//
//  Created by Niroj Thapa on 11/23/20.
//


import Foundation
import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
            
        }
    }
    
    @IBInspectable var startColor:    UIColor = .clear  { didSet { updateColors() }}
    @IBInspectable var centerColor:   UIColor = .clear  { didSet { updateColors() }}
    @IBInspectable var endColor:      UIColor = .clear  { didSet { updateColors() }}
    @IBInspectable var angle:         CGFloat =   0     { didSet { calculatePoints(for: angle)}}
    @IBInspectable var startLocation: Double =   0.05   { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95   { didSet { updateLocations() }}
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, centerColor.cgColor, endColor.cgColor]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calculatePoints(for: angle)
        updateLocations()
        updateColors()
    }
    
    /// Sets the start and end points on a gradient layer for a given angle.
    ///
    /// - Important:
    /// *0°* is a horizontal gradient from left to right.
    ///
    /// With a positive input, the rotational direction is clockwise.
    ///
    ///    * An input of *400°* will have the same output as an input of *40°*
    ///
    /// With a negative input, the rotational direction is clockwise.
    ///
    ///    * An input of *-15°* will have the same output as *345°*
    ///
    /// - Parameters:
    ///     - angle: The angle of the gradient.
    ///
    public func calculatePoints(for angle: CGFloat) {
        
        
        var ang = (-angle).truncatingRemainder(dividingBy: 360)
        
        if ang < 0 { ang = 360 + ang }
        
        let n: CGFloat = 0.5
        
        switch ang {
            
        case 0...45, 315...360:
            let a = CGPoint(x: 0, y: n * tanx(ang) + n)
            let b = CGPoint(x: 1, y: n * tanx(-ang) + n)
            gradientLayer.startPoint = a
            gradientLayer.endPoint = b
            
        case 45...135:
            let a = CGPoint(x: n * tanx(ang - 90) + n, y: 1)
            let b = CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
            gradientLayer.startPoint = a
            gradientLayer.endPoint = b
            
        case 135...225:
            let a = CGPoint(x: 1, y: n * tanx(-ang) + n)
            let b = CGPoint(x: 0, y: n * tanx(ang) + n)
            gradientLayer.startPoint = a
            gradientLayer.endPoint = b
            
        case 225...315:
            let a = CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
            let b = CGPoint(x: n * tanx(ang - 90) + n, y: 1)
            gradientLayer.startPoint = a
            gradientLayer.endPoint = b
            
        default:
            let a = CGPoint(x: 0, y: n)
            let b = CGPoint(x: 1, y: n)
            gradientLayer.startPoint = a
            gradientLayer.endPoint = b
            
        }
    }
    
    /// Private function to aid with the math when calculating the gradient angle
    private func tanx(_ 𝜽: CGFloat) -> CGFloat {
        return tan(𝜽 * CGFloat.pi / 180)
    }
    
}
