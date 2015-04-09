//
//  ClearAppearance.swift
//  MyClear
//
//  Created by Mercurial Lee on 15/4/8.
//  Copyright (c) 2015年 Mercurial Lee. All rights reserved.
//

import UIKit

enum CellStyle{
    case ContentCell
    case TitleCell
    
    func color(row: Int) -> UIColor?{
        switch self {
        case .ContentCell:
            let hue = getHueWithMinHue(0, 1/6.8, row)
            return UIColor(hue: hue, saturation: 1, brightness: 0.9, alpha: 1)
        case .TitleCell:
            let hue = getHueWithMinHue(0, 1/6.8, row)
            return UIColor.blackColor()
        default:
            return nil
        }
    }
}

func getHueWithMinHue(minHue: CGFloat, maxHue: CGFloat, row: Int) -> CGFloat{
    var applyRows = countOfTodoItems() > 7 ?  countOfTodoItems() : 7
    return CGFloat(row) * (maxHue - minHue)/CGFloat(applyRows)
}

func colorForCompletedRow() -> UIColor {
    return UIColor(hue: 0.30, saturation: 0.9, brightness: 1, alpha: 1)
}

func getCustomCellSeperatorColor() -> UIColor {
    return UIColor(hue: 0, saturation: 0, brightness: 0.2, alpha: 0.1)
}

func getDoneItemTextColor() -> UIColor {
    return UIColor(hue: 0, saturation: 0, brightness: 0.9, alpha: 0.5)
}

func countOfTodoItems() -> Int {
    var count: Int = 0
    for item in DataManager.getList() {
        switch item {
        case let .TodoItem(item_text):
            count = count + 1
        default:
            continue
        }
    }
    return count
}

func countOfDoneItems() -> Int {
    return DataManager.getList().count - countOfTodoItems()
}
