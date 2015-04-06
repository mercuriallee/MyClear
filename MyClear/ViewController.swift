//
//  ViewController.swift
//  MyClear
//
//  Created by Mercurial Lee on 15/4/6.
//  Copyright (c) 2015年 Mercurial Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var listView: UITableView!
    
    var toDoList: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listView.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 1)
        self.listView.separatorStyle  = .None
            
        self.toDoList.append("Learn swift")
        self.toDoList.append("Watch TV")
        self.toDoList.append("Take a bath")
        self.toDoList.append("Sleep at 11:00 p.m.")
        self.toDoList.append("Wake up at 8:30 tomorrow")
        self.toDoList.append("Buy berakfast")
        self.toDoList.append("Play game for a while")
        self.toDoList.append("Have lunch")
        self.toDoList.append("\(self.listView.rowHeight)")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count 
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: CustomCell = self.listView.dequeueReusableCellWithIdentifier("cell") as! CustomCell
        cell.setCellWithLabel(toDoList[indexPath.row])
        
        let hue = getHueWithTopHue(0, maxHue: 1/6.8, row: indexPath.row)
        cell.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: 0.9, alpha: 1)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = self.listView.cellForRowAtIndexPath(indexPath) as! CustomCell
        let newBackgroudView = UIImageView(frame: cell.frame)
        newBackgroudView.backgroundColor = UIColor(hue: 1/3.0, saturation: 0.5, brightness: 1, alpha: 1)
        cell.selectedBackgroundView = newBackgroudView
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.toDoList.removeAtIndex(indexPath.row)
        }
        self.listView.reloadData()
    }
    
    func getHueWithTopHue(minHue: CGFloat, maxHue: CGFloat, row: Int) -> CGFloat{
        var applyRows = self.toDoList.count > 7 ?  self.toDoList.count : 7
        return CGFloat(row) * (maxHue - minHue)/CGFloat(applyRows)
    }
    
}

