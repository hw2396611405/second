 //
//  listVideoViewController.swift
//  today2016
//
//  Created by wanghui on 16/3/3.
//  Copyright © 2016年 王辉. All rights reserved.
//

import UIKit


class listVideoViewController: UIViewController {
    var ID = 0
    var listurl :String!
    //数据源
    lazy var dataArr:NSMutableArray = NSMutableArray (capacity: 1);
    
    @IBOutlet var heightOfPlayView: NSLayoutConstraint!
    @IBOutlet var playerView: UIView!

    
    
    
    
    //播放或暂停
    @IBAction func playOrPauseBtn(sender: AnyObject) {
    }
    //全屏
    
    @IBAction func fullScreenBtn(sender: AnyObject) {
    }
    //进度条
    
    @IBOutlet var progressSlider: UISlider!
    var avPlayer :AVPlayer!//播放器
    var playerItme:AVPlayerItem!//播放项目
    var layer:AVPlayerLayer!
    var isFullScreen:Bool!
    var isEnd:Bool!
    var movieURL:String!
     
    


    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("child:\(self.childViewControllers)")
        let introductionVC:introductionViewController =  self.childViewControllers[0] as! introductionViewController
         introductionVC.listID = self.ID

        
        let urlStr = "http://api2.jxvdy.com/video_info?token=(null)&id=\(self.ID)"
        let url = NSURL(string: urlStr)
        let  request = NSURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request) { (data :NSData?, resposne : NSURLResponse?, error : NSError?) -> Void in
            let dic = try!NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
          let dict = dic.objectForKey("playurl") as! NSDictionary
            self.listurl = dict.objectForKey("360P") as! String
            print(">>>>>>>\(self.listurl)")
            
            // 播放视频
            let movieurl = NSURL(string: self.listurl)
            self.playerItme = AVPlayerItem(URL:movieurl!)
            self.avPlayer = AVPlayer(playerItem:self.playerItme)
            self.avPlayer.play()
            
            
            //初始化AVPlayer
            self.layer = AVPlayerLayer(player: self.avPlayer)
            self.layer.frame = CGRectMake(0, 20, 375, 200)
            self.playerView.layer.insertSublayer(self.layer, atIndex: 0)
            self.heightOfPlayView.constant = 200
            
            let model = listVideoModel.init(dic: dic as!NSDictionary)
           
            print("-0---\(model.title)")
            self.dataArr.addObject(model)
            NSNotificationCenter.defaultCenter().postNotificationName("listIDNotfi", object:self.dataArr)
            
           // self.view.performSelectorOnMainThread("reload1:", withObject: self, waitUntilDone: true)
        }
        dataTask.resume()
        
        

    
        
        
        
        //注意这个代码的顺序 只有先建立播放器,然后再初始化播放器的layer
        
        
//        self.playerItme!.addObserver(self, forKeyPath: "status", options: .New, context:nil  )
//        self.playerItme!.addObserver(self, forKeyPath: "loadedTimeRanges", options: .New, context: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "myMovieFinishedCallback", name: AVPlayerItemDidPlayToEndTimeNotification, object: self.playerItme)
       

  
    }
    
//    func reload1() {
//        // 播放视频
//        let movieurl = NSURL(string: self.listurl)
//        self.playerItme = AVPlayerItem(URL:movieurl!)
//        self.avPlayer = AVPlayer(playerItem:self.playerItme)
//        self.avPlayer.play()
//        
//        //初始化AVPlayer
//        self.layer = AVPlayerLayer(player: self.avPlayer)
//        self.layer.frame = CGRectMake(0, 20, 375, 200)
//        self.playerView.layer.insertSublayer(self.layer, atIndex: 0)
//        self.heightOfPlayView.constant = 200
//    
//    
//    }
    
    
    
      
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    @IBAction func backBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    
    //将属性声明为setter和getter方法
    var listID:Int {
        set {
          self.ID = newValue

      }
        get {
        return 20
        }
    }
    

}