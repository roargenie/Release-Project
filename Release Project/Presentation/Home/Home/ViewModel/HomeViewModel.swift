//
//  HomeViewModel.swift
//  Release Project
//
//  Created by 이명진 on 2023/03/05.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

final class HomeViewModel: ViewModelType {
    
    var sections = [
        HomeSectionModel(
            model: .weather,
            items: []),
        HomeSectionModel(
            model: .itemRecommend,
            items: [.itemRecommend(
                ItemRecommendItemModel(title: "스타일을 추천받을게요!")),
                    .itemRecommend(
                        ItemRecommendItemModel(title: "아이템을 추천받을게요!"))]),
        HomeSectionModel(
            model: .monthOfWeek,
            items: [
//                .monthOfWeek(
//                    MonthOfWeekItemModel(content: nil, styleItem: nil)),
//                .monthOfWeek(
//                    MonthOfWeekItemModel(content: nil, styleItem: nil)),
//                .monthOfWeek(
//                    MonthOfWeekItemModel(content: nil, styleItem: nil)),
//                .monthOfWeek(
//                    MonthOfWeekItemModel(content: nil, styleItem: nil))
            ]),
        HomeSectionModel(
            model: .categoryPercent,
            items: [.categoryPercent([
                CategoryPercentItemModel(value: nil, title: "아우터"),
                CategoryPercentItemModel(value: nil, title: "상의"),
                CategoryPercentItemModel(value: nil, title: "하의"),
                CategoryPercentItemModel(value: nil, title: "신발"),
                CategoryPercentItemModel(value: nil, title: "악세"),
                CategoryPercentItemModel(value: nil, title: "기타")])])
    ]
    
//    let coordinate = BehaviorRelay<[Double]>(value: [])
    private let items = BehaviorRelay<[HomeSectionModel]>(value: [])
    
    struct Input {
        let viewDidLoadEvent: Observable<Void>
        let viewWillAppearEvent: Signal<Void>
    }
    
    struct Output {
        let items: Driver<[HomeSectionModel]>
    }
    var disposeBag = DisposeBag()
    
    
    func transform(input: Input) -> Output {
        
        input.viewDidLoadEvent
            .withUnretained(self)
            .bind { vm, _ in
                vm.checkFirstRun()
            }
            .disposed(by: disposeBag)
        
        input.viewWillAppearEvent
            .withUnretained(self)
            .emit { vm, _ in
                print("===========ViewWillAppear🟢")
                vm.fetchRealm()
            }
            .disposed(by: disposeBag)
        
        return Output(
            items: items.asDriver())
    }
}

extension HomeViewModel {
    
    private func checkFirstRun() {
        print("============Check FirstRun", #function)
        if UserDefaults.standard.bool(forKey: "FirstRun") == false {
            
            let outer = Category(title: "아우터")
            let top = Category(title: "상의")
            let bottom = Category(title: "하의")
            let shoes = Category(title: "신발")
            let acc = Category(title: "악세")
            let other = Category(title: "기타")
            
            let spring = Season(title: "봄")
            let summer = Season(title: "여름")
            let autumn = Season(title: "가을")
            let winter = Season(title: "겨울")
            StyleRepository.shared.addItem(item: [outer, top, bottom, shoes, acc, other, spring, summer, autumn, winter])
            
            print("realm 위치: ", Realm.Configuration.defaultConfiguration.fileURL!)
            UserDefaults.standard.set(true, forKey: "FirstRun")
        }
    }
    
    private func fetchRealm() {
        StyleRepository.shared.clothItemTasks = StyleRepository.shared.fetch(ClothItem.self)
        StyleRepository.shared.styleTasks = StyleRepository.shared.fetchDateBeforeWeekFilter(Style.self)
    }
    
    private func checkPercent(query: String) -> Double {
        let totalCount = StyleRepository.shared.fetch(ClothItem.self).count
        let itemCount = StyleRepository.shared.clothItemCategoryFilter(query: query).count
        let results = Double(itemCount) / Double(totalCount)
        return results
    }
    
    private func checkCategoryCount(query: String) -> Double {
        let count = StyleRepository.shared.clothItemCategoryFilter(query: query).count
        return Double(count)
    }
    
    func requestWeatherData(_ latitude: Double, _ longitude: Double) {
        APIManager.shared.getWeather(lat: latitude, lon: longitude) { [weak self] weather in
            guard let self = self else { return }
            let section = [HomeItem.weather(WeatherItemModel(items: weather))]
            self.sections[0].items = section
            self.items.accept(self.sections)
            print("========🟢========== 날씨 정보 아이템 모델에 들어감.", self.sections[0].items)
        }
    }
    
}






