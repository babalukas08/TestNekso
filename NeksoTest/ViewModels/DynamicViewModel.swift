//
//  DynamicViewModel.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 08/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

class DynamicViewModel<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
