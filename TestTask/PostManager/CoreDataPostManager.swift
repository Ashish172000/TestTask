//
//  PostManager.swift
//  TestTask
//
//  Created by Ashish Yadav on 08/09/23.
//

import Foundation
 
class PostManager {
    private let postRepository = PostDataRepository()
    
    func createPost(post: PostResponseModel) {
        postRepository.create(post: post)
    }
    func getAllPost() -> [PostResponseModel]? {
       return postRepository.getAll()
    }
    func getAllPostById(post: PostResponseModel) {
        postRepository.getPostById(id: post.id ?? 0)
    }
    func getFavouriteUser() -> [PostResponseModel]? {
        return postRepository.getFavouritePost(isFavourite: true)
    }
    func update(post: PostResponseModel, isFav: Bool) -> Bool {
        return postRepository.update(post: post, isFav: isFav)
    }
}
