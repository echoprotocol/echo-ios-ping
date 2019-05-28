//
//  Consts.swift
//  ECHOWallet
//
//  Created by PixelPlex Developer on 5/15/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import UIKit

enum Theme {
    case light, dark
}

struct Config {
    let minColorOffset: Int
    let maxColorOffset: Int
    
    let minColorSecondOffset: Int
    let maxColorSecondOffset: Int
    
    let minColorThirdOffset: Int
    
    let secondColorOffset: Int
    
    init(theme: Theme) {
        switch theme {
        case .light:
            minColorOffset = 180
            maxColorOffset = 255
            
            minColorSecondOffset = 60
            maxColorSecondOffset = 100
            
            minColorThirdOffset = 100
            
            secondColorOffset = -70
        case .dark:
            minColorOffset = 50
            maxColorOffset = 120
            
            minColorSecondOffset = 40
            maxColorSecondOffset = 100
            
            minColorThirdOffset = 100
            
            secondColorOffset = 70
        }
    }
}

enum AvatarConstants {
    static let lineWidthPercent: CGFloat = 0.07
    static let smallCirclePercent: CGFloat = 0.4
    static let mediumCirclePercent: CGFloat = 0.9
    static let bigCirclePercent: CGFloat = 1.2
    static let fadeCirclePersent: CGFloat = 1.1
}
