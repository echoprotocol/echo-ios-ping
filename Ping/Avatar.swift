//
//  Avatar.swift
//  ECHOWallet
//
//  Created by PixelPlex Developer on 5/14/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import UIKit

func parseInt(_ int: String) -> Int {
    return Int(int, radix: 16)!
}

func getPseudoRandomInt(min: Int, max: Int, factor: Int) -> Int {
    return Int(getPseudoRandom(min: CGFloat(min), max: CGFloat(max), factor: CGFloat(factor)))
}

func getPseudoRandom(min: CGFloat, max: CGFloat, factor: CGFloat) -> CGFloat {
    return factor / 0xffff * (max - min) + min
}

public extension UIImage {
    
    static func drawAvatar(name: String, size: CGFloat) -> UIImage {
        let ping = Ping(name: name, size: size)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size, height: size), true, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        context.saveGState()
        
        ping.color.rgb.setFill()
        UIRectFill(CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        
        drawCircle(arcCenter: ping.smallCircleCenter,
                   radius: ping.smallCircleRadius,
                   lineWidth: ping.circleLineWidth,
                   stokeColor: ping.color.lineRGB,
                   context: context)
        drawCircle(arcCenter: ping.mediumCircleCenter,
                   radius: ping.mediumCircleRadius,
                   lineWidth: ping.circleLineWidth,
                   stokeColor: ping.color.lineRGB,
                   context: context)
        drawCircle(arcCenter: ping.fadeCircleCenter,
                   radius: ping.fadeCircleRadius,
                   lineWidth: 0.0,
                   stokeColor: .clear,
                   fillColor: ping.color.lineRGB,
                   alpha: 0.7,
                   context: context)
        drawCircle(arcCenter: ping.bigCircleCenter,
                   radius: ping.bigCircleRadius,
                   lineWidth: ping.circleLineWidth,
                   stokeColor: .white,
                   context: context)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        
        context.restoreGState()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    private static func drawCircle(arcCenter: CGPoint, radius: CGFloat, lineWidth: CGFloat,
                                   stokeColor: UIColor, fillColor: UIColor? = .clear, alpha: CGFloat? = 1.0, context: CGContext) {
        let path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        if let fillColor = fillColor, fillColor != .clear {
            let color = fillColor.withAlphaComponent(alpha ?? 1.0)
            color.setFill()
        } else {
            fillColor?.setFill()
        }
        stokeColor.setStroke()
        path.lineWidth = lineWidth
        path.stroke()

        context.addPath(path.cgPath)
        context.drawPath(using: .fillStroke)
    }
}
