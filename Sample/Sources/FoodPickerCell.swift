//
//  FoodPickerCell.swift
//  Sample
//
//  Created by Ilya Laryionau on 02/07/2018.
//  Copyright © 2018 larryonoff. All rights reserved.
//

import FatSecretSDK
import Foundation
import UIKit

final class FoodPickerCell: UITableViewCell {

    var item: Food? {
        didSet { _itemDidChange() }
    }

    private func _itemDidChange() {
        textLabel?.text = item?.name
        detailTextLabel?.text = item?.foodDescription
    }
}
