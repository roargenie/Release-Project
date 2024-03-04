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
    
    lazy var sections = [
        HomeSectionModel(
            model: .weather,
            items: []),
        HomeSectionModel(
            model: .itemRecommend,
            items: [
                .itemRecommend(
                    ItemRecommendItemModel(title: "스타일을 추천받을게요!")),
                .itemRecommend(
                    ItemRecommendItemModel(title: "아이템을 추천받을게요!"))]),
        HomeSectionModel(
            model: .monthOfWeek,
            items: [
                .monthOfWeek(
                    MonthOfWeekItemModel(content: nil, styleItem: nil)),
                .monthOfWeek(
                    MonthOfWeekItemModel(content: nil, styleItem: nil)),
                .monthOfWeek(
                    MonthOfWeekItemModel(content: nil, styleItem: nil)),
                .monthOfWeek(
                    MonthOfWeekItemModel(content: nil, styleItem: nil))
            ]),
        HomeSectionModel(
            model: .categoryPercent,
            items: [.categoryPercent([
                CategoryPercentItemModel(value: categoryPercent.value[0], title: "아우터"),
                CategoryPercentItemModel(value: categoryPercent.value[1], title: "상의"),
                CategoryPercentItemModel(value: categoryPercent.value[2], title: "하의"),
                CategoryPercentItemModel(value: categoryPercent.value[3], title: "신발"),
                CategoryPercentItemModel(value: categoryPercent.value[4], title: "악세"),
                CategoryPercentItemModel(value: categoryPercent.value[5], title: "기타")])])
    ]
    var clothItemTasks: Results<ClothItem>!
    var styleTasks: Results<Style>!
    
    private let repository = StyleRepository()
    var items = BehaviorRelay<[HomeSectionModel]>(value: [])
    var categoryPercent = BehaviorRelay<[Double]>(value: [])
    
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
                vm.categoryPercent.accept([
                    vm.checkPercent(query: "아우터"),
                    vm.checkPercent(query: "상의"),
                    vm.checkPercent(query: "하의"),
                    vm.checkPercent(query: "신발"),
                    vm.checkPercent(query: "악세"),
                    vm.checkPercent(query: "기타")
                ])
            }
            .disposed(by: disposeBag)
        
        input.viewWillAppearEvent
            .withUnretained(self)
            .emit { vm, _ in
                print("===========ViewWillAppear🟢")
                vm.fetchRealm()
                vm.categoryPercent.accept([
                    vm.checkPercent(query: "아우터"),
                    vm.checkPercent(query: "상의"),
                    vm.checkPercent(query: "하의"),
                    vm.checkPercent(query: "신발"),
                    vm.checkPercent(query: "악세"),
                    vm.checkPercent(query: "기타")
                ])
//                vm.fetchRealm()
//                vm.items.accept(vm.sections)
            }
            .disposed(by: disposeBag)
        
        categoryPercent
            .withUnretained(self)
            .bind { vm, value in
                vm.items.accept(vm.sections)
                print("===========변경됨🟢", vm.sections[3])
            }
            .disposed(by: disposeBag)
        
        return Output(
            items: items.asDriver())
    }
}

extension HomeViewModel {
    
    private func checkFirstRun() {
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
            repository.addItem(item: [outer, top, bottom, shoes, acc, other, spring, summer, autumn, winter])
            
            print("realm 위치: ", Realm.Configuration.defaultConfiguration.fileURL!)
            UserDefaults.standard.set(true, forKey: "FirstRun")
        }
    }
    
    func fetchRealm() {
        print("=======fetchRealm🟢")
        clothItemTasks = repository.fetch(ClothItem.self)
        styleTasks = repository.fetchDateBeforeWeekFilter(Style.self)
//        items.accept(sections)
    }
    
    private func checkPercent(query: String) -> Double {
        let totalCount = repository.fetch(ClothItem.self).count
        let itemCount = repository.clothItemCategoryFilter(query: query).count
        let results = Double(itemCount) / Double(totalCount)
        return results
    }
    
//    private func checkCategoryCount(query: String) -> Double {
//        let count = repository.clothItemCategoryFilter(query: query).count
//        return Double(count)
//    }
    
    func requestWeatherData(_ latitude: Double, _ longitude: Double) {
        APIManager.shared.getWeather(lat: latitude, lon: longitude) { [weak self] weather in
            guard let self = self else { return }
            let section = [HomeItem.weather(WeatherItemModel(items: weather))]
            self.sections[0].items = section
            self.items.accept(self.sections)
        }
    }
    
}






