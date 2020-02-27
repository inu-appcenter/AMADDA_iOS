//
//  Schedule.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/02/27.
//  Copyright © 2020 mong. All rights reserved.
//

struct Schedule: Codable {
    let token: String?
    let name: String?
    let start: String?
    let end: String?
    let location: String?
    let alarm: String?
    let share: Int?
    let memo: String?
}
