//
//  NetworkManager+Extension.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/03/27.
//  Copyright © 2020 mong. All rights reserved.
//

import Alamofire

extension NetworkManager {
    
    // MARK:- Share URI
    
    // 그룹 생성
    func makeGroup(groupName: String, inviters: [String], memo: String? ) {
        let url = baseURL + "share/group/create"
        
        let param = Group(group_name: groupName, inviters: inviters, share: nil, memo: memo)
        
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
    
    // 초대 허용 또는 거부
    func setInviteOption(flag: Int) {
        let url = baseURL + "share/invite/users/flag"
        
        let header:HTTPHeaders = [
                   "token": token!
               ]
        
//        let param = User(id: nil, passwd: nil, newPasswd: nil, name: nil, major: nil, tel: nil, email: nil, flag: flag)
        let param = User(flag: flag)
        
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
    
    func searchInvitee(user: String) {
        // 잠깐 보류
    }
    
    // 내가 속해있는 그룹 가져오기
    func getGroup(completion: @escaping(Response?) -> Void) {
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
            completion(result)
           case let .failure(error):
            print("Error description is: \(error.localizedDescription)")
           }
        }
    }
    
    // 그룹 나가기
    func exitGroup(share: Int) {
        let url = baseURL + "share/group/escape"
        
        let header:HTTPHeaders = [
            "token": token!
        ]
        
        let param = Schedule(id: nil, number: nil, schedule_name: nil, start: nil, end: nil, location: nil, alarm: nil, share: share, key: nil, memo: nil)
        
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
    
    // 그룹 구성원 보기
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
    
    // 초대 확인하기
    
    // 초대 거절
    
    // 초대 수락
}
