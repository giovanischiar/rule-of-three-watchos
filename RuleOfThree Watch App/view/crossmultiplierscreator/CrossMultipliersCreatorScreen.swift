//
//  CrossMultipliersCreatorScreen.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 16/11/24.
//

import SwiftUI

struct CrossMultipliersCreatorScreen: View {
    @Binding var currentCrossMultiplierUIState: CurrentCrossMultiplierUIState
    @Binding var areTherePastCrossMultipliersUIState: AreTherePastCrossMultipliersUIState
    var pushCharacterToInputAt: ((Int, Int), String) -> Void = {_,_ in}
    var popCharacterOfInputAt: ((Int, Int)) -> Void = {_ in}
    var clearInputOn: ((Int, Int)) -> Void = {_ in}
    var changeTheUnknownPositionTo: ((Int, Int)) -> Void = {_ in}
    var onSubmitPressed: () -> Void = {}
    var clearAllInputs: () -> Void = {}
    var onNavigateToHistory: () -> Void
    
    private var crossMultiplier: CrossMultiplierViewData {
        switch (currentCrossMultiplierUIState) {
            case .loading: return CrossMultiplierViewData()
            case .currentCrossMultiplierLoaded(let crossMultiplier): return crossMultiplier
        }
    }
    
    var iconSize = 30.0
    
    var body: some View {
        ZStack {
            CrossMultiplierView(
                crossMultiplier: crossMultiplier,
                onCharacterPressedAt: pushCharacterToInputAt,
                onBackspacePressedAt: popCharacterOfInputAt,
                onClearPressedAt: clearInputOn,
                onLongPressedAt: changeTheUnknownPositionTo,
                onSubmitPressed: onSubmitPressed
            )
            
            VStack {
                Spacer().frame(maxHeight: .infinity)
                Button(action: clearAllInputs) {
                    Image(systemName: "trash")
                }.buttonStyle(BorderlessButtonStyle())
            }
            
            HStack {
                Spacer().frame(maxWidth: .infinity, maxHeight: .infinity)
                switch(areTherePastCrossMultipliersUIState) {
                    case .loading: ProgressView()
                    case .areTherePastCrossMultipliers(let value):
                        if (value) {
                            Button(action: onNavigateToHistory) {
                                Image(systemName: "clock.arrow.circlepath")
                            }.buttonStyle(BorderlessButtonStyle())
                        }
                }
            }
        }.padding()
    }
}

struct CrossMultipliersCreatorScreen_Previews: PreviewProvider {
    static var previews: some View {
        CrossMultipliersCreatorScreen(
            currentCrossMultiplierUIState: .constant(CurrentCrossMultiplierUIState.currentCrossMultiplierLoaded(CrossMultiplierViewData())),
            areTherePastCrossMultipliersUIState: .constant(AreTherePastCrossMultipliersUIState.areTherePastCrossMultipliers(true)),
            onNavigateToHistory: {}
        )
    }
}
