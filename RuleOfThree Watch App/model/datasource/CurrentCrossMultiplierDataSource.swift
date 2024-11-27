//
//  CurrentCrossMultiplierDataSource.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 10/11/24.
//

import Foundation
import Combine

protocol CurrentCrossMultiplierDataSource {
    func create(crossMultiplier: CrossMultiplier)
    func retrieve() -> AnyPublisher<CrossMultiplier?, Never>
    func update(crossMultiplier: CrossMultiplier)
}
