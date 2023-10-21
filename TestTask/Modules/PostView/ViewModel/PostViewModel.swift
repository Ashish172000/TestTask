//
//  PostViewModel.swift
//  TestTask
//
//  Created by Ashish Yadav on 09/09/23.
//

import Foundation
class PostViewModel: NSObject {
    
    var postInfo: [PostResponseModel] = []
    let postManger = PostManager()
    var numberOfRows: Int {
        return postInfo.count
    }
    
    func getItem(at indexPath: Int) -> PostResponseModel {
        return postInfo[indexPath]
    }
    
    func saveDataLocally(posts: [PostResponseModel]) {
        let queue = DispatchQueue(label: "com.saveCoreDate", attributes: .concurrent)
        queue.async {
            posts.forEach { [weak self] post in
                guard let self else { return }
            postManger.createPost(post: post)
            }
        }
    }
    
    func checkAndGetLocalData(_ completion: @escaping(_ error: String?) -> Void) {
       let post = postManger.getAllPost()
        if let posts = post, !posts.isEmpty {
            postInfo = posts
            completion(nil)
        } else {
            callApi { error in
             completion(error)
            }
        }
    }
}
// MARK: - API CALLING
extension PostViewModel {
    func callApi(_ completion: @escaping(_ error: String?) -> Void) {
        HttpUtility.shared.performOperation(request: .getPost, response: [PostResponseModel].self) { [weak self] response, error in
            guard let self else { return }
            if let response = response {
                self.postInfo = response
                self.saveDataLocally(posts: response)
                completion(nil)
            } else {
                completion(error?.localizedDescription)
            }
        }
    }
}
 
