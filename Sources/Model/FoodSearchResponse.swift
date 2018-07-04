//
//  FoodSearchResponse.swift
//  FatSecretSDK
//
//  Created by Ilya Laryionau on 02/07/2018.
//  Copyright © 2018 larryonoff. All rights reserved.
//

import Foundation

struct _FoodSearchResponse: Decodable {
    let foods: FoodSearchResponse
}

public struct FoodSearchResponse: Decodable {

    public let totalResults: Int

    public let pageIndex: Int
    public let pageLength: Int
    
    public let foods: [Food]

    // MARK: - Decodable

    private enum CodingKeys: String, CodingKey {
        case maxResults
        case totalResults
        case pageNumber
        case food
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let totalResultsString = try container.decode(String.self, forKey: .totalResults)
        totalResults = Int(totalResultsString) ?? 0

        let pageIndexString = try container.decode(String.self, forKey: .pageNumber)
        pageIndex = Int(pageIndexString) ?? 0

        let pageLengthString = try container.decode(String.self, forKey: .maxResults)
        pageLength = Int(pageLengthString) ?? 0

        foods = try container.decodeIfPresent([Food].self, forKey: .food) ?? []
    }
}
