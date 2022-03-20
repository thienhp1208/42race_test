//
//  BaseViewModel.swift
//  test_42race
//
//  Created by Thien Huynh on 17/03/2022.
//

import Foundation
import RxSwift

class BaseViewModel {
    
    // MARK: - Properties
    let session: Session
    let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    init(session: Session) {
        self.session = session
    }
}
