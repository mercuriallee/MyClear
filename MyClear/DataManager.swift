//
//  DataManager.swift
//  MyClear
//
//  Created by Mercurial Lee on 15/4/9.
//  Copyright (c) 2015年 Mercurial Lee. All rights reserved.
//

import UIKit

enum ListItem {
    case DoneItem(String)
    case TodoItem(String)
    
    func text() -> String {
        switch self {
        case let .DoneItem(item_text):
            return item_text
        case let .TodoItem(item_text):
            return item_text
        }
    }
}

private var globalList: [ListItem]? = nil

class DataManager: NSObject {
    
    private class func initData() {
        //initData
        if globalList == nil {
            globalList = [ListItem]()
            
            globalList!.append(.TodoItem("Learn swift"))
            globalList!.append(.TodoItem("Watch TV"))
            globalList!.append(.TodoItem("Take a bath"))
            globalList!.append(.TodoItem("Sleep at 11:00 p.m."))
            globalList!.append(.TodoItem("Wake up at 8:30 tomorrow"))
            globalList!.append(.TodoItem("Buy berakfast"))
            globalList!.append(.TodoItem("Play game for a while"))
            globalList!.append(.TodoItem("Have lunch"))
            
            globalList!.append(.DoneItem("done globalList 1"))
        }

    }
    
    class func getList() -> [ListItem] {
        
        self.initData()
        
        return globalList!
    }
    
    class func removeAtIndex(index: Int) {
        self.initData()
        
        globalList?.removeAtIndex(index)
    }
    
    class func insert(newItem: ListItem, atIndex: Int) {
        globalList?.insert(newItem, atIndex: atIndex)
    }

}
