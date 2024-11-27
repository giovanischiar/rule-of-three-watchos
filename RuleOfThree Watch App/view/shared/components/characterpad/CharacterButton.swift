//
//  CharacterButton.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 20/11/24.
//

import SwiftUI

struct CharacterButton: View {
    var name: String = ""
    var onClick: (_ value: String) -> Void = {_ in}
    
    var body: some View {
        var content: any View = EmptyView()
        switch (name) {
            case "clear": content = AnyView(Image(systemName: "clear"))
            case "enter": content = AnyView(Image(systemName: "arrowtriangle.forward.circle.fill"))
            case "backspace": content = AnyView(Image(systemName: "arrow.left"))
            default: content = AnyView(Text(name).font(.system(size: 25)).fontWeight(.bold))
        }
    
        return
            Button { onClick(name) } label: {
                AnyView(content)
                    .padding(0)
                    .frame(width: 35, height: 35)
                    .overlay(Circle().stroke(Color.init(hex: "#A8A387"), lineWidth: 2))
            }.buttonStyle(PlainButtonStyle())
    }
}

struct CharacterButton_Previews: PreviewProvider {
    static var previews: some View {
        CharacterButton()
    }
}
