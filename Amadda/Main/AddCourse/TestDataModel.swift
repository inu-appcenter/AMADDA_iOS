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
        Course(subject: "아이덴티티디자인", prof: "디자인", day: "4", startTime: "1", endTime: "3", place: "SQ999"),
        Course(subject: "UI/UX", prof: "디자인", day: "1", startTime: "2", endTime: "4", place: "SQ888")
        ]
}
struct ComputerScience {
    let major = "컴퓨터공학부"
    let courseList: [Course] = [
        Course(subject: "웹프로그래밍", prof: "채진석", day: "2", startTime: "5", endTime: "8", place: "SM222"),
        Course(subject: "디지털공학", prof: "김우일", day: "1", startTime: "1", endTime: "7", place: "SM444")
        ]
}

struct Course: Codable {
    var subject: String
    var professor: String
    var day: String
    var startTime: String
    var endTime: String
    var place: String
    
    init(subject: String, prof: String, day: String, startTime: String, endTime: String, place: String) {
        self.subject = subject
        self.professor = prof
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
        self.place = place
    }
    var timeAndPlace: String {
        return "\(startTime)~\(endTime) \(place)"
    }
    /// time형식 "aa HH:mm" 일때만 사용 가능
    var courseTime: Float {
        get {
            // 오전, 시간:분
            let startTimeArray = startTime.components(separatedBy: " ")
            var startHourArray = startTimeArray[1].components(separatedBy: ":")
            if startHourArray[0] == "12" {
                startHourArray[0] = "00"
            }
            var startHour: Float = Float(startHourArray[0])! * 60 + Float(startHourArray[1])!
            
            // 오전, 시간:분
            var endTimeArray = endTime.components(separatedBy: " ")
            if endTimeArray[0] == "12" {
                endTimeArray[0] == "00"
            }
            let endHourArray = endTimeArray[1].components(separatedBy: ":")
            var endHour: Float = Float(endHourArray[0])! * 60 + Float(endHourArray[1])!
            
            var courseTime: Float = startHour - endHour
            // 시작시간과 종료시간의 오전,오후가 서로 다르면 12시간 추가, 같으면 어차피 같이 빼지므로 시간만 비교
            if startTimeArray[0] != endTimeArray[0] {
                courseTime += 12 * 60
            }
            return courseTime / 60
        }
    }
    // 만들다 맘.
    var startIndexPath: Int {
        get {
            var startTimeArray = startTime.components(separatedBy: " ")
            let startTimeSunPosition = startTimeArray[0]
            startTimeArray = startTimeArray[1].components(separatedBy: ":")
            
            if startTimeSunPosition == "오전" {
                switch startTimeArray[0] {
                case "09":
                    return 0
                case "10":
                    return 1
                case "11":
                    return 2
                default:
                    return -1
                }
            }else {
                switch startTimeArray[0] {
                case "12":
                    return 3
                case "01":
                    return 4
                case "02":
                    return 5
                case "03":
                    return 6
                case "04":
                    return 7
                case "05":
                    return 8
                case "06":
                    return 9
                case "07":
                    return 10
                case "08":
                    return 11
                case "09":
                    return 12
                default:
                    return -1
                }
            }
        }
    }
    func dayString() -> String {
        switch day {
        case "1":
            return "월"
        case "2":
            return "화"
        case "3":
            return "수"
        case "4":
            return "목"
        case "5":
            return "금"
        default:
            return "err day value"
        }
    }
}
