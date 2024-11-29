//
//  InputView.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 17/11/24.
//

import SwiftUI

struct InputView: View {
    var displayValue: String = ""
    var editable: Bool = true
    var onCharacterPressed: (String) -> Void = {_ in}
    var onBackspacePressed: () -> Void = {}
    var onClearPressed: () -> Void = {}
    var onLongPressed: () -> Void = {}
    var onEnterPressed: () -> Void = {}
    
    @State var isCharacterPadShown = false

    private func handleEnterPressed() {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."

        if displayValue == decimalSeparator {
            onClearPressed()
        }

        if !displayValue.isEmpty, displayValue.last == Character(decimalSeparator) {
            onBackspacePressed()
        }
        isCharacterPadShown = false
        onEnterPressed()
    }
    
    var body: some View {
        Button {} label: {
            Text(displayValue)
                .foregroundColor(Color.init(hex: "#FCFCF6"))
                .padding(0)
                .frame(width: 60, height: 60)
                .overlay(Rectangle().stroke(Color.init(hex: "#A8A387"), lineWidth: 2))
        }
        .simultaneousGesture(
            LongPressGesture().onEnded { _ in onLongPressed() }
        )
        .highPriorityGesture(
            TapGesture().onEnded { _ in isCharacterPadShown = true }
        )
        .buttonStyle(BorderlessButtonStyle())
            .fullScreenCover(isPresented: $isCharacterPadShown) {
                CharacterPad(
                    displayValue: displayValue,
                    onCharacterPressed: onCharacterPressed,
                    onBackpacePressed: onBackspacePressed,
                    onClearPressed: onClearPressed,
                    onEnterPressed: { handleEnterPressed() }
                )
            }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
