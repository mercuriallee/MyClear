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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       let lineView = UIView(frame: CGRectMake( 0, 0, self.contentView.frame.size.width, 0.5 ))
        
       //let lineView = UIView(frame: CGRectMake(x: 0, y: self.contentView.frame.size.height-1,
            //width: self.contentView.frame.size.width, height: 1 ))
        
        lineView.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.2, alpha: 0.1)
        self.addSubview(lineView)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellWithLabel(label: String) {
        self.label.text = label
    }

}
