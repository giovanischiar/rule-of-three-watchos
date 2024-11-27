//
//  RuleOfThreeApp.swift
//  RuleOfThree Watch App
//
//  Created by Giovani Schiar on 10/11/24.
//

import SwiftUI

@main
struct RuleOfThree_Watch_AppApp: App {
    @ObservedObject private var crossMultipliersCreatorViewModel: CrossMultipliersCreatorViewModel
    
    init() {
        let crossMultipliersCreatorRepository = CrossMultipliersCreatorRepository()
        crossMultipliersCreatorViewModel = CrossMultipliersCreatorViewModel(
            crossMultipliersCreatorRepository: crossMultipliersCreatorRepository
        )
    }
    
    var body: some Scene {
        WindowGroup {
            Navigation()
                .environmentObject(crossMultipliersCreatorViewModel)
        }
    }
}
