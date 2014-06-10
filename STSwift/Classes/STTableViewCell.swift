//
//  STTableViewCell.swift
//  STSwift
//
//  Created by EasonWang on 14-6-8.
//  Copyright (c) 2014年 SiTE. All rights reserved.
//

import UIKit

class STTableViewCell: UITableViewCell {
    
    @IBOutlet var cityTitle : UILabel?
    @IBOutlet var citySubtitle : UILabel?
    @IBOutlet var cityImageView : UIImageView?
    /** 城市名称 */
    var cityName : String{
    get{
        return self.cityTitle!.text
    }
    set{
        self.cityTitle!.text = newValue
    }
    }
    
    /** 城市简介 */
    var cityIntroduction : String {
    get{
        return self.citySubtitle!.text
    }
    set{
        self.citySubtitle!.text = newValue
    }
    }
    
    /** 城市图片 */
    var cityImage : UIImage{
    get{
        return self.cityImageView!.image
    }
    set{
        self.cityImageView!.image = newValue
    }
    }
    
    
    var delegate : STTableViewCellDelegate{
    get{
        return self.delegate
    }
    set{
        self.delegate = newValue
    }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    override func drawRect(rect: CGRect){
        var swipe = UISwipeGestureRecognizer(target: self, action:Selector("swipeGestureRecognizer") )
        swipe.direction = UISwipeGestureRecognizerDirection.Left
        self.addGestureRecognizer(swipe)
    }
    
    
    func swipeGestureRecognizer(recognizer:UIGestureRecognizer){
        println("swipe")
    }
    
}

protocol STTableViewCellDelegate{

    func deleteCurrentCell()
    
}
