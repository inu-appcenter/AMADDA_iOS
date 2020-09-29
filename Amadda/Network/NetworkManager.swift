//
//  NetworkManager.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/02/26.
//  Copyright © 2020 mong. All rights reserved.
//

import Alamofire

class NetworkManager {
    
    /*
     - URL : http://117.16.191.242:7005
     - 아마존 URL:  http://13.125.115.8:9000/
     */
    
    internal let baseURL = "http://117.16.191.242:7005/"
    internal let token = UserDefaults.standard.string(forKey: "token")

    
    // MARK:- User URI
    
    // 로그인
    func login(id: String, password: String, completion: @escaping (Response?) -> Void) {
        let url = baseURL + "user/login"
        
        let param = User(id: id, passwd: password)
            
        let request = AF.request(url,
                   method: .post,
                   parameters: param,
                   encoder: JSONParameterEncoder.default,
                   headers: nil)

        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):

            if let token = response.response?.allHeaderFields["token"] as? String {
                UserDefaults.standard.set(token, forKey: "token")
            }
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
            String(data: response.data!, encoding: .utf8)
        }
    }
    
    // 프로필 보기
    func seeProfile(completion: @escaping (Response?) -> Void) {
        let url = baseURL + "user/account"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let request = AF.request(url,
                   method: .post,
                   headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
                completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // 비밀번호 수정
    func modifypassword(password: String, newPassword: String, completion: @escaping (Response?) -> Void) {
        let url = baseURL + "user/passwd"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
//        let param = User(id: nil, passwd: password, newPasswd: newPassword, name: nil, major: nil, tel: nil, email: nil, flag: nil)
        let param = User(passwd: password, newPasswd: newPassword)
        
        let request = AF.request(url,
                   method: .put,
                   parameters: param,
                   encoder: JSONParameterEncoder.default,
                   headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
                completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // 프로필 수정
    func modifyProfile() {
        // 보류
    }
    
    // 임시 비밀번호 발급
    func getTempPassword(id: String, name: String, completion: @escaping (Response?) -> Void ) {
        let url = baseURL + "user/tmpPasswd"
        
//        let param = User(id: id, passwd: nil, newPasswd: nil, name: name, major: nil, tel: nil, email: nil, flag: nil)
        let param = User(id: id, name: name)
        
        let request = AF.request(url,
                   method: .post,
                   parameters: param,
                   encoder: JSONParameterEncoder.default,
                   headers: nil)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
                completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // 프로필 이미지 업로드 및 수정
    func uploadProfileImg(image: UIImage) {
        let url = baseURL + "image"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let imageData = image.jpegData(compressionQuality: 1)
        
        AF.upload(multipartFormData: { multiPart in
           multiPart.append(imageData!, withName: "user_image",fileName: "profile.jpg", mimeType: "image/jpg")
        }, to: url, method: .post, headers: header) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
            print("upload finished: \(data)")
        }).response { (response) in
            switch response.result {
            case .success(let resut):
//                print("upload success result: \(resut)")
                print("code: \(response.response?.statusCode)")
            case .failure(let err):
                print("upload err: \(err)")
            }
        }
    }
    
    // 프로필 이미지 삭제
    func deleteProfileImg() {
        let url = baseURL + "image"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let request = AF.request(url,
        method: .delete,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("프로파일 이미지 삭제 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // 회원 탈퇴
    func requestMemberSecession() {
        let url = baseURL + "user/secession"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let request = AF.request(url,
        method: .delete,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("회원 탈퇴 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- Schedule URI
    
    // 일정추가
    func addSchedule(name: String, start: String, end: String, location: String?, alarm: String?, share: Int?, memo: String?, completion: @escaping (Response?) -> Void) {
        let url = baseURL + "schedule/add"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let param = Schedule(id: nil, number: nil, schedule_name: name, start: start, end: end, location: location, alarm: alarm, share: share, key: nil, memo: memo)
        
        let request = AF.request(url,
        method: .post,
        parameters: param,
        encoder: JSONParameterEncoder.default,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("스케줄 추가 \(result)")
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // 일정 보기(세부 사항)
    func seeScheduleDetail(number: Int, completion: @escaping (Response?) -> Void) {
        let url = baseURL + "schedule/detail"
        
        let header:HTTPHeaders = [
            "token": token!
        ]

        let param = Schedule(id: nil, number: number, schedule_name: nil, start: nil, end: nil, location: nil, alarm: nil, share: nil, key: nil, memo: nil)
        
        let request = AF.request(url,
        method: .post,
        parameters: param,
        encoder: JSONParameterEncoder.default,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("스케줄 상세보기 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // 일정 수정
    func modifySchedule(number: Int, scheduleName: String, location: String?, alarm: String?, share: Int?, memo: String? ) {
        let url = baseURL + "schedule/modify"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let param = Schedule(id: nil, number: number, schedule_name: scheduleName, start: nil, end: nil, location: location, alarm: alarm, share: share, key: nil, memo: memo)
        
        let request = AF.request(url,
        method: .put,
        parameters: param,
        encoder: JSONParameterEncoder.default,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("일정 수정 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // 전체 일정 보기
    func seeAllSchedules(completion: @escaping (Response?) -> Void) {
        let url = baseURL + "schedule/show/all"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let request = AF.request(url,
        method: .get,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("모든 스케줄 보기 \(result)")
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    /// 개인 일정 보기
    func seePersonalSchedules(completion: @escaping (Response?) -> Void) {
        let url = baseURL + "schedule/show/me"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let request = AF.request(url,
        method: .get,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("개인 일정 보기 \(result)")
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    // 하루 일정 보기
    func seeTodaySchedule(completion: @escaping (Response?) -> Void) {
        let url = baseURL + "schedule/show/day"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let currentDate = formatter.string(from: date)
        let param = ["date" : currentDate]
        // 수정
        
//        let param = Schedule(id: nil, number: number, schedule_name: scheduleName, start: nil, end: nil, location: location, alarm: alarm, share: share, key: nil, memo: memo)
//
//        let request = AF.request(url,
//        method: .get,
//        parameters: param,
//        encoder: JSONParameterEncoder.default,
//        headers: header)
        
        let request = AF.request(url,
        method: .get,
        parameters: param,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            completion(result)
            print("오늘 일정 보기 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
        
    }
    
    // 주간 일정 보기
    func seeWeekSchedule(completion: @escaping (Response?) -> Void) {
        let url = baseURL + "schedule/show/week"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let currentDate = formatter.string(from: date)
        let param = ["date" : currentDate]
        
        let request = AF.request(url,
        method: .get,
        parameters: param,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("오늘 일정 보기 \(result)")
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // 월간 일정 보기
    func seeMonthSchedule(completion: @escaping (Response?) -> Void) {
        let url = baseURL + "schedule/show/month"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let request = AF.request(url,
        method: .get,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("월간 일정 보기 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // 그룹 일정 보기
    func seeGroupSchedule(share: Int, completion: @escaping (Response?) -> Void) {
        let url = baseURL + "schedule/show/group"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let param = ["share" : share]
        let request = AF.request(url,
        method: .get,
        parameters: param,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("그룹 일정 보기 \(result)")
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // 일정 삭제
    func deleteSchedule(number: Int) {
        let url = baseURL + "schedule/delete"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let param = Schedule(id: nil, number: number, schedule_name: nil, start: nil, end: nil, location: nil, alarm: nil, share: nil, key: nil, memo: nil)
        
        let request = AF.request(url,
        method: .delete,
        parameters: param,
        encoder: JSONParameterEncoder.default,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("스케줄 삭제 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- 그룹
    func showGroupList(completion: @escaping (Response?) -> Void) {
        let url = baseURL + "share/groups/show"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let request = AF.request(url,
        method: .get,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("그룹 리스트 \(result)")
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    func showGroupMember(share: Int?, completion: @escaping (Response?) -> Void) {
        if share == nil {
            print("##Share nil")
            return
        }
        let url = baseURL + "share/group/member"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let param = ["share" : share]
        let request = AF.request(url,
        method: .get,
        parameters: param,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("그룹 멤버 리스트 \(result)")
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- 초대
    func showInvitation(completion: @escaping () -> Void) {
        let url = baseURL + "share/invitations/show"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let request = AF.request(url,
        method: .get,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("초대 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // MARK:- 강의 검색
    func searchLecture(name: String, completion: @escaping () -> Void) {
        let url = baseURL + "time/table/search" + "?name=\(name)"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let request = AF.request(url,
        method: .get,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("강의 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
}

