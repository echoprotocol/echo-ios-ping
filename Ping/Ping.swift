//
//  Ping.swift
//  ECHOWallet
//
//  Created by PixelPlex Developer on 5/15/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import UIKit

class Ping {
    
    let userNumbers: NameNumbers
    let iconSize: CGFloat
    
    let color: IconColor
    let smallCircleRadius: CGFloat
    let circleLineWidth: CGFloat
    var smallCircleCenter: CGPoint = .zero
    
    let mediumCircleRadius: CGFloat
    var mediumCircleCenter: CGPoint = .zero
    var mediumCircleAngle: CGFloat = 0.0
    
    let bigCircleRadius: CGFloat
    var bigCircleCenter: CGPoint = .zero
    var bigCircleAngle: CGFloat = 0.0
    
    let fadeCircleRadius: CGFloat
    var fadeCircleCenter: CGPoint = .zero
    var fadeCircleAngle: CGFloat = 0
    
    init(name: String, size: CGFloat) {
        
        self.userNumbers = NameNumbers(name: name)
        self.iconSize = size
        
        self.color = IconColor(nameNumber: userNumbers)
        
        self.smallCircleRadius =  size * AvatarConstants.smallCirclePercent / 2
        self.circleLineWidth = size * AvatarConstants.lineWidthPercent
        self.mediumCircleRadius = size * AvatarConstants.mediumCirclePercent / 2
        self.bigCircleRadius = size * AvatarConstants.bigCirclePercent / 2
        self.fadeCircleRadius = size * AvatarConstants.fadeCirclePersent / 2
        self.smallCircleCenter = getSmallCircleCenter()
        self.mediumCircleCenter = getMediumCircleCenter()
        self.bigCircleCenter = getBigCircleCenter()
        self.fadeCircleCenter = getFadeCircleCenter()
    }
    
    func getSmallCircleCenter() -> CGPoint {
        let xValue = getPseudoRandom(min: iconSize * 0.1, max: iconSize * 0.9, factor: CGFloat(userNumbers.angleFactors[0]))
        let yValue = getPseudoRandom(min: iconSize * 0.1, max: iconSize * 0.9, factor: CGFloat(userNumbers.angleFactors[0]))
        return CGPoint(x: xValue, y: yValue)
    }
    
    func getMediumCircleCenter() -> CGPoint {
        let offset = mediumCircleRadius - smallCircleRadius
        let range = getAngleRange(squareWidth: iconSize, r: offset * 2, center: smallCircleCenter)
        mediumCircleAngle = getPseudoRandom(min: range[0], max: range[1], factor: CGFloat(userNumbers.angleFactors[1]))
        let point = CGPoint(x: CGFloat(cos(Double(mediumCircleAngle))) * offset + smallCircleCenter.x,
                            y: CGFloat(sin(Double(mediumCircleAngle))) * offset + smallCircleCenter.y)
        mediumCircleCenter = point
        return point
    }
    
    func getBigCircleCenter() -> CGPoint {
        let offset = bigCircleRadius - smallCircleRadius
        let range = getAngleRange(squareWidth: iconSize, r: offset, center: smallCircleCenter)
        bigCircleAngle = getPseudoRandom(min: range[0], max: range[1], factor: CGFloat(userNumbers.angleFactors[2]))
        
        let value = mediumCircleAngle > bigCircleAngle ? mediumCircleAngle - bigCircleAngle : bigCircleAngle - mediumCircleAngle
        var angeDiff = abs(value)
        
        if angeDiff > CGFloat.pi {
            angeDiff = CGFloat.pi * 2 - angeDiff
        }
        
        if angeDiff < CGFloat.pi / 4 {
            let needAdd = CGFloat.pi / 4 - angeDiff
            if bigCircleAngle > mediumCircleAngle {
                bigCircleAngle += needAdd
            } else {
                bigCircleAngle -= needAdd
            }
        }
        
        let point = CGPoint(x: CGFloat(cos(bigCircleAngle)) * offset + smallCircleCenter.x,
                            y: CGFloat(sin(bigCircleAngle)) * offset + smallCircleCenter.y)
        
        bigCircleCenter = point
        
        return point
    }
    
    func getFadeCircleCenter() -> CGPoint {
        let offset = fadeCircleRadius - smallCircleRadius
        let range = getAngleRange(squareWidth: iconSize, r: offset * 0.7, center: smallCircleCenter)
        fadeCircleAngle = getPseudoRandom(min: range[0], max: range[1], factor: CGFloat(userNumbers.angleFactors[3]))
        
        let point = CGPoint(x: CGFloat(cos(fadeCircleAngle)) * offset + smallCircleCenter.x,
                            y: CGFloat(sin(fadeCircleAngle)) * offset + smallCircleCenter.y)
        
        fadeCircleCenter = point
        return point
    }
    
    func getAngleRange(squareWidth: CGFloat, r: CGFloat, center: CGPoint) -> [CGFloat] {
        var result: [CGFloat] = [0.0, 4 * CGFloat.pi]
        
        if squareWidth - center.x < r {
            let alpha = CGFloat(acos((squareWidth - center.x) / r))
            result[0] = alpha
            result[1] = CGFloat.pi * 2 - alpha
        }
        
        if squareWidth - center.y < r {
            let alpha = CGFloat(acos((squareWidth - center.y) / r))
            result[0] = max(result[0], CGFloat.pi / 2 + alpha)
            result[1] = min(result[1], 5 * CGFloat.pi / 2 - alpha)
        }
        
        if center.x < r {
            let alpha = CGFloat(acos(center.x / r))
            result[0] = max(CGFloat.pi + alpha, result[0])
            result[1] = min(3 * CGFloat.pi - alpha, result[1])
        }
        
        if center.y < r {
            let alpha = CGFloat(acos(center.y / r))
            if squareWidth - center.x >= r {
                result[0] = max(CGFloat.pi * 3 / 2 + alpha, result[0])
            }
            if result[1] < CGFloat.pi * 2 {
                result[1] += CGFloat.pi * 2
            }
            result[1] = min(CGFloat.pi * 7 / 2 - alpha, result[1])
        }
        
        if result[0] < result[1] - CGFloat.pi * 2 {
            result[1] -= CGFloat.pi * 2
        }
        
        return result
    }
}
