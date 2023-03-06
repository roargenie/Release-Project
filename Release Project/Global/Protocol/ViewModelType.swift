//
//  ViewModelType.swift
//  Release Project
//
//  Created by 이명진 on 2023/03/07.
//

import Foundation
import RxCocoa
import RxSwift

protocol ViewModelType: AnyObject {
    
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
