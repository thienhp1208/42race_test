//
//  Session.swift
//  test_42race
//
//  Created by Thien Huynh on 16/03/2022.
//

import Foundation

class Session {
    let dataManager: DataManager
    let defaultStorage: DefaultStorage

    init(dataManager: DataManager = DataManager(),
         defaultStorage: DefaultStorage = DefaultStorage()) {
        self.dataManager = dataManager
        self.defaultStorage = defaultStorage
    }
}
