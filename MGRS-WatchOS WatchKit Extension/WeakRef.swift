//
//  WeakRef.swift
//  MGRS-WatchOS WatchKit Extension
//
//  Created by James Taylor on 3/15/20.
//  Copyright © 2020 James Taylor. All rights reserved.
//

import Foundation
class WeakRef<T> where T: AnyObject {

    private(set) weak var value: T?

    init(value: T?) {
        self.value = value
    }
}
