//
//  DiaryDataEntity.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/11.
//

import ObjectMapper

final class DiaryDataEntity {
    var title: String
    var contents: String
    var date: String
    
    init() {
        self.title = ""
        self.contents = ""
        self.date = ""
    }

    init(title: String, contents: String, date: String) {
        self.title = title
        self.contents = contents
        self.date = date
    }
    
}

final class SimpleDiaryDataEntity {
    var contents: String
    var date: String
    
    init() {
        self.contents = ""
        self.date = ""
    }
    
    init(contents: String, date: String) {
        self.contents = contents
        self.date = date
    }
}

final class AllDiaryData: Mappable {
    public var detail: [String:Detail] = [:]
    public var simple: [String:Simple] = [:]
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        detail <- map["detail"]
        simple <- map["simple"]
    }
    
    public class Detail: Mappable {
        public var title: String?
        public var contents: String?
        public var date: String?
        public required init?(map: Map) {}
        public func mapping(map: Map) {
            title <- map["title"]
            contents <- map["contents"]
            date <- map["date"]
        }
    }
    
    public class Simple: Mappable {
        public var contents: String?
        public var date: String?
        public required init?(map: Map) {}
        public func mapping(map: Map) {
            contents <- map["contents"]
            date <- map["date"]
        }
    }
}
