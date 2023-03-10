//
//  DiaryDataEntity.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/11.
//

import ObjectMapper

class DiaryDataEntity {
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

class SimpleDiaryDataEntity {
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

class AllDiaryData: Mappable {
    public var long: [String:Long] = [:]
    public var short: [String:Short] = [:]
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        long <- map["long"]
        short <- map["short"]
    }
    
    public class Long: Mappable {
        public var title: String?
        public var contents: String?
        public var date: String?
        public required init?(map: Map) {
            
        }
        public func mapping(map: Map) {
            title <- map["title"]
            contents <- map["contents"]
            date <- map["date"]
        }
    }
    
    public class Short: Mappable {
        public var contents: String?
        public var date: String?
        public required init?(map: Map) {
            
        }
        public func mapping(map: Map) {
            contents <- map["contents"]
            date <- map["date"]
        }
    }
}
