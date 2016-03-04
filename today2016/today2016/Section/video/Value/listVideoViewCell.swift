//
//  listVideoViewCell.swift
//  today2016
//
//  Created by wanghui on 16/3/3.
//  Copyright © 2016年 王辉. All rights reserved.
//

import UIKit

class listVideoViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var directorsLabel: UILabel!
    
    @IBOutlet var writersLabel: UILabel!
    
    @IBOutlet var typeLabel: UILabel!
    
    @IBOutlet var zoneLabel: UILabel!
    
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var introductionLabel: UILabel!
    
    @IBOutlet var pubnickLabel: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    
    //这里简单的方法为写一个方法,有一个参数为model
    
    //重写model的setter的方法为cell的控件赋值
    var listModel:listVideoModel {
        
        set  {
            self.timeLabel.text = listModel.title
            self.scoreLabel.text = listModel.score
            self.descriptionLabel.text = listModel.Description
            self.directorsLabel.text = listModel.directors
            self.writersLabel.text = listModel.writers
            //self.typeLabel.text = listModel.Type
            self.zoneLabel.text = listModel.Zone
            self.yearLabel.text = listModel.year
            self.introductionLabel.text = listModel.introduction
    
            }
        
        get {
            return  self.listModel
            
}
    
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
