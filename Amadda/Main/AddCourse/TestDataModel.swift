//
//  TestDataModel.swift
//  Amadda
//
//  Created by mong on 2020/02/27.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation

let courseType = ["교양필수","교양선택","전공","기타"]
let liberalArtsMust = ["INU핵심창의융합","INU핵심리더십","INU핵심문제해결","INU핵심의사소통","INU핵심글로벌"]
let liberalArtsChoice = ["과학과기술","역사와문화","인간과사회","INU인성","언어와문학","예술과스포츠"]
let major = ["디자인학부","정보통신공학과","컴퓨터공학부"]

struct Design {
    let major = "디자인학부"
    let courseList: [Course] = [
        Course(subject: "아이덴티티디자인", day: "4", startTime: "1", endTime: "3", place: "SQ999"),
        Course(subject: "UI/UX", day: "1", startTime: "2", endTime: "4", place: "SQ888")
        ]
}
struct ComputerScience {
    let major = "컴퓨터공학부"
    let courseList: [Course] = [
        Course(subject: "웹프로그래밍", day: "2", startTime: "5", endTime: "8", place: "SM222"),
        Course(subject: "디지털공학", day: "1", startTime: "1", endTime: "7", place: "SM444")
        ]
}

struct Course {
    var subject: String
    var day: String
    var startTime: String
    var endTime: String
    var place: String
    
    init(subject: String, day: String, startTime: String, endTime: String, place: String) {
        self.subject = subject
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
        self.place = place
    }
}
