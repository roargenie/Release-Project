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
    
    let sections = [
        HomeSection(headerTitle: "오늘의 날씨에요", items: [HomeModel(items: "1")]),
        HomeSection(headerTitle: "오늘 날씨에 이건 어때요?", items: [HomeModel(items: "2")]),
        HomeSection(headerTitle: "최근 일주일 모아보기", items: [HomeModel(items: "3")]),
        HomeSection(headerTitle: "내 옷장은 이렇답니다", items: [HomeModel(items: "4")])
    ]
    
    struct Input {
        let viewDidLoadEvent: Signal<Void>
        let viewWillAppearEvent: Signal<Void>
    }
    
    struct Output {
        let items: Driver<[HomeSection]>
    }
    var disposeBag = DisposeBag()
    
    let recommendButtonStatus = PublishRelay<RecommendButtonStatus>()
    private let items = BehaviorRelay<[HomeSection]>(value: [])
    
    func transform(input: Input) -> Output {
        
        input.viewDidLoadEvent
            .withUnretained(self)
            .emit { vm, _ in
                print("=============viewdidload")
                vm.checkFirstRun()
                vm.items.accept(vm.sections)
            }
            .disposed(by: disposeBag)
        
        input.viewWillAppearEvent
            .withUnretained(self)
            .emit { vm, _ in
                vm.fetchRealm()
            }
            .disposed(by: disposeBag)
        
        recommendButtonStatus.asSignal()
            .withUnretained(self)
            .emit { vm, status in
                switch status {
                case .item:
                    print("item 추천 화면 이동")
                case .style:
                    print("style 추천 화면 이동")
                }
            }
            .disposed(by: disposeBag)
        
        
        
        
        return Output(
            items: items.asDriver(onErrorJustReturn: []))
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
    
}






