//
//  User.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/02/26.
//  Copyright © 2020 mong. All rights reserved.
//

struct User: Codable {
    let token: String?
    let id: String?
    let passwd: String?
    let newPasswd: String?
    let name: String?
    let email: String?
    let user_image: String?
    let flag: Int?
}
