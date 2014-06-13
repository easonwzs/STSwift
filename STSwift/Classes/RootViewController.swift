//
//  RootViewController.swift
//  STSwift
//
//  Created by EasonWang on 14-6-8.
//  Copyright (c) 2014年 SiTE. All rights reserved.
//

struct Once {
    static let identifier = "STCell"
    static var isRegister : Bool = false
}


import Foundation
import UIKit


class RootViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,STTableViewCellDelegate {
    
    /** tableView */
    @IBOutlet var tableView : UITableView?
    
    /** items */
    var items : NSMutableArray?
    
    
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
        
        self.items = NSMutableArray(contentsOfFile:path)
        
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
        
        if !Once.isRegister {
            let nib = UINib(nibName:"STTableViewCell",bundle:nil)
            self.tableView!.registerNib(nib,forCellReuseIdentifier:Once.identifier)
            Once.isRegister = true
        }

        var cell : STTableViewCell?
        cell = self.tableView!.dequeueReusableCellWithIdentifier(Once.identifier) as STTableViewCell!
        cell!.indexPath = indexPath
        cell!.cityName = cityInfo["cityName"] as String
        cell!.cityIntroduction = cityInfo["introduction"] as String
        cell!.cityImage = UIImage_imageNamed(cityInfo["imgName"] as String)
        cell!.delegate = self
        
        cell!.refreshCell()
        return cell
    }

    
    // STTableViewDelegate
    func didSelectRowAtIndexPath(indexPath:NSIndexPath!){
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
    
   
    func deleteCurrentCell(indexPath:NSIndexPath!){
        
        let cityDic = self.items![indexPath.section] as NSDictionary
        
        cityDic["city"]!.removeObjectAtIndex(indexPath.row)
        
        var indexPaths = [indexPath]
        
        UIView.animateWithDuration(0.25, animations: {
            self.tableView!.deleteRowsAtIndexPaths(indexPaths, withRowAnimation :UITableViewRowAnimation.Fade)
            }, completion:{
                (finished :Bool) in
                if finished {
                    self.tableView!.reloadData()
                }
            })
        
        
        
    }
    
}
