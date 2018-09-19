//
//  LYMarqueeTimer.swift
//  LYMarqueeLabelDemo
//
//  Created by gordon on 2018/9/18.
//  Copyright © 2018 rrl360. All rights reserved.
//

import UIKit


extension Timer {
    
    static func lyScheduledTimer(withInterval interval: TimeInterval, isRepeat: Bool, callback: ((Timer) -> Void)?) -> Timer {
        return self.scheduledTimer(timeInterval: interval, target: self, selector: #selector(p_start(_:)), userInfo: callback, repeats: isRepeat)
    }
    
    @objc static private func p_start(_ timer: Timer) {
        if let callback = timer.userInfo as? ((Timer) -> Void) {
            callback(timer)
        }
    }
}
