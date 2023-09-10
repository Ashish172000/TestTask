//
//  CommentViewModel.swift
//  TestTask
//
//  Created by Ashish Yadav on 09/09/23.
//

import Foundation
enum CommentSection {
    case post
    case comment
}
class CommentViewModel: NSObject {
    var sections: [CommentSection] = [.post, .comment]
    var commentInfo: [CommentResponseModel] = []
    let postManger = PostManager()
    var postData: PostResponseModel?
    var numberOfSection: Int {
        return sections.count
    }
    func getNumberOfRows(section: Int) -> Int {
        switch sections[section] {
        case .post:
            return 1
        case .comment:
            return commentInfo.count
        }
    }
    func getComments(indexPath: Int) -> CommentResponseModel {
        return commentInfo[indexPath]
    }
}
// MARK: - API CALLING
extension CommentViewModel {
    func getAllComments(_ completion: @escaping(_ error: String?) -> Void) {
        HttpUtility.shared.performOperation(request: .getComment(self.postData?.id ?? 0), response: [CommentResponseModel].self) { [weak self] response, error in
            guard let self else { return }
            if let response = response {
                self.commentInfo = response
                completion(nil)
            } else {
                completion(error?.localizedDescription)
            }
        }
    }
}
