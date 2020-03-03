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
     - 아마존 URL:  http://13.209.87.234:9000/
     */
    
    private let baseURL = "http://13.209.87.234:9000/"
    private let token = UserDefaults.standard.string(forKey: "token")
    
    func login(id: String, password: String, completion: @escaping (Response?) -> Void) {
        let url = baseURL + "user/login"
        
        let param = User(token: nil, id: id, passwd: password, newPasswd: nil, name: nil, major: nil, tel: nil, email: nil, flag: nil)
            
        let request = AF.request(url,
                   method: .post,
                   parameters: param,
                   encoder: JSONParameterEncoder.default,
                   headers: nil)

        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):

            if let token = result.token {
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
        
        let param = User(token: token!, id: nil, passwd: nil, newPasswd: nil, name: nil, major: nil, tel: nil, email: nil, flag: nil)
        
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
    
    func modifypassword(password: String, newPassword: String, completion: @escaping (Response?) -> Void) {
        let url = baseURL + "user/passwd"
        
        let param = User(token: token!, id: nil, passwd: password, newPasswd: newPassword, name: nil, major: nil, tel: nil, email: nil, flag: nil)
        
        let request = AF.request(url,
                   method: .put,
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
        
    func modifyProfile() {
        // 보류
    }
    
    func getTempPassword(id: String, name: String, completion: @escaping (Response?) -> Void ) {
        let url = baseURL + "user/tmpPasswd"
        
        let param = User(token: nil, id: id, passwd: nil, newPasswd: nil, name: name, major: nil, tel: nil, email: nil, flag: nil)
        
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
        let imageData = image.jpegData(compressionQuality: 1)
        
        let param = User(token: token!, id: nil, passwd: nil, newPasswd: nil, name: nil, major: nil, tel: nil, email: nil, flag: nil)
        
        AF.upload(multipartFormData: { multiPart in
           multiPart.append((param.token)!.data(using: String.Encoding.utf8)!, withName: "token")
           multiPart.append(imageData!, withName: "user_image",fileName: "profile.jpg", mimeType: "image/jpg")
        }, to: url, method: .post, headers: nil) .uploadProgress(queue: .main, closure: { progress in
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
        let param = User(token: token!, id: nil, passwd: nil, newPasswd: nil, name: nil, major: nil, tel: nil, email: nil, flag: nil)
        
        let request = AF.request(url,
        method: .delete,
        parameters: param,
        encoder: JSONParameterEncoder.default,
        headers: nil)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("프로파일 이미지 삭제 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    func setInviteOption(flag: Int) {
        let url = baseURL + "main/beinvited/modify"
        
        let param = User(token: token!, id: nil, passwd: nil, newPasswd: nil, name: nil, major: nil, tel: nil, email: nil, flag: flag)
        
        let request = AF.request(url,
        method: .post,
        parameters: param,
        encoder: JSONParameterEncoder.default,
        headers: nil)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("초대 옵션 변경 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    func makeGroup() {
        // 보류
    }
    
    func addSchedule(name: String, start: String, end: String, location: String?, alarm: String?, share: Int?, memo: String?) {
        let url = baseURL + "schedule/add"
        
        let param = Schedule(token: token!,id: nil, number: nil, schedule_name: name, start: start, end: end, location: location, alarm: alarm, share: share, key: nil, memo: memo)
        
        let request = AF.request(url,
        method: .post,
        parameters: param,
        encoder: JSONParameterEncoder.default,
        headers: nil)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("스케줄 추가 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    func seeScheduleDetail(number: Int, completion: @escaping (Response?) -> Void) {
        let url = baseURL + "schedule/detail"
        
        let param = Schedule(token: token!,id: nil, number: number, schedule_name: nil, start: nil, end: nil, location: nil, alarm: nil, share: nil, key: nil, memo: nil)
        
        let request = AF.request(url,
        method: .post,
        parameters: param,
        encoder: JSONParameterEncoder.default,
        headers: nil)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("스케줄 상세보기 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    func seeAllSchedules(completion: @escaping (Response?) -> Void) {
        let url = baseURL + "schedule/show/private/0"
        
        let param = Schedule(token: token!,id: nil, number: nil, schedule_name: nil, start: nil, end: nil, location: nil, alarm: nil, share: nil, key: nil, memo: nil)
        
        let request = AF.request(url,
        method: .post,
        parameters: param,
        encoder: JSONParameterEncoder.default,
        headers: nil)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("모든 스케줄 보기 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    func deleteSchedule(number: Int) {
        let url = baseURL + "schedule/delete"
        
        let param = Schedule(token: token!,id: nil, number: number, schedule_name: nil, start: nil, end: nil, location: nil, alarm: nil, share: nil, key: nil, memo: nil)
        
        let request = AF.request(url,
        method: .delete,
        parameters: param,
        encoder: JSONParameterEncoder.default,
        headers: nil)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print("스케줄 삭제 \(result)")
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
}

