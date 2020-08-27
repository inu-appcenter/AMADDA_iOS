//
//  Schedule.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/02/27.
//  Copyright © 2020 mong. All rights reserved.
//
import Foundation

public enum language {
    case korean
    case rawValue
}
public enum time {
    case startDay
    case startTime
    case startALL
    case endDay
    case endTime
    case endALL
    case onlyTime
    case ALL
}

struct Schedule: Codable {
    
    let id: String?
    let number: Int?
    let schedule_name: String?
    let start: String?
    let end: String?
    let location: String?
    let alarm: String?
    let share: Int?
    let key: Int?
    let memo: String?
    
    var scheduleTime: Float {
        get {
            // 오전, 시간:분
            let startTimeArray = start!.components(separatedBy: " ")
            var startHourArray = startTimeArray[1].components(separatedBy: ":")
//            if startHourArray[0] == "12" {
//                startHourArray[0] = "00"
//            }
            var startHour: Float = Float(startHourArray[0])! * 60 + Float(startHourArray[1])!
            
            // 오전, 시간:분
            let endTimeArray = end!.components(separatedBy: " ")
            var endHourArray = endTimeArray[1].components(separatedBy: ":")
//            if endHourArray[0] == "12" {
//                endHourArray[0] == "00"
//            }
            var endHour: Float = Float(endHourArray[0])! * 60 + Float(endHourArray[1])!
            
            var courseTime: Float = startHour - endHour
            // 시작시간과 종료시간의 오전,오후가 서로 다르면 12시간 추가, 같으면 어차피 같이 빼지므로 시간만 비교
//            if startTimeArray[0] != endTimeArray[0] {
//                courseTime += 12 * 60
//            }
            return courseTime / 60
        }
    }
    /// 요일을 나타냅니다. -1일시 값 오류
    var day: Int {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let todayDate = formatter.date(from: start!) else { return -1 }
        formatter.dateFormat = "yyyy-MM-dd"
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate) - 1
        return weekDay
    }
    
    // 만들다 맘.
    var startIndexPath: Int {
        get {
            var startTimeArray = start!.components(separatedBy: " ")
            startTimeArray = startTimeArray[1].components(separatedBy: ":")
            let startTime = startTimeArray[0]
            
            switch startTime {
            case "09":
                return 0
            case "10":
                return 1
            case "11":
                return 2
            case "12":
                return 3
            case "13":
                return 4
            case "14":
                return 5
            case "15":
                return 6
            case "16":
                return 7
            case "17":
                return 8
            case "18":
                return 9
            case "19":
                return 10
            case "20":
                return 11
            case "21":
                return 12
            default:
                return -1
            }
        }
    }
    /// 시작과 끝 날짜의 시간을 제외한 날짜를 반환합니다.
    public func getDate(time: time) -> String {
        guard let startDate = start?.components(separatedBy: " ")else {return ""}
        guard let endDate = end?.components(separatedBy: " ")else {return ""}
        let startDay = startDate[0]
        let startTime = startDate[1]
        let endDay = endDate[0]
        let endTime = endDate[1]
        
        switch time{
        case .startDay:
            return startDay
        case .startTime:
            return changekoreanDate(stringDate: start!, format: .startTime)
        case .startALL:
            return changekoreanDate(stringDate: start!, format: .startALL)
        case .endDay:
            return endDay
        case .endTime:
            return changekoreanDate(stringDate: end!, format: .endTime)
        case .endALL:
            return changekoreanDate(stringDate: end!, format: .endALL)
        case .onlyTime:
            return "\(changekoreanDate(stringDate: start!, format: .startTime)) ~ \(changekoreanDate(stringDate: end!, format: .endTime))"
        case .ALL:
            return "\(changekoreanDate(stringDate: start!, format: .startALL)) ~ \(changekoreanDate(stringDate: end!, format: .endALL))"
        }
    }
    
    private func changekoreanDate(stringDate: String, format: time) -> String {
        // 기존 날짜 date로 변환
        let dateString:String = stringDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = .init(identifier: "ko")
        let date:Date = dateFormatter.date(from: dateString)!
        
        // date로 변환된 날짜 형식 변경
        switch format{
        case .startTime, .endTime:
            dateFormatter.dateFormat = "a hh:mm:ss"
        default:
            dateFormatter.dateFormat = "yyyy-MM-dd a hh:mm:ss"
        }
        return dateFormatter.string(from: date)
    }
}
