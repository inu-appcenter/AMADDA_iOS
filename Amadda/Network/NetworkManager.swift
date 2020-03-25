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
     - URL : http://117.16.231.66:7004/
     - 아마존 URL:  http://13.125.115.8:9000/
     */
    
    private let baseURL = "http://13.125.115.8:9000/"
    private let token = UserDefaults.standard.string(forKey: "token")
    
    func login(id: String, password: String, completion: @escaping (Response?) -> Void) {
        let url = baseURL + "user/login"
        
        let param = User(id: id, passwd: password, newPasswd: nil, name: nil, major: nil, tel: nil, email: nil, flag: nil)
            
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
        }
    }
    
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
    
    func modifypassword(password: String, newPassword: String, completion: @escaping (Response?) -> Void) {
        let url = baseURL + "user/passwd"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let param = User(id: nil, passwd: password, newPasswd: newPassword, name: nil, major: nil, tel: nil, email: nil, flag: nil)
        
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
        
    func modifyProfile() {
        // 보류
    }
    
    func getTempPassword(id: String, name: String, completion: @escaping (Response?) -> Void ) {
        let url = baseURL + "user/tmpPasswd"
        
        let param = User(id: id, passwd: nil, newPasswd: nil, name: name, major: nil, tel: nil, email: nil, flag: nil)
        
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
    
    func withdraw() {
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
    
    func setInviteOption(flag: Int) {
        let url = baseURL + "share/invite/users/flag"
        
        let header:HTTPHeaders = [
                   "token": token!
               ]
        
        let param = User(id: nil, passwd: nil, newPasswd: nil, name: nil, major: nil, tel: nil, email: nil, flag: flag)
        
        let request = AF.request(url,
        method: .post,
        parameters: param,
        encoder: JSONParameterEncoder.default,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("초대 옵션 변경 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
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
    
    func seeAllSchedules(completion: @escaping (Response?) -> Void) {
        let url = baseURL + "schedule/show/4"
        
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
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    func seeTodaySchedule(completion: @escaping (Response?) -> Void) {
        let url = baseURL + "schedule/show/5"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let request = AF.request(url,
        method: .get,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("오늘 일정 보기 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
        
    }
    
    func seeWeekSchedule(completion: @escaping (Response?) -> Void) {
        let url = baseURL + "schedule/show/6"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let request = AF.request(url,
        method: .get,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("주간 일정 보기 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    func seeMonthSchedule(completion: @escaping (Response?) -> Void) {
        let url = baseURL + "schedule/show/7"
        
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
    
    func makeGroup(groupName: String, inviters: [String], memo: String? ) {
        let url = baseURL + "share/group/create"
        
        let param = Group(group_name: groupName, inviters: inviters, memo: memo)
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let request = AF.request(url,
        method: .post,
        parameters: param,
        encoder: JSONParameterEncoder.default,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("그룹 생성 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    func findInvitee() {
        // 잠깐 보류
    }
    
    func getGroup() {
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
            print("내가 속해있는 그룹 가져오기 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    func exitGroup() {
        //잠시 보류 
    }
    
    func seeGroupMember(share: Int) {
        let url = baseURL + "share/group/member"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let param = Schedule(id: nil, number: nil, schedule_name: nil, start: nil, end: nil, location: nil, alarm: nil, share: share, key: nil, memo: nil)
        
        let request = AF.request(url,
        method: .get,
        parameters: param,
        encoder: JSONParameterEncoder.default,
        headers: header)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("그룹 구성원 보기 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
}

