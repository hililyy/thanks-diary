//
//  PMain.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/24.
//

import Foundation

//protocol LoginHandlerProtocol {
//    func requestLogin() -> Data
//}
//
//protocol DecodingHandlerProtocol {
//    func decode<T>(from data: Data) -> T
//}
//
//protocol DBhandlerProtocol {
//    func saveOnDatabase<T>(inform: T)
//}
//
//protocol APIHandlerProtocol {
//    func requestAPI() -> Data
//}
//
//class LoginAPI: APIHandlerProtocol {
//    func requestAPI() -> Data {
//        return Data(base64Encoded: "User")!
//    }
//}
//
//class LoginService {
//    let apiHandler: APIHandlerProtocol
//    let decodingHandler: DecodingHandlerProtocol
//    let dbHandler: DBhandlerProtocol
//    let loginHandler: LoginHandlerProtocol
//    
//    init(apiHandler: APIHandlerProtocol,
//         decodingHandler: DecodingHandlerProtocol,
//         dbHandler: DBhandlerProtocol) {
//        self.apiHandler = apiHandler
//        self.decodingHandler = decodingHandler
//        self.dbHandler = dbHandler
//    }
//    
//    func login() {
//        let loginData = loginHandler.requestLogin()
//        let user: User = decodingHandler.decode(from: loginData)
//        dbHandler.saveOnDatabase(inform: user)
//    }
//    
//    func requestAPI() {
//        let loginData = apiHandler.requestAPI()
//        print(loginData)
//    }
//}
//
//struct User {
//    let name: String
//    let age: Int
//}
////
////class My {
////    let loginAPI = LoginAPI()
////    let loginServive = LoginService(apiHandler: <#APIHandlerProtocol#>, decodingHandler: <#DecodingHandlerProtocol#>, dbHandler: <#DBhandlerProtocol#>)
////}
//
//
//
//
//
//
//
//
//
//class Market {
//    let stockManager: Storable
//    let sellManager: Salable
//    let deliveryManager: Deliverable
//    
//    init(stockManager: Storable, sellManager: Salable, deliveryManager: Deliverable) {
//        self.stockManager = stockManager
//        self.sellManager = sellManager
//        self.deliveryManager = deliveryManager
//    }
//    
//    func manage() {
//        stockManager.stock()
//        sellManager.sell()
//        deliveryManager.deliver()
//    }
//}
//
//class StockManager {
//    func stock() {
//        // stock
//    }
//}
//
//class SellManager {
//    func sell() {
//        // sell
//    }
//}
//
//class DeliveryManager {
//    func deliver() {
//        // deliver
//    }
//}
//
//protocol Storable {
//    func stock()
//}
//
//protocol Salable {
//    func sell()
//}
//
//protocol Deliverable {
//    func deliver()
//}
