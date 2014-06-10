//
//  RootViewController.swift
//  STSwift
//
//  Created by EasonWang on 14-6-8.
//  Copyright (c) 2014年 SiTE. All rights reserved.
//


import Foundation
import UIKit


class RootViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    /** tableView */
    @IBOutlet var tableView : UITableView?
    
    /** items */
    var items : NSArray?
    
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "STSwift"
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // load data
    func loadData(){        
        
        let path : String = NSBundle.mainBundle().pathForResource("cityPlist", ofType:"plist")
        
        self.items = NSArray(contentsOfFile:path)
        
    }
    
    func UIImage_imageNamed(imageName:String) -> UIImage{
       
        var image  = UIImage(named: imageName)
        
        return image
    }

    

    // UITableViewDataSource Methods
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return self.items!.count
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String!{
        let dic : NSDictionary = self.items![section] as NSDictionary
        return dic["country"] as NSString 
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        let dic : NSDictionary = self.items![section] as NSDictionary
        return dic["city"]!.count
    }
    

    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let section = indexPath.section
        let row = indexPath.row
        
        let cityDic = self.items![section] as NSDictionary
        let cities = cityDic["city"] as NSArray
        let cityInfo = cities[row] as NSDictionary
        
        // 此处定义struct是因为静态属性只可以在类型声明
        struct Once {
            static let identifier = "STCell"
            static var isRegister : Bool = false
        }
        
        if !Once.isRegister {
            let nib = UINib(nibName:"STTableViewCell",bundle:nil)
            self.tableView!.registerNib(nib,forCellReuseIdentifier:Once.identifier)
            Once.isRegister = true
        }
        
        // 定义cell
        var cell : STTableViewCell?
        // 获取cell
        cell = self.tableView!.dequeueReusableCellWithIdentifier(Once.identifier) as STTableViewCell!
        
        // 设置cell上属性
        cell!.cityName = cityInfo["cityName"] as String
        cell!.cityIntroduction = cityInfo["introduction"] as String
        cell!.cityImage = UIImage_imageNamed(cityInfo["imgName"] as String)
        
        cell!.setNeedsLayout()
        
        return cell
    }


    
    // UITableViewDelegate Methods
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        self.tableView!.deselectRowAtIndexPath(indexPath, animated: true)
        
        let section = indexPath!.section
        let row = indexPath!.row
        
        let cityDic = self.items![section] as NSDictionary
        let cities = cityDic["city"] as NSArray
        let cityInfo = cities[row] as NSDictionary
        
        var detailViewController = DetailViewController(nibName:"DetailViewController",bundle:nil)
        
        detailViewController.cityInfo = cityInfo
        
        self.navigationController.pushViewController(detailViewController, animated:true)
    }

    
}
