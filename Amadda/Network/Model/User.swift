//
//  User.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/02/26.
//  Copyright © 2020 mong. All rights reserved.
//

struct User: Codable {
    let id: String?
    let passwd: String?
    let newPasswd: String?
    let name: String?
    let major: String?
    let tel: String?
    let email: String?
    let path: String?
    let invite: Int?
    let user_image: String?
    let flag: Int?
    
    init(id: String? = nil, name: String? = nil, email: String? = nil, path: String? = nil, invite: Int? = nil, passwd: String? = nil, newPasswd: String? = nil, major: String? = nil, tel: String? = nil, userImage: String? = nil, flag: Int? = nil){
        self.id = id
        self.name = name
        self.email = email
        self.path = path
        self.invite = invite
        
        self.passwd = passwd
        self.newPasswd = newPasswd
        self.major = major
        self.tel = tel
        self.user_image = userImage
        self.flag = flag
    }
 
}
