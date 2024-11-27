//
//  HistoryRepository.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 13/11/24.
//

import Combine

class HistoryRepository {
    private var _pastCrossMultipliers: [CrossMultiplier]? = []
    private let pastCrossMultipliersDataSource: PastCrossMultipliersDataSource
    private var cancellables = Set<AnyCancellable>()
    
    init(pastCrossMultipliers: [CrossMultiplier] = []) {
        pastCrossMultipliersDataSource = PastCrossMultipliersLocalDataSource(
            crossMultipliersToInsert: pastCrossMultipliers
        )
        _pastCrossMultipliers = pastCrossMultipliers
    }
    
    var pastCrossMultipliersPublisher: AnyPublisher<[CrossMultiplier], Never> {
        pastCrossMultipliersDataSource.retrieve()
    }
    
    private func updatePastCrossMultiplierAtDataSource(_ crossMultiplierUpdated: CrossMultiplier) {
        pastCrossMultipliersDataSource.update(crossMultiplier: crossMultiplierUpdated.resultCalculated())
    }
    
    func pushCharacterToInputOnPositionOfTheCrossMultiplierAt(index: Int, position: (Int, Int), character: String) {
        guard let pastCrossMultipliers = _pastCrossMultipliers,
              let crossMultiplier = pastCrossMultipliers[safe: index] else { return }
        
        let crossMultiplierUpdated = crossMultiplier.characterPushedAt(position: position, character: character)
        updatePastCrossMultiplierAtDataSource(crossMultiplierUpdated)
    }
    
    func popCharacterOfInputOnPositionOfTheCrossMultiplierAt(index: Int, position: (Int, Int)) {
        guard let pastCrossMultipliers = _pastCrossMultipliers,
              let crossMultiplier = pastCrossMultipliers[safe: index] else { return }
        
        let crossMultiplierUpdated = crossMultiplier.characterPoppedAt(position: position)
        updatePastCrossMultiplierAtDataSource(crossMultiplierUpdated)
    }
    
    func changeTheUnknownPositionToPositionOfTheCrossMultiplierAt(index: Int, position: (Int, Int)) {
        guard let pastCrossMultipliers = _pastCrossMultipliers,
              let crossMultiplier = pastCrossMultipliers[safe: index] else { return }
        
        let crossMultiplierUpdated = crossMultiplier.unknownPositionChangedTo(position: position)
        updatePastCrossMultiplierAtDataSource(crossMultiplierUpdated)
    }
    
    func clearInputOnPositionOfTheCrossMultiplierAt(index: Int, position: (Int, Int)) {
        guard let pastCrossMultipliers = _pastCrossMultipliers,
              let crossMultiplier = pastCrossMultipliers[safe: index] else { return }
        
        let crossMultiplierUpdated = crossMultiplier.inputClearedAt(position: position)
        updatePastCrossMultiplierAtDataSource(crossMultiplierUpdated)
    }
    
    func deleteCrossMultiplierAt(index: Int) {
        guard let pastCrossMultipliers = _pastCrossMultipliers, let crossMultiplierDeleted = pastCrossMultipliers[safe: index] else { return }
        
        pastCrossMultipliersDataSource.delete(crossMultiplier: crossMultiplierDeleted)
    }
    
    func deleteHistory() {
        pastCrossMultipliersDataSource.deleteAll()
    }
}
