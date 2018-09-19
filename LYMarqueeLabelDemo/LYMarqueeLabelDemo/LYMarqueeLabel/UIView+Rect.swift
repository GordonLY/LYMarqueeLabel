//
//  UIView+Rect.swift
//  LY
//
//  Created by 李扬 on 2017/8/31.
//  Copyright © 2017年 李扬. All rights reserved.
//


import UIKit

extension UIView {
    
    // x
    var m_x : CGFloat {
        
        get {
            
            return frame.origin.x
        }
        
        set(newVal) {
            
            var tmpFrame : CGRect = frame
            tmpFrame.origin.x     = newVal
            frame                 = tmpFrame
        }
    }
    
    // y
    var m_y : CGFloat {
        
        get {
            
            return frame.origin.y
        }
        
        set(newVal) {
            
            var tmpFrame : CGRect = frame
            tmpFrame.origin.y     = newVal
            frame                 = tmpFrame
        }
    }
    
    // height
    var m_height : CGFloat {
        
        get {
            
            return frame.size.height
        }
        
        set(newVal) {
            
            var tmpFrame : CGRect = frame
            tmpFrame.size.height  = newVal
            frame                 = tmpFrame
        }
    }
    
    // width
    var m_width : CGFloat {
        
        get {
            
            return frame.size.width
        }
        
        set(newVal) {
            
            var tmpFrame : CGRect = frame
            tmpFrame.size.width   = newVal
            frame                 = tmpFrame
        }
    }
    
    // left
    var m_left : CGFloat {
        
        get {
            
            return m_x
        }
        
        set(newVal) {
            
            m_x = newVal
        }
    }
    
    // right
    var m_right : CGFloat {
        
        get {
            
            return m_x + m_width
        }
        
        set(newVal) {
            
            m_x = newVal - m_width
        }
    }
    
    // top
    var m_top : CGFloat {
        
        get {
            
            return m_y
        }
        
        set(newVal) {
            
            m_y = newVal
        }
    }
    
    // bottom
    var m_bottom : CGFloat {
        
        get {
            
            return m_y + m_height
        }
        
        set(newVal) {
            
            m_y = newVal - m_height
        }
    }
    
    var m_centerX : CGFloat {
        
        get {
            
            return center.x
        }
        
        set(newVal) {
            
            center = CGPoint(x: newVal, y: center.y)
        }
    }
    
    var m_centerY : CGFloat {
        
        get {
            
            return center.y
        }
        
        set(newVal) {
            
            center = CGPoint(x: center.x, y: newVal)
        }
    }
    
    var m_b_center: CGPoint {
        get {
            return CGPoint.init(x: m_middleX, y: m_middleY)
        }
    }
    
    
    var m_middleX : CGFloat {
        get {
            return m_width / 2
        }
    }
    
    var m_middleY : CGFloat {
        get {
            return m_height / 2
        }
    }
    
    var m_middlePoint : CGPoint {
        get {
            return CGPoint(x: m_middleX, y: m_middleY)
        }
    }
    var m_origin: CGPoint  {
        get {
            return self.frame.origin
        }
        set(newVal) {
            var rect = self.frame
            rect.origin = newVal
            self.frame = rect
        }
    }
    
    var m_size: CGSize  {
        get {
            return self.frame.size
        }
        set(newVal) {
            var rect = self.frame
            rect.size = newVal
            self.frame = rect
        }
    }
    
}
