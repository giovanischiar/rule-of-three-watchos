//
//  CurrentCrossMultiplierLocalDataSource.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 13/11/24.
//

import Foundation
import Combine

class CurrentCrossMultiplierLocalDataSource: CurrentCrossMultiplierDataSource {
    private let _currentCrossMultiplier: CurrentValueSubject<CrossMultiplier?, Never>
    var currentCrossMultiplier: AnyPublisher<CrossMultiplier?, Never> {
        _currentCrossMultiplier.eraseToAnyPublisher()
    }
    
    init(currentCrossMultiplierToInsert: CrossMultiplier? = nil) {
        _currentCrossMultiplier = CurrentValueSubject(
            currentCrossMultiplierToInsert?.withIDChangedTo(newID: 1)
        )
    }

    func create(crossMultiplier: CrossMultiplier) {
        _currentCrossMultiplier.send(crossMultiplier)
    }
    
    func retrieve() -> AnyPublisher<CrossMultiplier?, Never> {
        return currentCrossMultiplier
    }
    
    func update(crossMultiplier: CrossMultiplier) {
        _currentCrossMultiplier.send(crossMultiplier)
    }
}
