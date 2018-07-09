//
//  Serving+Measurement.swift
//  FatSecretSDK
//
//  Created by Ilya Laryionau on 05/07/2018.
//  Copyright © 2018 larryonoff. All rights reserved.
//

import Foundation

extension Serving {
    public var measurements: Measurements<Serving> {
        return Measurements(self)
    }
}

// MARK: Nutrients

extension Measurements where Base == Serving {

    // Units

    public var baseEnergyUnit: UnitEnergy {
        return .kilocalories
    }

    public var baseMassUnit: UnitMass {
        switch base.metricServingUnit {
        case "g", "ml":
            return .grams
        case "oz":
            return .ounces
        default:
            return .grams
        }
    }

    // Macronutrients

    // the energy content in kcal
    public var calories: Measurement<UnitEnergy> {
        return Measurement(value: base.calories, unit: .kilocalories)
    }

    // the total carbohydrate content in grams
    public var carbohydrates: Measurement<UnitMass> {
        return Measurement(value: base.carbohydrates, unit: .grams)
    }

    // the cholesterol content in milligrams (where available)
    public var cholesterol: Measurement<UnitMass>? {
        return base.cholesterol
            .flatMap { Measurement(value: $0, unit: .milligrams) }
    }

    // the total fat content in grams
    public var fatTotal: Measurement<UnitMass> {
        return Measurement(value: base.fatTotal, unit: .grams)
    }

    // the monounsaturated fat content in grams (where available)
    public var fatMonounsaturated: Measurement<UnitMass>? {
        return base.fatMonounsaturated
            .flatMap { Measurement(value: $0, unit: .grams) }
    }

    // the polyunsaturated fat content in grams (where available)
    public var fatPolyunsaturated: Measurement<UnitMass>? {
        return base.fatPolyunsaturated
            .flatMap { Measurement(value: $0, unit: .grams) }
    }

    // the saturated fat content in grams (where available)
    public var fatSaturated: Measurement<UnitMass>? {
        return base.fatSaturated
            .flatMap { Measurement(value: $0, unit: .grams) }
    }

    // the trans fat content in grams (where available)
    public var fatTrans: Measurement<UnitMass>? {
        return base.fatTrans
            .flatMap { Measurement(value: $0, unit: .grams) }
    }

    // the fiber content in grams (where available)
    public var fiber: Measurement<UnitMass>? {
        return base.fiber
            .flatMap { Measurement(value: $0, unit: .grams) }
    }

    // the protein content in grams
    public var protein: Measurement<UnitMass> {
        return Measurement(value: base.protein, unit: .grams)
    }

    // the sugar content in grams (where available)
    public var sugar: Measurement<UnitMass>? {
        return base.sugar
            .flatMap { Measurement(value: $0, unit: .grams) }
    }

    // Micronutrients minerals

    // the potassium content in milligrams (where available)
    public var potassium: Measurement<UnitMass>? {
        return base.potassium
            .flatMap { Measurement(value: $0, unit: .milligrams) }
    }

    // the sodium content in milligrams (where available)
    public var sodium: Measurement<UnitMass>? {
        return base.sodium
            .flatMap { Measurement(value: $0, unit: .milligrams) }
    }
}
