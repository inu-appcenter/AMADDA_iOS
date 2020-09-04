//
//  Response.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/02/26.
//  Copyright © 2020 mong. All rights reserved.
//

struct Response: Codable {
    let success: Bool?
    let message: String?
    let user: User?
    let schedule: Schedule?
    let schedules: [Schedule]?
    let groups: [Group]?
    let members: [Member]?
}

