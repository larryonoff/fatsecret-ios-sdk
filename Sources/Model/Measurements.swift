//
//  Measurements.swift
//  FatSecretSDK
//
//  Created by Ilya Laryionau on 05/07/2018.
//  Copyright © 2018 larryonoff. All rights reserved.
//

import Foundation

public struct Measurements<Base> {
    let base: Base

    init(_ base: Base) {
        self.base = base
    }
}
