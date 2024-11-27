//
//  CrossMultiplierView.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 16/11/24.
//

import SwiftUI

struct CrossMultiplierView: View {
    var crossMultiplier: CrossMultiplierViewData
    var editable: Bool = true
    var onCharacterPressedAt: ((Int, Int), String) -> Void = {_,_ in}
    var onBackspacePressedAt: ((Int, Int)) -> Void = {_ in}
    var onClearPressedAt: ((Int, Int)) -> Void = {_ in}
    var onLongPressedAt: ((Int, Int)) -> Void = {_ in}
    var onSubmitPressed: () -> Void = {}
    
    var body: some View {
        let unknownPosition = crossMultiplier.unknownPosition
        let values = crossMultiplier.values
        let (i, j) = unknownPosition
        var layoutValues: [[AnyView]] = Array(repeating: [AnyView(EmptyView()), AnyView(EmptyView())], count: 2)
        layoutValues[i][j] = AnyView(ResultView(displayValue: crossMultiplier.result))
        layoutValues[!i][j] = AnyView(InputView(
            displayValue: values[!i][j],
            editable: editable,
            onCharacterPressed: { value in onCharacterPressedAt((!i, j), value) },
            onBackspacePressed: { onBackspacePressedAt((!i, j)) },
            onClearPressed: { onClearPressedAt((!i, j)) },
            onLongPressed: { onLongPressedAt((!i, j)) },
            onEnterPressed: onSubmitPressed
        ))
        
        layoutValues[i][!j] = AnyView(InputView(
            displayValue: values[i][!j],
            editable: editable,
            onCharacterPressed: { value in onCharacterPressedAt((i, !j), value) },
            onBackspacePressed: { onBackspacePressedAt((i, !j)) },
            onClearPressed: { onClearPressedAt((i, !j)) },
            onLongPressed: { onLongPressedAt((i, !j)) },
            onEnterPressed: onSubmitPressed
        ))
        
        layoutValues[!i][!j] = AnyView(InputView(
            displayValue: values[!i][!j],
            editable: editable,
            onCharacterPressed: { value in onCharacterPressedAt((!i, !j), value) },
            onBackspacePressed: { onBackspacePressedAt((!i, !j)) },
            onClearPressed: { onClearPressedAt((!i, !j)) },
            onLongPressed: { onLongPressedAt((!i, !j)) },
            onEnterPressed: onSubmitPressed
        ))
        
        return CrossMultiplierLayout(values: layoutValues)
    }
}
