//
//  listVideoModel.swift
//  today2016
//
//  Created by wanghui on 16/3/3.
//  Copyright © 2016年 王辉. All rights reserved.
//

import UIKit

class listVideoModel: NSObject {
    var title :String!
    var Description :String!//描述
    var score: String!
    var directors:String!
    var writers:String!
    var actors:String!
    var Zone:String!//区
    var introduction:String!
    var playurl :NSDictionary!
    var Type:NSArray!
    var year:String!
    
    //定义一个构造方法
    init(dic:NSDictionary) {
        super.init()
       self.setValuesForKeysWithDictionary(dic as! [String : AnyObject]
        )
    }
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
     
        
    }

    
}
