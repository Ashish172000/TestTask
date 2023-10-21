//
//  FavouriteViewModel.swift
//  TestTask
//
//  Created by Ashish Yadav on 10/09/23.
//

import Foundation
class FavouriteViewModel {
    var favouriteInfo: [PostResponseModel] = []
    let postManger = PostManager()
    var numberOfRows: Int {
        return favouriteInfo.count
    }
    func getItems(indexPath: Int) -> PostResponseModel {
        return favouriteInfo[indexPath]
    }
    func getfavUser() {
        favouriteInfo = postManger.getFavouriteUser() ?? []
    }
}
