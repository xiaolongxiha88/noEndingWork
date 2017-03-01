//
//  swiftHeader.swift
//  ShinePhone
//
//  Created by sky on 16/12/9.
//  Copyright © 2016年 sky. All rights reserved.
//

import UIKit

let NOW_SIZE = UIScreen.main.bounds.width/320
let HEIGHT_SIZE = UIScreen.main.bounds.height/560

func COLOR(_R:Float,_G:Float,_B:Float,_A: Float) -> UIColor {
    return   UIColor.init(colorLiteralRed: _R / 255.0, green: _G / 255.0, blue: _B / 255.0, alpha: _A)
}

let MainColor=COLOR(_R: 17, _G: 183, _B: 243, _A: 1)
let SCREEN_Width=UIScreen.main.bounds.width
let SCREEN_Height=UIScreen.main.bounds.height

let HEAD_URL=UserInfo.default().server


 let root_rf_sn=NSLocalizedString("RF序列号", comment: "default")
 let root_datalog_sn=NSLocalizedString("datalog sn", comment: "default")
 let root_datalog_checkCode=NSLocalizedString("datalogger checkcode", comment: "default")
let  root_finish = NSLocalizedString("完成", comment: "default")

let  root_caiJiQi = NSLocalizedString("请输入采集器序列号", comment: "default")
let  root_jiaoYanMa = NSLocalizedString("请输入采集器校验码", comment: "default")
let  root_jiaoYanMa_zhengQue = NSLocalizedString("请输入正确采集器校验码", comment: "default")
let  root_shuru_rf_sn = NSLocalizedString("请输入RFStick序列号", comment: "default")
let  root_peizhi_chenggong = NSLocalizedString("配置成功", comment: "default")
let  root_Networking = NSLocalizedString("Networking Timeout", comment: "default")



