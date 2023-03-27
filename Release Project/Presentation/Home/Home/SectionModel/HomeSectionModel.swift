//
//  HomeSectionModel.swift
//  Release Project
//
//  Created by 이명진 on 2023/03/07.
//

import Foundation
import RxDataSources
import RealmSwift

struct WeatherItemModel {
    let id: Int
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

struct ItemRecommendItemModel {
    let title: String
}

struct MonthOfWeekItemModel {
    let content: String?
    let styleItem: Object?
}

struct CategoryPercentItemModel {
    let value: Double?
    let title: String
}

typealias HomeSectionModel = SectionModel<HomeSection, HomeItem>

enum HomeSection: Int, Equatable {
    case weather
    case itemRecommend
    case monthOfWeek
    case categoryPercent
    
    init(index: Int) {
        switch index {
        case 0: self = .weather
        case 1: self = .itemRecommend
        case 2: self = .monthOfWeek
        default: self = .categoryPercent
        }
    }
    
    var headerTitle: String {
        switch self {
        case .weather:
            return "오늘의 날씨에요"
        case .itemRecommend:
            return "오늘 날씨에 이건 어때요?"
        case .monthOfWeek:
            return "최근 일주일 모아보기"
        case .categoryPercent:
            return "내 옷장은 이렇답니다"
        }
    }
}

enum HomeItem: Equatable {
    case weather(WeatherItemModel)
    case itemRecommend(ItemRecommendItemModel)
    case monthOfWeek([MonthOfWeekItemModel])
    case categoryPercent([CategoryPercentItemModel])
}

extension WeatherItemModel: IdentifiableType, Equatable {
    var identity: String {
        return UUID().uuidString
    }
}

extension ItemRecommendItemModel: IdentifiableType, Equatable {
    var identity: String {
        return UUID().uuidString
    }
}

extension MonthOfWeekItemModel: IdentifiableType, Equatable {
    var identity: String {
        return UUID().uuidString
    }
}

extension CategoryPercentItemModel: IdentifiableType, Equatable {
    var identity: String {
        return UUID().uuidString
    }
}

//
//extension HomeItem: IdentifiableType {
//    var identity: String {
//        return UUID().uuidString
//    }
//}


//extension HomeItem: Equatable {
//    static func == (lhs: MyCellConfigurator, rhs: MyCellConfigurator) -> Bool {
//        return lhs.identity == rhs.identity
//    }
//}

//extension HomeItem {
//    func configureCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        switch self {
//        case .fullImage(let model):
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
////            cell.configure(with: model)
//            return cell
//        case .button(let model):
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemRecommendCollectionViewCell.identifier, for: indexPath) as! ItemRecommendCollectionViewCell
////            cell.configure(with: model)
//            return cell
//        case .horizontalScroll(let models):
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthOfWeekCollectionViewCell.identifier, for: indexPath) as! MonthOfWeekCollectionViewCell
////            cell.configure(with: models)
//            return cell
//        case .circularGraph(let models):
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryPercentCollectionViewCell.identifier, for: indexPath) as! CategoryPercentCollectionViewCell
////            cell.configure(with: models)
//            return cell
//        }
//    }
//}
