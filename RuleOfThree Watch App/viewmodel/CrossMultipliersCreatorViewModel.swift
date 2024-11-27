//
//  CrossMultipliersCreatorViewModel.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 10/11/24.
//

import Combine

class CrossMultipliersCreatorViewModel: ObservableObject {
    private let crossMultipliersCreatorRepository: CrossMultipliersCreatorRepository
    
    @Published var currentCrossMultiplierUIState: CurrentCrossMultiplierUIState = .loading

    @Published var areTherePastCrossMultipliersUIState: AreTherePastCrossMultipliersUIState = .loading
    
    init(crossMultipliersCreatorRepository: CrossMultipliersCreatorRepository) {
        self.crossMultipliersCreatorRepository = crossMultipliersCreatorRepository
        self.crossMultipliersCreatorRepository
            .currentCrossMultiplierPublisher
            .map { crossMultiplier in CurrentCrossMultiplierUIState.currentCrossMultiplierLoaded(crossMultiplier.toViewData()) }
            .assign(to: &$currentCrossMultiplierUIState)
        
        self.crossMultipliersCreatorRepository
            .areTherePastCrossMultipliersPublisher
            .map { areThereCrossMultipliers in AreTherePastCrossMultipliersUIState.areTherePastCrossMultipliers(areThereCrossMultipliers) }
            .assign(to: &$areTherePastCrossMultipliersUIState)
    }

    func pushCharacterToInputAt(position: (Int, Int), character: String) {
        crossMultipliersCreatorRepository.pushCharacterToInputAt(
            position: position, character: character
        )
    }

    func popCharacterOfInputAt(position: (Int, Int)) {
        crossMultipliersCreatorRepository.popCharacterOfInputAt(position: position)
    }

    func changeTheUnknownPositionTo(position: (Int, Int)) {
        crossMultipliersCreatorRepository.changeTheUnknownPositionTo(position: position)
    }

    func clearInputOn(position: (Int, Int)) {
        crossMultipliersCreatorRepository.clearInputOn(position: position)
    }

    func clearAllInputs() {
        crossMultipliersCreatorRepository.clearAllInputs()
    }

    func addToPastCrossMultipliers() {
        crossMultipliersCreatorRepository.addToPastCrossMultipliers()
    }
}
