//
//  PastCrossMultipliersDataSource.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 13/11/24.
//

import Foundation
import Combine

protocol PastCrossMultipliersDataSource {
    func create(crossMultiplier: CrossMultiplier) -> CrossMultiplier
    func retrieve() -> AnyPublisher<[CrossMultiplier], Never>
    func update(crossMultiplier: CrossMultiplier)
    func delete(crossMultiplier: CrossMultiplier)
    func deleteAll()
}
