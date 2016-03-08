//
//  introductionViewController.swift
//  today2016
//
//  Created by wanghui on 16/3/3.
//  Copyright © 2016年 王辉. All rights reserved.
//

import UIKit

class introductionViewController: UITableViewController {
    var model:listVideoModel!
    var ID: Int!
    //初始化数组
    lazy var dataSourceArr:NSMutableArray = NSMutableArray(capacity: 1)
    
    //将属性声明为setter和getter方法
    var listID:Int!
//        {
//        set {
//            self.ID = newValue
//        }
//        get {
//            return 20
//        }
//    }


    override func viewDidLoad() {
        super.viewDidLoad()
       self.tableView.estimatedRowHeight = 40.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
       //通知中心
        
        let notificationCenter:NSNotificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserver(self, selector: "changeID:", name: "listIDNotfi", object: nil)
    
    }
    
    
    //实现功能
    func  changeID (ID:NSNotification) {
        let list = ID.object as! NSMutableArray
        self.dataSourceArr = list
        print("+++++]]]]]\(list)")
    
        self.tableView.reloadData()

        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }


    //在这里实现传值
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listVideoViewCell", forIndexPath: indexPath)as!listVideoViewCell
        //注意这里给model赋值时的类型
        if self.dataSourceArr.count > 0 {
           let listModel = self.dataSourceArr[indexPath.row] as! listVideoModel
        cell.voluationForModel(listModel)
        }
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
