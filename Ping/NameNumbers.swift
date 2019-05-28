//
//  NameNumbers.swift
//  ECHOWallet
//
//  Created by PixelPlex Developer on 5/15/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

struct NameNumbers {
    
    let themeFactor: Theme
    let shuffleArrayFactor: [Int]
    let colorFactors: [Int]
    let angleFactors: [Int]
    
    init(name: String) {
        let hash = name.sha1()
        
        themeFactor = (parseInt(hash[0...3]) > (0xffff / 2)) ? .light : .dark
        shuffleArrayFactor = [0, 1, 2]
            .enumerated()
            .map { (iteractor) -> [Int] in
                let index = iteractor.offset
                let lowerBound = 4 + 2 * index
                let upperBound = 6 + 2 * index
                return [index, parseInt(hash[lowerBound...upperBound])]
            }
            .sorted { (lhs, rhs) -> Bool in
                return lhs[1] < rhs[1]
            }
            .map { element -> Int in
                return element[0]
        }
        
        colorFactors = [
            parseInt(hash[10...13]),
            parseInt(hash[14...17]),
            parseInt(hash[18...21])
        ]
        
        angleFactors = [
            parseInt(hash[22...25]),
            parseInt(hash[26...29]),
            parseInt(hash[30...33]),
            parseInt(hash[34...37])
        ]
    }
}
