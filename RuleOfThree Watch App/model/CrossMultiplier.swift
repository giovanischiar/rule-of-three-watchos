//
//  CrossMultiplier.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 10/11/24.
//

import Foundation

struct CrossMultiplier: Equatable, CustomStringConvertible, Hashable {
    let id: Int64
    var valueAt00: String
    var valueAt01: String
    var valueAt10: String
    var valueAt11: String
    var unknownPosition: (Int, Int)

    init() {
        self.init(
            id: 0,
            valueAt00: "",
            valueAt01: "",
            valueAt10: "",
            valueAt11: "",
            unknownPosition: (1, 1)
        )
    }
    
    // Default initializer
    init(
        id: Int64 = 0,
        valueAt00: String = "",
        valueAt01: String = "",
        valueAt10: String = "",
        valueAt11: String = "",
        unknownPosition: (Int, Int) = (1, 1)
    ) {
        self.id = id
        self.valueAt00 = valueAt00
        self.valueAt01 = valueAt01
        self.valueAt10 = valueAt10
        self.valueAt11 = valueAt11
        self.unknownPosition = unknownPosition
    }

    // Additional initializer for numbers
    init(
        id: Int64 = 0,
        valueAt00: NSNumber? = nil,
        valueAt01: NSNumber? = nil,
        valueAt10: NSNumber? = nil,
        valueAt11: NSNumber? = nil,
        unknownPosition: (Int, Int) = (1, 1)
    ) {
        self.id = id
        self.valueAt00 = valueAt00?.stringValue ?? ""
        self.valueAt01 = valueAt01?.stringValue ?? ""
        self.valueAt10 = valueAt10?.stringValue ?? ""
        self.valueAt11 = valueAt11?.stringValue ?? ""
        self.unknownPosition = unknownPosition
    }
    
    
    // Private initializer for creating CrossMultiplier with inputsMatrix directly
    private init(id: Int64, inputsMatrix: [[Input]], unknownPosition: (Int, Int)) {
        self.id = id
        self.valueAt00 = inputsMatrix[0][0].value
        self.valueAt01 = inputsMatrix[0][1].value
        self.valueAt10 = inputsMatrix[1][0].value
        self.valueAt11 = inputsMatrix[1][1].value
        self.unknownPosition = unknownPosition
    }

    private var inputsMatrix: [[Input]] {
        [
            [Input(value: valueAt00), Input(value: valueAt01)],
            [Input(value: valueAt10), Input(value: valueAt11)]
        ]
    }

    var unknownValue: NSNumber? {
        return inputsMatrix[unknownPosition.0][unknownPosition.1].toNumberOrNull()
    }

    private func inputsMatrixCloned() -> [[Input]] {
        return [
            [inputsMatrix[0][0], inputsMatrix[0][1]],
            [inputsMatrix[1][0], inputsMatrix[1][1]]
        ]
    }
    
    // Computed properties to access different inputs based on the unknown position
    private var differentColumnAndRowToUnknownInput: Input {
        let (i, j) = unknownPosition
        let position = (!i, !j)
        return inputsMatrix[position.0][position.1]
    }

    private var differentRowSameColumnToUnknownInput: Input {
        let (i, j) = unknownPosition
        let position = (!i, j)
        return inputsMatrix[position.0][position.1]
    }

    private var sameRowDifferentColumnToUnknownInput: Input {
        let (i, j) = unknownPosition
        let position = (i, !j)
        return inputsMatrix[position.0][position.1]
    }

    func characterPushedAt(position: (Int, Int), character: String) -> CrossMultiplier {
        var updatedValues = inputsMatrixCloned()
        updatedValues[position.0][position.1] = updatedValues[position.0][position.1].characterPushed(character)
        return CrossMultiplier(id: id, inputsMatrix: updatedValues, unknownPosition: unknownPosition)
    }

    func characterPoppedAt(position: (Int, Int)) -> CrossMultiplier {
        var updatedValues = inputsMatrixCloned()
        updatedValues[position.0][position.1] = updatedValues[position.0][position.1].characterPopped()
        return CrossMultiplier(id: id, inputsMatrix: updatedValues, unknownPosition: unknownPosition)
    }

    func unknownPositionChangedTo(position: (Int, Int)) -> CrossMultiplier {
        var updatedMatrix = inputsMatrixCloned()
        updatedMatrix[unknownPosition.0][unknownPosition.1] = Input()
        updatedMatrix[position.0][position.1] = Input()
        return CrossMultiplier(id: id, inputsMatrix: updatedMatrix, unknownPosition: position)
    }

    func inputClearedAt(position: (Int, Int)) -> CrossMultiplier {
        var updatedMatrix = inputsMatrixCloned()
        updatedMatrix[position.0][position.1] = Input()
        return CrossMultiplier(id: id, inputsMatrix: updatedMatrix, unknownPosition: unknownPosition)
    }

    func allInputsCleared() -> CrossMultiplier {
        return CrossMultiplier(id: id, valueAt00: "", valueAt01: "", valueAt10: "", valueAt11: "", unknownPosition: unknownPosition)
    }

    func isTheResultValid() -> Bool {
        return inputsMatrix[unknownPosition.0][unknownPosition.1].toNumberOrNull() != nil
    }

    func resultCalculated() -> CrossMultiplier {
        guard inputsMatrix.isValid(unknownPosition: unknownPosition) else {
            return self.inputClearedAt(position: unknownPosition)
        }
        var updatedMatrix = inputsMatrixCloned()
        let calculatedValue = (sameRowDifferentColumnToUnknownInput * differentRowSameColumnToUnknownInput) / differentColumnAndRowToUnknownInput
        updatedMatrix[unknownPosition.0][unknownPosition.1] = calculatedValue
        return CrossMultiplier(id: id, inputsMatrix: updatedMatrix, unknownPosition: unknownPosition)
    }

    func withIDChangedTo(newID: Int64) -> CrossMultiplier {
        return CrossMultiplier(id: newID, valueAt00: valueAt00, valueAt01: valueAt01, valueAt10: valueAt10, valueAt11: valueAt11, unknownPosition: unknownPosition)
    }

    // Custom description to match `toString()` in Kotlin
    var description: String {
        let dataMatrix = inputsMatrix.enumerated().map { (i, row) in
            row.enumerated().map { (j, input) -> String in
                if (i, j) == unknownPosition {
                    return input.toNumberOrNull() == nil ? "?" : input.value
                } else {
                    return input.value
                }
            }
        }

        let data = [dataMatrix[0][0], dataMatrix[0][1], dataMatrix[1][0], dataMatrix[1][1]]
        let maxLength = data.map { $0.count }.max() ?? 0
        let adjustedData = data.map { $0.padding(toLength: maxLength, withPad: " ", startingAt: 0) }

        return "\n\(adjustedData[0]) \(adjustedData[1])\n\(adjustedData[2]) \(adjustedData[3])\n"
    }

    // Implementing equality and hash for `Equatable`
    static func == (lhs: CrossMultiplier, rhs: CrossMultiplier) -> Bool {
        return lhs.inputsMatrix == rhs.inputsMatrix && lhs.unknownPosition == rhs.unknownPosition
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(inputsMatrix)
        hasher.combine(unknownPosition.0)
        hasher.combine(unknownPosition.1)
    }
}
