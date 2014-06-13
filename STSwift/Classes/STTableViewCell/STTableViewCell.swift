//
//  STTableViewCell.swift
//  STSwift
//
//  Created by EasonWang on 14-6-8.
//  Copyright (c) 2014 SiTE. All rights reserved.
//
import Foundation
import UIKit

@objc protocol STTableViewCellDelegate{
    
    @optional func deleteCurrentCell(indexPath:NSIndexPath!)
    
    @optional func didSelectRowAtIndexPath(indexPath:NSIndexPath!)
    
}


class STTableViewCell: UITableViewCell {
    
    var indexPath : NSIndexPath?
    
    var delegate : STTableViewCellDelegate?
    
    var oldFrame : CGRect?
    
    @IBOutlet var cusContentView : UIView?
    @IBOutlet var cityTitle : UILabel?
    @IBOutlet var citySubtitle : UILabel?
    @IBOutlet var cityImageView : UIImageView?
    /** cityName */
    var cityName : String{
    get{
        return self.cityTitle!.text
    }
    set{
        self.cityTitle!.text = newValue
    }
    }
    
    /** cityIntroduction */
    var cityIntroduction : String {
    get{
        return self.citySubtitle!.text
    }
    set{
        self.citySubtitle!.text = newValue
    }
    }
    
    /** cityImage */
    var cityImage : UIImage{
    get{
        return self.cityImageView!.image
    }
    set{
        self.cityImageView!.image = newValue
    }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func refreshCell(){
        oldFrame = self.cusContentView!.frame
        
        var swipeL = UISwipeGestureRecognizer(target: self, action:"swipeLeftGestureRecognizer:")
        swipeL.direction = UISwipeGestureRecognizerDirection.Left
        self.addGestureRecognizer(swipeL)
        
        var tap = UITapGestureRecognizer(target: self, action:"tapGestureRecognizer:")
        self.addGestureRecognizer(tap)
        
        
        var swipeR = UISwipeGestureRecognizer(target: self,action:"swipeRightGestureRecognizer:")
        swipeR.direction = UISwipeGestureRecognizerDirection.Right
        self.cusContentView!.addGestureRecognizer(swipeR)
        
        // add delete button
        let delBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        delBtn!.frame = CGRectMake(320, 0, 56, oldFrame!.size.height)
        delBtn!.backgroundColor = UIColor.redColor()
        delBtn!.font = UIFont.systemFontOfSize(14)
        delBtn?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        delBtn?.setTitle("Trash", forState: UIControlState.Normal)
        delBtn?.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.cusContentView!.addSubview(delBtn)
        self.cusContentView!.frame = CGRectMake(0,0,376,56)
    }
    
    // swipe left
    func swipeLeftGestureRecognizer(recognizer:UIGestureRecognizer){
       
        UIView.animateWithDuration(0.25, animations: {
            self.cusContentView!.frame = CGRectMake(-56,self.oldFrame!.origin.y,self.oldFrame!.width,self.oldFrame!.size.height)
            }, completion:{
                (finished :Bool) in
            })
    }
    
    // swipe right
    func swipeRightGestureRecognizer(recognizer:UIGestureRecognizer){
        
        UIView.animateWithDuration(0.25, animations: {
             self.cusContentView!.frame = self.oldFrame!
            }, completion:{
                (finished :Bool) in})
    }
    
    func tapGestureRecognizer(recognizer:UIGestureRecognizer){
        self.delegate!.didSelectRowAtIndexPath?(indexPath!)
    }
    
    //
    func buttonAction(button:UIButton!){
        self.delegate!.deleteCurrentCell?(indexPath!)
    }
    
}

