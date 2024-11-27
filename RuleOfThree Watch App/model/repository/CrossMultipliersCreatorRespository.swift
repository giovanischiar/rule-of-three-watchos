//
//  CrossMultipliersCreatorRespository.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 10/11/24.
//

import Foundation
import Combine

class CrossMultipliersCreatorRepository {
    private var _currentCrossMultiplier: CrossMultiplier = CrossMultiplier()
    private let currentCrossMultiplierDataSource: CurrentCrossMultiplierDataSource
    private let pastCrossMultipliersDataSource: PastCrossMultipliersDataSource    
    
    init(currentCrossMultiplier: CrossMultiplier? = nil, pastCrossMultipliers: [CrossMultiplier] = []) {
        self.currentCrossMultiplierDataSource = CurrentCrossMultiplierLocalDataSource(currentCrossMultiplierToInsert: currentCrossMultiplier)
        self.pastCrossMultipliersDataSource = PastCrossMultipliersLocalDataSource(crossMultipliersToInsert: pastCrossMultipliers)
        self._currentCrossMultiplier = currentCrossMultiplier ?? CrossMultiplier()
    }
    
    var currentCrossMultiplierPublisher: AnyPublisher<CrossMultiplier, Never> {
        currentCrossMultiplierDataSource.retrieve().compactMap { $0 }.eraseToAnyPublisher()
    }

    var areTherePastCrossMultipliersPublisher: AnyPublisher<Bool, Never> {
        return pastCrossMultipliersDataSource.retrieve().compactMap { !$0.isEmpty }.eraseToAnyPublisher()
    }

    func pushCharacterToInputAt(position: (Int, Int), character: String) {
        _currentCrossMultiplier = _currentCrossMultiplier
            .characterPushedAt(position: position, character: character)
            .resultCalculated()
        
        currentCrossMultiplierDataSource.update(crossMultiplier: _currentCrossMultiplier)
    }

    func popCharacterOfInputAt(position: (Int, Int)) {
        _currentCrossMultiplier = _currentCrossMultiplier
            .characterPoppedAt(position: position)
            .resultCalculated()

        currentCrossMultiplierDataSource.update(crossMultiplier: _currentCrossMultiplier)
    }

    func changeTheUnknownPositionTo(position: (Int, Int)) {
        _currentCrossMultiplier = _currentCrossMultiplier
            .unknownPositionChangedTo(position: position)
            .resultCalculated()

        currentCrossMultiplierDataSource.update(crossMultiplier: _currentCrossMultiplier)
    }

    func clearInputOn(position: (Int, Int)) {
        _currentCrossMultiplier = _currentCrossMultiplier
            .inputClearedAt(position: position)
            .resultCalculated()

        currentCrossMultiplierDataSource.update(crossMultiplier: _currentCrossMultiplier)
    }

    func clearAllInputs() {
        _currentCrossMultiplier = _currentCrossMultiplier
            .allInputsCleared()
            .resultCalculated()

        currentCrossMultiplierDataSource.update(crossMultiplier: _currentCrossMultiplier)
    }

    func addToPastCrossMultipliers() {
        let crossMultiplierToBeCreated = _currentCrossMultiplier.resultCalculated()
        
        if crossMultiplierToBeCreated.isTheResultValid() {
            pastCrossMultipliersDataSource.create(crossMultiplier: crossMultiplierToBeCreated)
        }
    }
}
