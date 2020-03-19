//
//  Function.swift
//  Amadda
//
//  Created by mong on 2020/03/19.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation

/// 시작, 종료 시간을 비교하기 위한 tag값을 생성합니다. ex) 오후 3시 25분 -> 1200 + 300 + 25
func timeLabelTagValue(sunPosition: String, hour: String, minute: String) -> Int {
    func sunPositionValue(sunPosition: String) -> Int {
        switch sunPosition {
        case "오전":
            return 0
        case "오후":
            return 1200
        default:
            return 0
        }
    }
    return sunPositionValue(sunPosition: sunPosition) + Int(hour)! * 100 + Int(minute)!
    
}
