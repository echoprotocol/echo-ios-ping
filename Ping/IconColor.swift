//
//  IconColor.swift
//  ECHOWallet
//
//  Created by PixelPlex Developer on 5/15/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import UIKit

struct IconColor {
    let config: Config
    var rgb: UIColor {
        return UIColor(
            red: CGFloat(colorsDictionary["r"]!) / 255.0,
            green: CGFloat(colorsDictionary["g"]!) / 255.0,
            blue: CGFloat(colorsDictionary["b"]!) / 255.0,
            alpha: 1.0
        )
    }
    
    var lineRGB: UIColor {
        return UIColor(
            red: CGFloat(lineColorsDictionary["r"]!) / 255.0,
            green: CGFloat(lineColorsDictionary["g"]!) / 255.0,
            blue: CGFloat(lineColorsDictionary["b"]!) / 255.0,
            alpha: 1.0
        )
    }
    
    init(nameNumber: NameNumbers) {
        self.config = Config(theme: nameNumber.themeFactor)
        
        let colors = ["r", "g", "b"].shuffle(by: nameNumber.shuffleArrayFactor)
        
        let firstColorOffset = getPseudoRandomInt(min: config.minColorOffset,
                                                  max: config.maxColorOffset,
                                                  factor: nameNumber.colorFactors[0])
        let secondColorOffset = getPseudoRandomInt(min: config.minColorSecondOffset,
                                                   max: config.maxColorSecondOffset,
                                                   factor: nameNumber.colorFactors[1])
        let thirdColorOffset = getPseudoRandomInt(min: 0,
                                                  max: firstColorOffset - config.minColorThirdOffset,
                                                  factor: nameNumber.colorFactors[2])
        
        colorsDictionary = [
            colors[0]: firstColorOffset,
            colors[1]: max(0, firstColorOffset - secondColorOffset),
            colors[2]: max(0, thirdColorOffset)
        ]
        
        lineColorsDictionary = [
            colors[0]: colorsDictionary[colors[0]]! + config.secondColorOffset,
            colors[1]: colorsDictionary[colors[1]]! + config.secondColorOffset,
            colors[2]: colorsDictionary[colors[2]]! + config.secondColorOffset
        ]
    }
    
    private var colorsDictionary: [String: Int]
    private var lineColorsDictionary: [String: Int]
}

extension Array {
    
    func shuffle(by factor: [Int]) -> [Element] {
        return self
            .enumerated()
            .map({ (iteractor) -> Element in
                
                let index = iteractor.offset
                return self[factor[index]]
            })
    }
}
