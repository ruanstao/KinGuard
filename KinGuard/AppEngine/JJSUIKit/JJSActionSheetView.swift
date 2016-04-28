//
//  JJSActionSheetView.swift
//  JJSOA
//
//  Created by 邱弘宇 on 16/1/13.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

import UIKit
class JJSActionSheetView: UIView {
    var actionBlock:((actionRow:Int, actionSheet:JJSActionSheetView)->Void)?
    var backView:UIView!
    var scrollView:UIScrollView!
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private init(buttonAction:((actionRow:Int, actionSheet:JJSActionSheetView)->Void)?,frame:CGRect){
        actionBlock = buttonAction
        super.init(frame: frame)
        scrollView = UIScrollView(frame: CGRectZero)
        addSubview(scrollView)
        backgroundColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0, alpha: 1.0)
    }
    /**
     * 显示视图,默认加载widow上
     */
    class func show(title title:String?,cancelButtonTitle:String?,buttonAction:((actionRow:Int, actionSheet:JJSActionSheetView)->Void)?,moreButtonTitle:Array<String>)->JJSActionSheetView{
        return privateShow(title: title, cancelButtonTitle: cancelButtonTitle, buttonAction: buttonAction, moreButtonTitle: moreButtonTitle)
    }
    class func show(title title:String?,cancelButtonTitle:String?,buttonAction:((actionRow:Int, actionSheet:JJSActionSheetView)->Void)?,moreButtonTitle:String...)->JJSActionSheetView{
        return privateShow(title: title, cancelButtonTitle: cancelButtonTitle, buttonAction: buttonAction, moreButtonTitle: moreButtonTitle)
    }
    
    private class func privateShow(title title:String?,cancelButtonTitle:String?,buttonAction:((actionRow:Int, actionSheet:JJSActionSheetView)->Void)?,moreButtonTitle:Array<String>)->JJSActionSheetView{
        //create back view and showview
        var offset = 0
        let JJSActionSheetViewMaxHeight:CGFloat = 340.0
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        if title != nil{
            offset = 50
        }
        let count = moreButtonTitle.count
        let height:CGFloat = CGFloat(count * 44 + 50 + offset)
        let sheetHeight = height <= JJSActionSheetViewMaxHeight ? height : JJSActionSheetViewMaxHeight
        let sheetY = screenHeight - CGFloat(sheetHeight)
        let showView = JJSActionSheetView(buttonAction:buttonAction,frame: CGRectMake(0, sheetY, screenWidth, CGFloat(sheetHeight)))
        var cancelBtnHeight:CGFloat = 0
        if cancelButtonTitle != nil{
            cancelBtnHeight = 50
        }
        
        //create backview
        showView.backView = UIView(frame:UIScreen.mainScreen().bounds)
        showView.backView.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        showView.backView.alpha = 0
        let tapGesture = UITapGestureRecognizer(target: showView, action: "closeMe:")
        showView.backView.addGestureRecognizer(tapGesture)
        
        //riszie scrollView
        showView.scrollView.frame = CGRectMake(0,CGFloat(offset),screenWidth,sheetHeight - CGFloat(offset) - cancelBtnHeight)
        showView.scrollView.contentSize = CGSizeMake(screenWidth, height - CGFloat(offset) - cancelBtnHeight)
        
        //create title
        if title != nil{
            let titleLabel = UILabel(frame: CGRectMake(0, 0,screenWidth, 44))
            titleLabel.backgroundColor = UIColor.whiteColor()
            titleLabel.text = title
            titleLabel.font = UIFont.systemFontOfSize(17)
            titleLabel.textAlignment = NSTextAlignment.Center
            showView.addSubview(titleLabel)
        }
        
        //create button
        var tag = 0
        for titleStr in moreButtonTitle{
            let btn = UIButton(type: UIButtonType.System)
            btn.tag = tag
            btn.frame = CGRectMake(0, CGFloat(tag * 44), screenWidth , 44)
            btn.setTitle(titleStr, forState: UIControlState.Normal)
            btn.backgroundColor = UIColor.whiteColor()
            btn.tintColor = UIColor.blackColor()
            btn.titleLabel?.font = UIFont.boldSystemFontOfSize(17)
            btn.addTarget(showView, action: "action:", forControlEvents: UIControlEvents.TouchDown)
            showView.scrollView.addSubview(btn)
            
            let line = UIView(frame: CGRectMake(0, CGFloat(tag * 44), screenWidth, 0.5))
            line.backgroundColor = UIColor(red: 0.8902, green: 0.8902, blue: 0.8930, alpha: 1.0)
            showView.scrollView.addSubview(line)
            tag += 1
        }
        
        //add cancel button
        if cancelButtonTitle != nil{
            let btn = UIButton(type: UIButtonType.System)
            btn.frame = CGRectMake(0, sheetHeight - 44, screenWidth , 44)
            btn.titleLabel?.textColor = UIColor.blackColor()
            btn.titleLabel?.font = UIFont.systemFontOfSize(17)
            btn.setTitle(cancelButtonTitle , forState: UIControlState.Normal)
            btn.backgroundColor = UIColor.whiteColor()
            btn.tintColor = UIColor.blackColor()
            btn.addTarget(showView, action: "closeMe:", forControlEvents: UIControlEvents.TouchUpInside)
            showView.addSubview(btn)
        }
        
        let windows = UIApplication.sharedApplication().windows
        for window in windows{
            if window.windowLevel == UIWindowLevelNormal{
                window.addSubview(showView.backView)
                window.addSubview(showView)
            }
        }
        let lastceter = showView.center
        showView.center = CGPointMake(showView.center.x, showView.center.y + CGFloat( sheetHeight))
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            showView.center = lastceter
            showView.backView.alpha = 0.5
            }) { (isCompleted) -> Void in
                
        }
        return showView
    }
    func action(button:UIButton){
        //seletionAnimate(button)
        actionBlock?(actionRow: button.tag,actionSheet:self)
    }
    private func seletionAnimate(view:UIView?){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
           view?.backgroundColor = UIColor.lightGrayColor()
        }) { (finished) -> Void in
           view?.backgroundColor = UIColor.clearColor()
        }
    }
    func dismiss(){
        self.closeMe(nil)
    }
    func closeMe(sender:AnyObject?){
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            self.center = CGPointMake(self.center.x, self.center.y + self.frame.size.height)
            self.backView.alpha = 0
            }) { (isCompleted) -> Void in
                self.removeFromSuperview()
                self.backView.removeFromSuperview()
        }
    }
//    override func drawRect(rect: CGRect) {
//        
//    }

}
