//
//  Model.swift
//  TestTask
//
//  Created by Ashish Yadav on 08/09/23.
//

import Foundation
struct PostResponseModel: Codable {
    let userId: Int32?
    let id: Int32?
    let title: String?
    let body: String?
    var isFavourite: Bool? = false
}
