//
//  Pizza.swift
//  Game
//
//  Created by 남경민 on 2022/12/17.
//

import Foundation

struct Pizza {
    var state: String
    var imageName: String
    var timerCounting: Bool
    var count: Int
    var returnFlag: Bool
    var timer: Timer
    
    init() {
        
        self.state = "시작"
        self.imageName = ""
        self.timerCounting = false
        self.count = 0
        self.returnFlag = false
        self.timer = Timer()
        
    }
}

