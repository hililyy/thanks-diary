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
    
    private static var _instance: FirebaseManager?
    
    public static var instance: FirebaseManager? {
        return _instance ?? FirebaseManager()
    }
    
    func getSuggestDatas(completion: @escaping (Result<[SettingSuggestModel], Error>) -> Void) {
        Database.database()
            .reference()
            .child(Constant.FIREBASE_CHILD_SUGGEST)
            .observeSingleEvent(of: .value) { snapshot in
            var values: [[String: Any]] = []
            guard let allObject = snapshot.children.allObjects as? [DataSnapshot] else { return }
            for snap in allObject {
                guard let value = snap.value as? [String: Any] else { return }
                values.insert(value, at: 0)
            }
            
            if let data = CommonUtilManager.instance?.dictionaryToObject(
                objectType: SettingSuggestModel.self,
                dictionary: values
            ) {
                completion(.success(data))
            }
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
    
    func addSuggestData(contents: String) {
        let newData = [
            Constant.FIREBASE_ITEM_UID: CommonUtilManager.instance?.uuid,
            Constant.FIREBASE_ITEM_CONTENTS: contents,
            Constant.FIREBASE_ITEM_STATUS: SuggestType.waiting.rawValue
        ]
        
        Database.database().reference().child(Constant.FIREBASE_CHILD_SUGGEST).childByAutoId().setValue(newData)
    }
}
