//
//  FoodViewController.swift
//  FatSecretSample
//
//  Created by Ilya Laryionau on 02/07/2018.
//  Copyright © 2018 larryonoff. All rights reserved.
//

import FatSecretSDK
import Foundation
import Result
import UIKit

final class FoodViewController: UIViewController {

    @IBOutlet private(set) weak var titleLabel: UILabel?
    @IBOutlet private(set) weak var descriptionLabel: UILabel?
    @IBOutlet private(set) weak var servingsLabel: UILabel?

    private let fatSecretClient: FatSecretClient = {
        return (UIApplication.shared.delegate as! AppDelegate).fatSecretClient
    }()

    var food: Food? = nil {
        didSet { _foodDidChange() }
    }

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        _foodDidChange()
        _requestFood()
    }

    //

    private func _requestFood() {
        guard let food = food else {
            assertionFailure()
            return
        }

        fatSecretClient.food(
            with: food.id,
            completion: { [weak self] result in
                switch result {
                case let .success(food):
                    self?.food = food
                case let .failure(error):
                    debugPrint(error)
                }
            })
    }

    private func _foodDidChange() {
        titleLabel?.text = food?.name
        descriptionLabel?.text = food?.foodDescription

        servingsLabel?.text = food
            .flatMap { $0.servings }?
            .map { serving -> String in
                let strings = [
                    "serving description: \(serving.servingDescription)",
                    "measurement description: \(serving.measurementDescription)"
                ]
                return strings
                    .joined(separator: "\n")
            }
            .joined(separator: "\n\n")
    }
}
