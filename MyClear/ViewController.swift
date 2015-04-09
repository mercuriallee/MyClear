//
//  ViewController.swift
//  MyClear
//
//  Created by Mercurial Lee on 15/4/6.
//  Copyright (c) 2015年 Mercurial Lee. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var listView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let panGestureAnimationTime = 0.2
    let swipeGestureAnimationTime = 0.15
    
    var focusIndexPath: NSIndexPath? = nil
    var completedLength: CGFloat = 0.0
    var maxLength: CGFloat = 0.0
    var sampleCell: CustomCell {
        return self.listView.dequeueReusableCellWithIdentifier("contentCell") as! CustomCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listView.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 1)
        self.listView.separatorStyle  = .None
        
        self.completedLength = self.sampleCell.completeIcon.frame.width
        self.maxLength = self.completedLength * 1.3
        
        //set GestureHandle instance
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "panGestureAction:")
        panGestureRecognizer.delegate = self
        
        self.listView.addGestureRecognizer(panGestureRecognizer)
        
        //let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeGestureAction:")
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + DataManager.getList().count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // First row is title Cell
        if indexPath.row == 0 {
            let cell = self.listView.dequeueReusableCellWithIdentifier("titleCell") as! UITableViewCell
            (cell.subviews[0].subviews[0] as! UILabel).text = "Mytitle"
            cell.backgroundColor = CellStyle.TitleCell.color(indexPath.row)
            return cell
        }
        
        assert(indexPath.row < 1 + DataManager.getList().count)
        
        let cell: CustomCell = self.listView.dequeueReusableCellWithIdentifier("contentCell") as! CustomCell
        cell.setCellWithLabel(DataManager.getList()[indexPath.row-1].text())
       
        switch DataManager.getList()[indexPath.row - 1] {
        case let .TodoItem(item_text):
            cell.label.backgroundColor = CellStyle.ContentCell.color(indexPath.row)!
            cell.leftBlank.backgroundColor = CellStyle.ContentCell.color(indexPath.row)!
            cell.resetStrike()
        case let .DoneItem(item_text):
            cell.label.backgroundColor = UIColor.blackColor()
            cell.leftBlank.backgroundColor = UIColor.blackColor()
            cell.label.textColor = UIColor(hue: 0, saturation: 0, brightness: 0.9, alpha: 0.6)
            cell.showStrike()
        }
        
        cell.backgroundColor = UIColor.blackColor()
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        return
    }
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func panGestureAction(panGestureRecognizer: UIPanGestureRecognizer) {
        
        if panGestureRecognizer.state == .Began {
            self.focusIndexPath = self.listView.indexPathForRowAtPoint(panGestureRecognizer.locationInView(self.listView))
            return
        }
        
        //focusIndexPath is Needed
        if self.focusIndexPath == nil {
            return
        }
        
        let focusCell = self.listView.cellForRowAtIndexPath(self.focusIndexPath!) as! CustomCell
        
        if panGestureRecognizer.state == .Changed{
            
            let translation = panGestureRecognizer.translationInView(self.listView)
            
            //handle right swipe gesture
            if CGVector(point: translation).unitVector.projectionToVector(CGVectorMake(1, 0)).mode > CGFloat(cos(60 * M_PI/180)) {
                
                let translationForCell = CGVector(point: translation).projectionToVector(CGVectorMake(1, 0))
                
                UIView.animateWithDuration(panGestureAnimationTime){
                    //Animation begin
                    self.animationForTodoItem(focusCell, transitionDx: translationForCell.dx)
                }
                
            }
            return
        }
        
        if panGestureRecognizer.state == .Ended {
            //Todo
            if self.focusIndexPath == nil {
                return
            }
            
            let focusCell = self.listView.cellForRowAtIndexPath(self.focusIndexPath!) as! CustomCell
            var completeClosure: ((Bool)-> Void)?
            if focusCell.completeIcon.transform.tx <= 0 {
                focusCell.strike.hidden = true
                completeClosure = {
                    (finished: Bool) in
                    focusCell.resetStrike()
                    self.listView.reloadData()
                }
            }else {
                completeClosure = {
                    (finished: Bool) in
                    DataManager.insert(.DoneItem(focusCell.label.text!), atIndex: countOfTodoItems())
                    DataManager.removeAtIndex(self.focusIndexPath!.row - 1 )
                    self.listView.reloadData()
                }
            }
            
            UIView.animateWithDuration(panGestureAnimationTime, animations: {
                focusCell.label.transform = CGAffineTransformIdentity
                focusCell.leftBlank.transform = CGAffineTransformIdentity
                focusCell.completeIcon.transform = CGAffineTransformIdentity
                },completion: completeClosure)
            return
        }
        
    }
    
    func animationForTodoItem(focusCell: CustomCell, transitionDx: CGFloat) {
        if transitionDx < self.completedLength {
            focusCell.label.transform = CGAffineTransformMakeTranslation(transitionDx, 0)
            focusCell.leftBlank.transform = CGAffineTransformMakeTranslation(transitionDx, 0)
            focusCell.showStrikeWithPercent(transitionDx*1.0 / completedLength)
        }else if transitionDx < maxLength {
            focusCell.label.transform = CGAffineTransformMakeTranslation(transitionDx, 0)
            focusCell.leftBlank.transform = CGAffineTransformMakeTranslation(transitionDx, 0)
            focusCell.completeIcon.transform = CGAffineTransformMakeTranslation(transitionDx - self.completedLength, 0)
            focusCell.label.backgroundColor = colorForCompletedRow()
            focusCell.leftBlank.backgroundColor = colorForCompletedRow()
            focusCell.showStrike()
        }else{
            focusCell.label.transform = CGAffineTransformMakeTranslation(maxLength, 0)
            focusCell.leftBlank.transform = CGAffineTransformMakeTranslation(maxLength, 0)
            focusCell.completeIcon.transform = CGAffineTransformMakeTranslation(maxLength - completedLength, 0)
            focusCell.label.backgroundColor = colorForCompletedRow()
            focusCell.leftBlank.backgroundColor = colorForCompletedRow()
            focusCell.showStrike()
        }
        
    }
    
    
}
