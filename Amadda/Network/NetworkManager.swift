//
//  NetworkManager.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/02/26.
//  Copyright © 2020 mong. All rights reserved.
//

import Alamofire

class NetworkManager {
    private let baseURL = "http://117.16.231.66:7004"
    private let token = UserDefaults.standard.string(forKey: "token")
    
    func login(id: String, password: String, completion: @escaping (Response?) -> Void) {
        let url = baseURL + "/user/login"
        
        let param = User(token: nil, id: id, passwd: password, newPasswd: nil, name: nil, email: nil, user_image: nil, flag: nil)
        
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
        let url = baseURL + "/user/account"
        
        let param = User(token: token!, id: nil, passwd: nil, newPasswd: nil, name: nil, email: nil, user_image: nil, flag: nil)
        
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
        let url = baseURL + "/user/passwd"
        
        let param = User(token: token!,id: nil, passwd: password, newPasswd: newPassword , name: nil, email: nil, user_image: nil, flag: nil)
        
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
    
    func uploadProfileImg(image: UIImage) {
        let url = baseURL + "/image"
        let imageData = image.jpegData(compressionQuality: 1)
        
        let param = User(token: token!, id: nil, passwd: nil, newPasswd: nil, name: nil, email: nil, user_image: nil, flag: nil)
        
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
                print("upload success result: \(resut)")
            case .failure(let err):
                print("upload err: \(err)")
            }
        }
    }
    
    func DeleteProfileImg() {
        let url = baseURL + "/image"
        let param = User(token: token!, id: nil, passwd: nil, newPasswd: nil, name: nil, email: nil, user_image: nil, flag: nil)
        
        let request = AF.request(url,
        method: .delete,
        parameters: param,
        encoder: JSONParameterEncoder.default,
        headers: nil)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    func setInviteOption(flag: Int) {
        let url = baseURL + "/main/beinvited/modify"
        let param = User(token: token!,id: nil, passwd: nil, newPasswd: nil, name: nil, email: nil, user_image: nil, flag: flag)
        
        let request = AF.request(url,
        method: .post,
        parameters: param,
        encoder: JSONParameterEncoder.default,
        headers: nil)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    func makeGroup() {
        // 보류
    }
    
    func addSchedule(name: String, start: String, end: String, location: String, alarm: String, share: Int, memo: String?) {
        let url = baseURL + "/schedule/add"
        
        let param = Schedule(token: token!, name: name, start: start, end: end, location: location, alarm: alarm, share: share, memo: memo)
        
        let request = AF.request(url,
        method: .post,
        parameters: param,
        encoder: JSONParameterEncoder.default,
        headers: nil)
        
        request.responseDecodable(of: Response.self) { response in
           switch response.result {
           case let .success(result):
            print(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
}

