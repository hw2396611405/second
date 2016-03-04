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
    let listurl = "http://v.jxvdy.com/sendfile/iHbRzdNVPrBPX_IjmMFWF61ygRgr92tXGQRY26ce8Iez-zlCTpGhuJcuuTy55tSP4NNJbwBwpI647uOMcuuN1jfI2doagA"
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
    class AVplayerView: UIView {
//        var player : AVPlayer {
//            
//            get {
//                let layer = self.layer as! AVPlayerLayer
//                return layer.player!
//            }
//            
//            set(newPlayer) {
//                
//                let layer = self.layer as! AVPlayerLayer
//                layer.player = newPlayer
//            }
//        }
//        
//        override class func layerClass() -> AnyClass {
//            return AVPlayerLayer.self
//        }
    }
    
    


    

    override func viewDidLoad() {
        super.viewDidLoad()
 
        let urlStr = "http://api2.jxvdy.com/video_info?token=(null)&id=\(ID)"
        let url = NSURL(string: urlStr)
        let  request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        
        let movieurl = NSURL(string: self.listurl)
        self.playerItme = AVPlayerItem(URL:movieurl!)
        //这里对AVPlayerItem的状态，以前进程（progress）进行了监控，并监控视频结束广播消息。前两者是采用KVO的方式进行的
        self.avPlayer = AVPlayer(playerItem:self.playerItme)
        self.avPlayer.play()
        
        print("\(self.playerView.frame.size.height)")
        self.layer = AVPlayerLayer(player: self.avPlayer)
        self.layer.frame = CGRectMake(0, 20, 375, 200)
        self.playerView.layer.insertSublayer(self.layer, atIndex: 0)
        self.heightOfPlayView.constant = 200;
        
        self.playerItme!.addObserver(self, forKeyPath: "status", options: .New, context:nil  )
        self.playerItme!.addObserver(self, forKeyPath: "loadedTimeRanges", options: .New, context: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "myMovieFinishedCallback", name: AVPlayerItemDidPlayToEndTimeNotification, object: self.playerItme)
        
//        let dataTask = session.dataTaskWithRequest(request) { (data :NSData?, resposne : NSURLResponse?, error : NSError?) -> Void in
//            let dic = try!NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
//            let model = listVideoModel.init(dic: dic as! NSDictionary)
//            print("-0---\(model.title)")
//            let dic1:NSDictionary = model.playurl
//            for (key,value) in dic1 {
//                if key.isEqualToString("360P") {
//                    self.movieURL = value as! String
//                    print("+++++\(self.movieURL)")
//                }
//                
//            }
//            
//            
//
//         
//    }
//       dataTask.resume()

        
  
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        print("\(change)")
        
//        let dic = change! as NSDictionary
//        let aaa = dic.objectForKey(NSKeyValueChangeNewKey)
        
//        print("****")
//        
//        switch keyPath!
//        {
//            case "status" :
//                let status = .integerValue as AVPlayerStatus.RawValue
//            print("abc")
//        default :
//            print("default")
//        
//        }
    
    
//    //当AVPlayerItem的状态和进程发生变化时，会接收到KVO事件。
//    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [String : AnyObject], context: UnsafeMutablePointer<Void>) {
//        switch(keyPath) {
//        case ("status"):
//            let status = (change[NSKeyValueChangeNewKey] as!NSNumber).integerValue as AVPlayerStatus.RawValue
//            switch(status){
//            case AVPlayerStatus.ReadyToPlay.rawValue:
//                self.playerView.player.play()
//                
//            case AVPlayerStatus.Failed.rawValue:
//                print("Failed to load video")
//            default:
//                true
//            }
//            //        case ("loadedTimeRanges"):
//            //
//            //            let timeInterval = 10//计算缓冲进度
//            //            let duration = self.playerItme!.duration
//            //            let totalDuration = CMTimeGetSeconds(duration)
//            //            //  print("\(timeInterval/totalDuration)")
//            //
//            //        default:
//            //            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
//            
//        }
//
//        
    }
    
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