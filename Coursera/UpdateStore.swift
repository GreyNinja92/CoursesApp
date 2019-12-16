//
//  UpdateStore.swift
//  Coursera
//
//  Created by Saksham Ram Khatod on 26/08/19.
//  Copyright © 2019 Saksham Ram Khatod. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore {
    var willChange = PassthroughSubject<Void, Never>()
    
    var updates: [Update] {
        didSet {
            willChange.send()
        }
    }
    
    init(updates: [Update] = []) {
        self.updates = updates
    }
    
}
