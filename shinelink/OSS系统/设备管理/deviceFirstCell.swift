//
//  deviceFirstCell.swift
//  ShinePhone
//
//  Created by sky on 17/5/16.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class deviceFirstCell: UITableViewCell {

var TitleLabel1:UILabel!
    var TitleLabel2:UILabel!
       var TitleLabel3:UILabel!
    var TitleLabel4:UILabel!
 
    var lableArray:NSArray!
        var view0:UIView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
                 TitleLabel1=UILabel()
                 TitleLabel2=UILabel()


        
        lableArray=[TitleLabel1,TitleLabel2]
        
     
        let lableW=140*NOW_SIZE
        for (index,array) in lableArray.enumerated(){
            
        let lable0=array as!UILabel
            lable0.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
            lable0.textAlignment=NSTextAlignment.left
            lable0.font=UIFont.systemFont(ofSize: 11*HEIGHT_SIZE)
              lable0.adjustsFontSizeToFitWidth=true
               lable0.frame=CGRect(x: 10*NOW_SIZE+lableW*CGFloat(Float(index)), y: 7*HEIGHT_SIZE, width: lableW, height: 30*HEIGHT_SIZE)
             self.contentView.addSubview(lable0)
            
            
//            }else{
//                let i=index-2
//            lable0.frame=CGRect(x: 10*NOW_SIZE+160*NOW_SIZE*CGFloat(Float(i)), y: 30*HEIGHT_SIZE, width: 160*NOW_SIZE, height: 30*HEIGHT_SIZE)
//            }
//            lable0.text=""
        
            
        }
        
        view0=UIView()
        view0.frame=CGRect(x: 0*NOW_SIZE, y: 40*HEIGHT_SIZE, width: SCREEN_Width, height: 6*HEIGHT_SIZE)
     view0.backgroundColor=backgroundGrayColor
        
        self.contentView.addSubview(view0)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
