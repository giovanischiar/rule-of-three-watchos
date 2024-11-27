//
//  NumberPad.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 20/11/24.
//

import SwiftUI

struct CharacterPad: View {
    var displayValue: String = ""
    var onCharacterPressed: (String) -> Void = {_ in}
    var onBackpacePressed: () -> Void = {}
    var onClearPressed: () -> Void = {}
    var onEnterPressed: () -> Void = {}
    
    var body: some View {
        ZStack {
            Color.init(hex: "#172D21").ignoresSafeArea()
            VStack(spacing: 1) {
                Spacer().frame(maxHeight: .infinity)
                ZStack {
                    Text(displayValue)
                }
                .padding()
                .frame(height: 20, alignment: .center)
                .frame(maxWidth: 107)
                .overlay(Rectangle().stroke(Color.init(hex: "#A8A387"), lineWidth: 2))
                Spacer().frame(height: 5)
                HStack(spacing: 1) {
                    CharacterButton(name: "7", onClick: onCharacterPressed)
                    CharacterButton(name: "8", onClick: onCharacterPressed)
                    CharacterButton(name: "9", onClick: onCharacterPressed)
                }
                
                HStack(spacing: 1) {
                    CharacterButton(name: "clear") { _ in onClearPressed() }
                    Spacer().frame(width: 7)
                    CharacterButton(name: "4", onClick: onCharacterPressed)
                    CharacterButton(name: "5", onClick: onCharacterPressed)
                    CharacterButton(name: "6", onClick: onCharacterPressed)
                    Spacer().frame(width: 7)
                    CharacterButton(name: "enter") { _ in onEnterPressed() }
                }
                
                HStack(spacing: 1) {
                    CharacterButton(name: "1", onClick: onCharacterPressed)
                    CharacterButton(name: "2", onClick: onCharacterPressed)
                    CharacterButton(name: "3", onClick: onCharacterPressed)
                }
                
                HStack(spacing: 1) {
                    CharacterButton(name: "0", onClick: onCharacterPressed)
                    CharacterButton(name: Locale.current.decimalSeparator ?? ".", onClick: onCharacterPressed)
                    CharacterButton(name: "backspace") { _ in self.onBackpacePressed() }
                }
                Spacer().frame(height: 17)
            }.ignoresSafeArea()
        }
    }
}

struct CharacterPad_Previews: PreviewProvider {
    static var previews: some View {
        CharacterPad()
    }
}
