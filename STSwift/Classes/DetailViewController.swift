//
//  DetailViewController.swift
//  STSwift
//
//  Created by EasonWang on 14-6-9.
//  Copyright (c) 2014年 SiTE. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController ,UIWebViewDelegate {

    /** 
     城市信息
    
     字段包含 cityName（城市名称）、introduction（城市简介）、imgName（本地图片名称）、detailUrl（详细信息地址）、photosUrl（更多图片地址）
     */
    var cityInfo : NSDictionary?
    
    @IBOutlet var detailWeb : UIWebView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.cityInfo != nil) {
            self.title = self.cityInfo!["cityName"] as? String
        }
        
        let url = NSURL.fileURLWithPath(self.cityInfo!["detailUrl"] as! String)
        
        let request = NSURLRequest(URL:url)

        self.detailWeb!.loadRequest(request)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // web delegate
    func webViewDidFinishLoad(webView: UIWebView){
        
        print("加载完毕！")
        
        
    }

}
