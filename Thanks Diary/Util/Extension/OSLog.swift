//
//  OSLog.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/10.
//

import Foundation
import os.log

extension OSLog {
    static let subsystem = Bundle.main.bundleIdentifier!
    static let network = OSLog(subsystem: subsystem, category: "Network")
    static let debug = OSLog(subsystem: subsystem, category: "Debug")
    static let info = OSLog(subsystem: subsystem, category: "Info")
    static let error = OSLog(subsystem: subsystem, category: "Error")
}

struct Log {
    /*
     - debug : 디버깅 로그
     - info : 문제 해결 정보
     - network : 네트워크 정보
     - error :  오류
     - custom(category: String) : 커스텀 디버깅 로그
     */
    enum Level {
        // 디버깅 로그
        case debug
        // 문제 해결 정보
        case info
        // 네트워크 로그
        case network
        // 오류 로그
        case error
        case custom(category: String)
        
        fileprivate var category: String {
            switch self {
            case .debug:
                return "🟡 DEBUG"
            case .info:
                return "🟠 INFO"
            case .network:
                return "🔵 NETWORK"
            case .error:
                return "🔴 ERROR"
            case .custom(let category):
                return "🟢 \(category)"
            }
        }
        
        fileprivate var osLog: OSLog {
            switch self {
            case .debug:
                return OSLog.debug
            case .info:
                return OSLog.info
            case .network:
                return OSLog.network
            case .error:
                return OSLog.error
            case .custom:
                return OSLog.debug
            }
        }
        
        fileprivate var osLogType: OSLogType {
            switch self {
            case .debug:
                return .debug
            case .info:
                return .info
            case .network:
                return .default
            case .error:
                return .error
            case .custom:
                return .debug
            }
        }
    }
    
    static private func log(_ message: Any, level: Level) {
        #if DEBUG
        if #available(iOS 14.0, *) {
            let logger = Logger(subsystem: OSLog.subsystem, category: level.category)
            let logMessage = "\(message)"
            switch level {
            case .debug,
                 .custom:
                logger.debug("\(logMessage, privacy: .public)")
            case .info:
                logger.info("\(logMessage, privacy: .public)")
            case .network:
                logger.log("\(logMessage, privacy: .public)")
            case .error:
                logger.error("\(logMessage, privacy: .public)")
            }
        } else {
            os_log("%{public}@", log: level.osLog, type: level.osLogType, "\(message)")
        }
        #endif
    }
}

extension Log {
    // 개발 중 코드 디버깅 시 사용할 수 있는 유용한 정보
    static func debug(_ message: Any, _ arguments: Any...) {
        log(message, level: .debug)
    }
    
    // 문제 해결시 활용할 수 있는, 도움이 되지만 필수적이지 않은 정보
    static func info(_ message: Any, _ arguments: Any...) {
        log(message, level: .info)
    }

    // 네트워크 문제 해결에 필수적인 정보
    static func network(_ message: Any, _ arguments: Any...) {
        log(message, level: .network)
    }
    
    // 코드 실행 중 나타난 에러
    static func error(_ message: Any, _ arguments: Any...) {
        log(message, level: .error)
    }

    // 커스텀 디버깅 로그
    static func custom(category: String, _ message: Any, _ arguments: Any...) {
        log(message, level: .custom(category: category))
    }
}
