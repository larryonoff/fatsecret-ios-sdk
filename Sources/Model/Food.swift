//
//  Food.swift
//  FatSecretSDK
//
//  Created by Ilya Laryionau on 01/07/2018.
//  Copyright © 2018 larryonoff. All rights reserved.
//

import Foundation

struct _Food: Decodable {
    let food: Food
}

struct _FoodServings: Decodable {
    let serving: [Serving]
}

public struct Food: Decodable, Equatable {
    public typealias Id = String

    public enum FoodType: String, Decodable, Equatable {
        case generic = "Generic"
        case brand = "Brand"
    }

    public let id: Id
    public let name: String
    public let foodType: FoodType
    public let brandName: String?
    public let url: URL?
    public let foodDescription: String?

    public let servings: [Serving]?

    // MARK: - Decodable

    private enum CodingKeys: String, CodingKey {
        case foodId
        case foodName
        case foodType
        case brandName
        case foodURL
        case foodDescription
        case servings
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Id.self, forKey: .foodId)
        name = try container.decode(String.self, forKey: .foodName)
        foodType = try container.decode(FoodType.self, forKey: .foodType)
        brandName = try container.decodeIfPresent(String.self, forKey: .brandName)
        url = try container.decodeIfPresent(URL.self, forKey: .foodURL)
        foodDescription = try container.decodeIfPresent(String.self, forKey: .foodDescription)

        let _serving = try container
            .decodeIfPresent(_FoodServings.self, forKey: .servings)
        servings = _serving?.serving
    }
}
