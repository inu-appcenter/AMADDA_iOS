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
