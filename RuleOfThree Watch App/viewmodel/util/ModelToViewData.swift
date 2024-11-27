//
//  ModelExtrensions.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 10/11/24.
//

extension CrossMultiplier {
    func toViewData() -> CrossMultiplierViewData {
        return CrossMultiplierViewData(
            valueAt00: valueAt00,
            valueAt01: valueAt01,
            valueAt10: valueAt10,
            valueAt11: valueAt11,
            unknownPosition: unknownPosition
        )
    }
}

extension Array where Element == CrossMultiplier {
    func toViewDataList() -> [CrossMultiplierViewData] {
        return map { $0.toViewData() }
    }
}
