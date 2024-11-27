//
//  Navigation.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 13/11/24.
//

import SwiftUI

struct Navigation: View {
    @EnvironmentObject var crossMultipliersCreatorViewModel: CrossMultipliersCreatorViewModel
    
    @State var isNavigationLinkToHistoryActive = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.init(hex: "#172D21")
                CrossMultipliersCreatorScreen(
                    currentCrossMultiplierUIState: $crossMultipliersCreatorViewModel.currentCrossMultiplierUIState,
                    areTherePastCrossMultipliersUIState: $crossMultipliersCreatorViewModel.areTherePastCrossMultipliersUIState,
                    pushCharacterToInputAt: crossMultipliersCreatorViewModel.pushCharacterToInputAt(position:character:),
                    popCharacterOfInputAt: crossMultipliersCreatorViewModel.popCharacterOfInputAt(position:),
                    clearInputOn: crossMultipliersCreatorViewModel.clearInputOn(position:),
                    changeTheUnknownPositionTo: crossMultipliersCreatorViewModel.changeTheUnknownPositionTo(position:),
                    onSubmitPressed: crossMultipliersCreatorViewModel.addToPastCrossMultipliers,
                    clearAllInputs: crossMultipliersCreatorViewModel.clearAllInputs,
                    onNavigateToHistory: { isNavigationLinkToHistoryActive = true }
                )
                
                NavigationLink(
                    destination: EmptyView(),
                    isActive: $isNavigationLinkToHistoryActive
                ) { EmptyView() }.hidden()
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
    }
}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        let crossMultipliersCreatorRepository = CrossMultipliersCreatorRepository()
        let crossMultipliersCreatorViewModel = CrossMultipliersCreatorViewModel(
            crossMultipliersCreatorRepository: crossMultipliersCreatorRepository
        )
        
        Navigation()
            .environmentObject(crossMultipliersCreatorViewModel)
    }
}
