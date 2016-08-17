//
//  NDNetWorking.swift
//  20160721-swiftStudy
//
//  Created by 刘康蕤 on 16/7/25.
//  Copyright © 2016年 刘康蕤. All rights reserved.
//

import UIKit

// 请求成功的回调
typealias ndFinishReturnBlock = (finishResult : AnyObject)->Void
// 请求失败的回调
typealias ndFaildReturnBlock = (faildResult : NSError)->Void

/// 封装数据请求
class NDNetWorking: NSObject {

    /// 产品列表
    let productListUrl = String("http://"+(NDC_id)+"/app/products.html")
    // 产品详情
    let productDetailUrl = String("http://"+(NDC_id)+"/app/prodDetail.html")
    
    /**
     产品列表的请求
     
     - parameter param:  参数
     - parameter finish: 成功
     - parameter faild:  失败
     */
    func productListRequestWith(param : NSDictionary,finish : ndFinishReturnBlock,faild : ndFaildReturnBlock) {
        
        self.postRequestWithUrl(productListUrl, andParam: param, finish: { (finishResult) -> Void in
            
            finish(finishResult: finishResult)
            
        }) { (faildResult) -> Void in
                
            faild(faildResult: faildResult)
        }
        
    
    }
    
    func productDetailRequestWith(param : NSDictionary,finish : ndFinishReturnBlock,faild : ndFaildReturnBlock) {
        
        self.postRequestWithUrl(productDetailUrl, andParam: param, finish: { (finishResult) -> Void in
            
            finish(finishResult: finishResult)
            
            }) { (faildResult) -> Void in
                
                faild(faildResult: faildResult)
        }
    }
    
    /**
     post请求
     
     - parameter url:   请求地址
     - parameter param: 需要的请求参数
     */
    func postRequestWithUrl(url : String , andParam param : NSDictionary ,finish : ndFinishReturnBlock,faild : ndFaildReturnBlock) {
        let manager = AFHTTPSessionManager()
        manager.POST(url, parameters: param as NSDictionary, progress: { (progress : NSProgress) -> Void in
            
            }, success: { (operation: NSURLSessionDataTask, data: AnyObject?) -> Void in
                
                finish(finishResult: data! as! NSDictionary)
            }) { (operation: NSURLSessionDataTask?, error:NSError) -> Void in
                faild(faildResult: error)
        }
    }
    
    /**
     get请求
     
     - parameter url:    请求地址
     - parameter param:  请求需要的参数
     - parameter finish: 请求成功返回的数据
     - parameter faild:  请求失败返回的错误
     */
    func getRequestWithUrl(url : String , andParam param : NSDictionary, finish : ndFinishReturnBlock, faild : ndFaildReturnBlock) {
        
        let mananger = AFHTTPSessionManager()
        mananger.GET(url, parameters: param as Dictionary, progress: { (progress : NSProgress) -> Void in
            
            }, success: { (operation: NSURLSessionDataTask, data: AnyObject?) -> Void in
                
                finish(finishResult: data! as! NSDictionary)
                
            }) { (operation: NSURLSessionDataTask?, error:NSError) -> Void in
                faild(faildResult: error)
        }
    }
}
