

import Foundation


enum SettingTitle {
    case notice
    case fileManage
    case info
    
    var title: [String] {
        switch self {
        case .notice:
            return ["문의하기", "리뷰 남기기"]
        case .fileManage:
            return ["백업 / 복구", "초기화"]
        case .info:
            return ["버전 정보", "오픈소스 라이브러리"]
        }
    }
    
}








