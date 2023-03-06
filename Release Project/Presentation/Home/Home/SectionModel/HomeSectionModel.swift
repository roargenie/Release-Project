//
//  HomeSectionModel.swift
//  Release Project
//
//  Created by 이명진 on 2023/03/07.
//

import Foundation
import RxDataSources
import RealmSwift

struct HomeModel {
    var items: String
}

extension HomeModel: IdentifiableType, Equatable {
    var identity: String {
        return UUID().uuidString
    }
}

struct HomeSection {
    var headerTitle: String
    var items: [Item]
}

extension HomeSection: AnimatableSectionModelType {
    typealias Item = HomeModel

    var identity: String {
        return headerTitle
    }

    init(original: HomeSection, items: [HomeModel]) {
        self = original
        self.items = items
    }

}

//typealias HomeSectionModel = SectionModel<HomeSection, HomeItem>
//
//enum HomeSection: Int, Equatable {
//    case weather
//    case recommend
//    case lastWeek
//    case storagePercent
//
//    init(index: Int) {
//        switch index {
//        case 0: self = .weather
//        case 1: self = .recommend
//        case 2: self = .lastWeek
//        default: self = .storagePercent
//        }
//    }
//
//    var haaderTitle: String {
//        switch self {
//        case .weather:
//            return "오늘의 날씨에요"
//        case .recommend:
//            return "오늘 날씨에 이건 어때요?"
//        case .lastWeek:
//            return "최근 일주일 모아보기"
//        case .storagePercent:
//            return "내 옷장은 이렇답니다"
//        }
//    }
//}

//extension HomeSection: AnimatableSectionModelType {
//    typealias Item = <#type#>
//
//    typealias Identity = <#type#>
//
//
//}

//enum HomeItem: Equatable {
//    case weather(HomeModel)
//    case recommend(HomeModel)
//    case lastWeek(HomeModel)
//    case storagePercent(HomeModel)
//
//    var items: HomeModel {
//        switch self {
//        case .weather(let item):
//            return item
//        case .recommend(let item):
//            return item
//        case .lastWeek(let item):
//            return item
//        case .storagePercent(let item):
//            return item
//        }
//    }
//}
