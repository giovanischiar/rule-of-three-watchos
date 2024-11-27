//
//  PastCrossMultipliersLocalDataSource.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 13/11/24.
//

import Foundation
import Combine

class PastCrossMultipliersLocalDataSource: PastCrossMultipliersDataSource {
    private var _currentID: Int64 = 1
    private let _pastCrossMultipliers: CurrentValueSubject<[CrossMultiplier], Never>
    var pastCrossMultipliers: AnyPublisher<[CrossMultiplier], Never> {
        _pastCrossMultipliers.eraseToAnyPublisher()
    }

    init(crossMultipliersToInsert: [CrossMultiplier] = []) {
        var currentID = _currentID
        let initializedMultipliers = crossMultipliersToInsert.map { crossMultiplier in
            let newCrossMultiplier = crossMultiplier.withIDChangedTo(newID: currentID)
            currentID += 1
            return newCrossMultiplier
        }
        _currentID = currentID
        _pastCrossMultipliers = CurrentValueSubject(initializedMultipliers)
    }

    func create(crossMultiplier: CrossMultiplier) -> CrossMultiplier {
        let elementToInsert = crossMultiplier.withIDChangedTo(newID: _currentID)
        _currentID += 1
        var updatedList = _pastCrossMultipliers.value
        updatedList.insert(elementToInsert, at: 0)
        _pastCrossMultipliers.send(updatedList)
        return elementToInsert
    }

    func retrieve() -> AnyPublisher<[CrossMultiplier], Never> {
        return pastCrossMultipliers
    }

    func update(crossMultiplier: CrossMultiplier) {
        let updatedMultipliers = _pastCrossMultipliers.value.map { existingMultiplier in
            existingMultiplier.id == crossMultiplier.id ? crossMultiplier : existingMultiplier
        }
        _pastCrossMultipliers.send(updatedMultipliers)
    }

    func delete(crossMultiplier: CrossMultiplier) {
        var updatedList = _pastCrossMultipliers.value
        updatedList.removeAll { $0.id == crossMultiplier.id }
        _pastCrossMultipliers.send(updatedList)
    }

    func deleteAll() {
        _pastCrossMultipliers.send([])
    }
}
