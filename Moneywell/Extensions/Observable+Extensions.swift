//
//  Observable+Extensions.swift
//  Moneywell
//
//  Created by Abram Situmorang on 11/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension ObservableType where E == Bool {
    /// Boolean not operator
    public func not() -> Observable<Bool> {
        return map(!)
    }
}

extension SharedSequenceConvertibleType {
    public func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}

extension ObservableType {
    public func catchErrorJustComplete() -> Observable<E> {
        return catchError { _ in
            Observable.empty()
        }
    }
    
    public func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { _ in
            Driver.empty()
        }
    }
    
    public func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}

