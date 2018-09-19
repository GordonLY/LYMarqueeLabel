//
//  LYMarqueeTimer.swift
//  LYMarqueeLabelDemo
//
//  Created by gordon on 2018/9/18.
//  Copyright © 2018 rrl360. All rights reserved.
//

import UIKit


extension Timer {
    
    @discardableResult
    public class func lyEvery(_ interval: TimeInterval, _ block: @escaping () -> Void) -> Timer {
        let timer = Timer.lyNew(every: interval, block)
        timer.start()
        return timer
    }
    
    private class func lyNew(every interval: TimeInterval, _ block: @escaping () -> Void) -> Timer {
        return CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent() + interval, interval, 0, 0) { _ in
            block()
        }
    }
    
    private func start(runLoop: RunLoop = .current, modes: RunLoopMode...) {
        let modes = modes.isEmpty ? [.commonModes] : modes
        
        for mode in modes {
            runLoop.add(self, forMode: mode)
        }
    }
}
