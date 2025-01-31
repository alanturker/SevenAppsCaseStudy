//
//  MockUserDelegate.swift
//  SevenAppsCaseStudyTests
//
//  Created by Turker Alan on 30.01.2025.
//

import Foundation
@testable import SevenAppsCaseStudy

final class MockUserDelegate: UserDelegate {
    var receivedOutputs: [UserViewModelOutput] = []

    func notify(_ output: UserViewModelOutput) {
        receivedOutputs.append(output)
    }
}
