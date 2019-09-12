//
//  ViewModelType.swift
//  Moneywell
//
//  Created by Abram Situmorang on 09/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

