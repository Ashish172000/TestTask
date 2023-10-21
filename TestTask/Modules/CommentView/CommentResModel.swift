//
//  Model.swift
//  TestTask
//
//  Created by Ashish Yadav on 09/09/23.
//

import Foundation
struct CommentResponseModel: Codable {
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
}
