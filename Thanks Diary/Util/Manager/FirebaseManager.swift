//
//  FirebaseLoginManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/20.
//

import Firebase
import FirebaseAuth
import FirebaseCore
import RxSwift

final class FirebaseManager {
    
    private init() {}
    
    private static let _instance = FirebaseManager()
    
    static var instance: FirebaseManager {
        return _instance
    }
    
    func getSuggestDatas(completion: @escaping (Result<[SettingSuggestModel], Error>) -> Void) {
        Database.database()
            .reference()
            .child(Constant.FIREBASE_CHILD_SUGGEST)
            .observeSingleEvent(of: .value) { (snapshot: DataSnapshot, _) in
                var values: [[String: Any]] = []
                
                guard let allObject = snapshot.children.allObjects as? [DataSnapshot] else { return }
                
                for snap in allObject {
                    guard let value = snap.value as? [String: Any] else { return }
                    values.insert(value, at: 0)
                }
                
                var suggestDatas: [SettingSuggestModel] = []
                
                // 원본 firebase 데이터
//                for data in values {
//                    var suggestData = SettingSuggestModel.initData()
//                    suggestData.postId = data["postId"] as? String ?? ""
//                    suggestData.contents = data["contents"] as? String ?? ""
//                    suggestData.status = data["status"] as? String ?? ""
//                    suggestData.createDate = data["createDate"] as? String ?? ""
//                    suggestData.likeCount = data["likeCount"] as? Int ?? 0
//                    
//                    var replys: [SettingSuggestReplyModel] = []
//                    for (_, replyDataValue) in data["replys"] as? [String: Any] ?? [:] {
//                        let replyData = replyDataValue as? [String: Any] ?? [:]
//                        
//                        var reply = SettingSuggestReplyModel.initReplyData()
//                        reply.contents = replyData["contents"] as? String ?? ""
//                        reply.createDate = replyData["createDate"] as? String ?? ""
//                        reply.parentId = replyData["parentId"] as? String ?? ""
//                        replys.append(reply)
//                    }
//                    
//                    suggestData.replys = replys
//                    suggestDatas.append(suggestData)
//                }
                
                for data in values {
                    var suggestData = SettingSuggestModel.initData()
                    suggestData.postId = data["postId"] as? String ?? ""
                    suggestData.contents = data["contents"] as? String ?? ""
                    suggestData.status = data["status"] as? String ?? ""
                    let date = data["createDate"] as? String ?? ""
                    if date.contains(":") {
                        suggestData.createDate = date.toDate(willChangeDateFormat: DateFormat.utcFormat.rawValue).toString(didChangeDateFormat: DateFormat.YYMMDD.rawValue)
                    } else {
                        suggestData.createDate = date
                    }
                    
                    suggestData.likeCount = data["likeCount"] as? Int ?? 0
                    
                    suggestDatas.append(suggestData)
                    
                    for (_, replyDataValue) in data["reply"] as? [String: Any] ?? [:] {
                        let replyData = replyDataValue as? [String: Any] ?? [:]
                        
                        var reply = SettingSuggestModel.initData()
                        reply.contents = replyData["contents"] as? String ?? ""
                        reply.createDate = replyData["createDate"] as? String ?? ""
                        reply.postId = replyData["parentId"] as? String ?? ""
                        reply.status = "reply"
                        suggestDatas.append(reply)
                    }
                }
                
                completion(.success(suggestDatas))
            }
    }
    
    func getSuggestDatasRx() -> Observable<[SettingSuggestModel]> {
        return Observable.create { emitter in
            
            self.getSuggestDatas { result in
                
                switch result {
                case .success(let data):
                    emitter.onNext(data)
                    emitter.onCompleted()
                    
                case .failure(let err):
                    emitter.onError(err)
                }
            }
            return Disposables.create()
        }
    }
    
    func addSuggestData(contents: String, postId: Int) {
        let newData = [Constant.FIREBASE_ITEM_CONTENTS: contents,
                       Constant.FIREBASE_ITEM_CREATEDATE: Date().toString(didChangeDateFormat: DateFormat.utcFormat.rawValue),
                       Constant.FIREBASE_LIKE_COUNT: 0,
                       Constant.FIREBASE_POST_ID: postId,
                       Constant.FIREBASE_ITEM_STATUS: SuggestType.waiting.rawValue] as [String: Any]
        
        Database.database()
            .reference()
            .child(Constant.FIREBASE_CHILD_SUGGEST)
            .childByAutoId()
            .setValue(newData)
    }
}
