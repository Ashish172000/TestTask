//
//  PostRepository.swift
//  TestTask
//
//  Created by Ashish Yadav on 08/09/23.
//

import Foundation
import CoreData

protocol PostsRepository {
    func create(post: PostResponseModel)
    func getAll() -> [PostResponseModel]?
    func getFavouritePost(isFavourite: Bool) -> [PostResponseModel]?
    func update(post: PostResponseModel, isFav: Bool) -> Bool
    func getPostById(id: Int32) -> PostResponseModel?
}

struct PostDataRepository: PostsRepository {
    func getPostById(id: Int32) -> PostResponseModel? {
        let fetchRequest = NSFetchRequest<CDPosts>(entityName: "CDPosts")
        let predicate = NSPredicate(format: "id==%lld", id as Int32)
        fetchRequest.predicate =  predicate
       
        do {
            guard let result = try PersistentStorage.shared.context.fetch(fetchRequest).first as? CDPosts else { return nil }
            let filterPost = PostResponseModel(userId: result.userID, id: result.id, title: result.title, body: result.body, isFavourite: result.isFavourite)
            return filterPost
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    func update(post: PostResponseModel, isFav: Bool) -> Bool {
        let fetchPost: NSFetchRequest<CDPosts> = CDPosts.fetchRequest()
        fetchPost.predicate = NSPredicate(format: "id = %lld", (post.id ?? 0) as Int32)
        let results = try? PersistentStorage.shared.context.fetch(fetchPost).first
        if let results =  results {
            results.isFavourite = isFav
        }
        PersistentStorage.shared.saveContext()
        return isFav
    }
    func getFavouritePost(isFavourite: Bool) -> [PostResponseModel]? {
        let fetchRequest = NSFetchRequest<CDPosts>(entityName: "CDPosts")
        let predicate = NSPredicate(format: "isFavourite==%lld", isFavourite as Bool)
        var favPosts: [PostResponseModel] = []
        fetchRequest.predicate =  predicate
        do {
            guard let result = try PersistentStorage.shared.context.fetch(fetchRequest) as? [CDPosts] else { return nil }
            result.forEach { favPost in
                let post = PostResponseModel(userId: favPost.userID, id: favPost.id, title: favPost.title, body: favPost.body, isFavourite: favPost.isFavourite)
                favPosts.append(post)
            }
            return favPosts
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    func create(post: PostResponseModel) {
        let cdPost = CDPosts(context: PersistentStorage.shared.context)
        cdPost.id = post.id ?? 0
        cdPost.body = post.body
        cdPost.userID = post.userId ?? 0
        cdPost.title = post.title
        cdPost.isFavourite = post.isFavourite ?? false
        PersistentStorage.shared.saveContext()
        
    }
    
    func getAll() -> [PostResponseModel]? {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(CDPosts.fetchRequest()) as? [CDPosts] else { return nil }
            var posts: [PostResponseModel] = []
            result.forEach { cdPost in
                let post = PostResponseModel(userId: cdPost.userID, id: cdPost.id, title: cdPost.title, body: cdPost.body, isFavourite: cdPost.isFavourite)
                posts.append(post)
            }
            return posts
        } catch let error {
            print(error)
        }
        return nil
    }
}
