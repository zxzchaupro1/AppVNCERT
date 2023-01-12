//
//  UserModel.swift
//  VNCERT_CC
//
//  Created by ChâuNT on 07/11/2022.
//

import Foundation

struct User: Codable {
    let createdAt: String
    let name: String
    let avatar: String
    let email: String
    let password: String
    let id : String
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case name = "name"
        case email = "ten_dang_nhap"
        case avatar = "avatar"
        case password = "mat_khau"
        case id = "id"
    }
}

typealias Users = [User]
