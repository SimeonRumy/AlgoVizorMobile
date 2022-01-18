//
//  K.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 15/01/2022.
//

import UIKit

struct FontSizeCalculator {
    
    static var fontSize:  CGFloat {
        
        let screenHeight = UIScreen.main.bounds.size.width
        print(screenHeight)
        
        if screenHeight == 320 {
            // iPhone 5 and SE 1st Gen
            return 14
        } else if screenHeight == 414 {
            // iPhone 6+|XR|11 Pro Max| 11
            return 18
        } else if screenHeight == 390 {
            // iPhone 12|13 and 12|13 Pro
            return 17
        } else if screenHeight == 375 {
            // iPhone 6|7|X|8|xs and iPhone 12|13 mini and SE 2nd Gen and
            return 15
        } else if screenHeight == 428 {
            // iPhone 12 Pro Max | 13 pro Max
            return 20
        } else if [768, 744, 810, 820, 834].contains(screenHeight) {
            // iPad or iPad Min
            return 32
        } else if screenHeight == 1024 || screenHeight == 1112 {
            // iPadPro
            return 40
        } else {
            return 20
        }
    }
}
