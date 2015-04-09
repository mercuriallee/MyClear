//
//  CustomCell.swift
//  MyClear
//
//  Created by Mercurial Lee on 15/4/6.
//  Copyright (c) 2015年 Mercurial Lee. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var completeIcon: UILabel!
    @IBOutlet weak var leftBlank: UILabel!
    var strike: CALayer! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       //Custom seperator
       let lineView = UIView(frame: CGRectMake( 0, 0, self.contentView.frame.size.width, 0.5 ))
        lineView.backgroundColor = getCustomCellSeperatorColor()
        self.addSubview(lineView)
        
        // add completed icon to the left side
        self.completeIcon.layer.backgroundColor = UIColor.blackColor().CGColor
        self.completeIcon.layer.zPosition = -1
        
        //SelectionStyle to .None avoid color changed
        self.selectionStyle = .None
        
        self.strike = CALayer()
        self.strike.backgroundColor = UIColor.whiteColor().CGColor
        let strikeLength = 1 as CGFloat
        self.strike.frame = CGRectMake(0, self.label.frame.size.height/2, strikeLength, 1)
        
        self.strike.hidden = true
        self.label.layer.addSublayer(self.strike)

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellWithLabel(label: String) {
        self.label.text = label
    }
    
    func resetStrike() {
        self.strike.frame = CGRectMake(0, self.label.frame.size.height/2, 1, 1)
        self.strike.hidden = true
    }
    
    func showStrike() {
        self.showStrikeWithPercent(1)
    }
    
    func showStrikeWithPercent(percent: CGFloat){
        let strikeLength = NSString(string: self.label.text!).sizeWithAttributes([NSFontAttributeName: self.label.font!])
        self.strike.frame = CGRectMake(0, self.label.frame.size.height/2, strikeLength.width*percent, 1)
        self.strike.hidden = false
    }

}
