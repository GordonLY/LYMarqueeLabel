//
//  LYMarqueeLabel.swift
//  LYMarqueeLabelDemo
//
//  Created by gordon on 2018/9/18.
//  Copyright © 2018 rrl360. All rights reserved.
//

import UIKit

public protocol LYMarqueeLabelDelegate: NSObjectProtocol {
    func marqueeLabel(didClick text: String, atIndex: Int)
}

public enum LYMarqueeLabelType {
    case left2right
    case paragraph
//    case line
}

open class LYMarqueeLabel: UIScrollView {
    
    public weak var marqueeDelegate: LYMarqueeLabelDelegate?
    ///  跑马灯文字
    open var marqueeTitle: NSAttributedString
    ///  类型
    open var marqueeType: LYMarqueeLabelType
    ///  速率 秒 [0...10]
    open var marqueeVelocity: TimeInterval
    ///  内边距
    open var marqueeInset: UIEdgeInsets
    ///  每次循环滚动的间距
    open var marqueeSpace: CGFloat
 
    init(frame: CGRect,
         attrTitle: NSAttributedString,
         type: LYMarqueeLabelType = .left2right,
         velocity: TimeInterval = 1,
         inset: UIEdgeInsets = .zero,
         space: CGFloat = 30) {
        self.marqueeTitle = attrTitle
        self.marqueeType = type
        self.marqueeVelocity = velocity
        self.marqueeInset = inset
        self.marqueeSpace = space
        super.init(frame: frame)
        p_init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        p_endTimer()
    }
    private lazy var leftLabel = UILabel()
    private lazy var rightLabel = UILabel()
    private var timer: Timer?
}

// MARK: - ********* Public Mehtod
extension LYMarqueeLabel {
    public func start() {
        p_start()
    }
    public func pause() {
        p_endTimer()
    }
    public func stop() {
        p_endTimer()
    }
}


// MARK: - ********* Private method of Logic
extension LYMarqueeLabel {
    
    // MARK: === 开始 Marquee
    private func p_start() {
        guard marqueeTitle.length > 0 else { return }
        p_endTimer()
        p_startTimer()
    }
    // MARK: === start timer
    private func p_startTimer() {
        timer = Timer.lyScheduledTimer(withInterval: marqueeVelocity, isRepeat: true, callback: { [weak self](tim) in
            guard let `self` = self else { return }
            self.p_updateMarquee()
        })
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    // MARK: === end timer
    private func p_endTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: === 更新 marquee
    private func p_updateMarquee() {
        switch marqueeType {
        case .left2right:
            p_updateMarqueeLeft2right()
        default:
            break
        }
    }
    // MARK: === 更新 marquee -> left2right
    private func p_updateMarqueeLeft2right() {
        let maxOffsetX = marqueeInset.left + leftLabel.ly_width + marqueeSpace
        if self.contentOffset.x >= maxOffsetX {
            p_endTimer()
            self.contentOffset = CGPoint(x: marqueeInset.left + 1, y: 0)
            p_startTimer()
        }
        else {
            self.contentOffset = CGPoint(x: self.contentOffset.x + 1, y: self.contentOffset.y)
        }
    }
}

// MARK: - ********* Private method of Init
extension LYMarqueeLabel {
    // MARK: === init
    private func p_init() {
        self.backgroundColor = UIColor.white
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        p_initMarqueeType()
        p_initVelocity()
    }
    // MARK: === 初始化 LYMarqueeLabelType
    private func p_initMarqueeType() {
        switch marqueeType {
        case .left2right:
            p_initLeft2right()
        default:
            break
        }
    }
    // MARK: === left2right init
    private func p_initLeft2right() {
        
        let titleWidth = marqueeTitle.boundingRect(with: CGSize(width: 0, height: self.ly_height), options: .usesLineFragmentOrigin, context: nil).width
        let labelWidth = max(titleWidth, self.ly_width)
        leftLabel.frame = CGRect(x: marqueeInset.left, y: 0, width: labelWidth, height: self.ly_height)
        rightLabel.frame = CGRect(x: leftLabel.frame.maxX + marqueeSpace, y: 0, width: labelWidth, height: self.ly_height)
        leftLabel.attributedText = marqueeTitle
        rightLabel.attributedText = marqueeTitle
        self.addSubview(leftLabel)
        self.addSubview(rightLabel)
    }
    private func p_initVelocity() {
        if marqueeVelocity < 0.1 {
            marqueeVelocity = 0.1
        } else if marqueeVelocity > 10 {
            marqueeVelocity = 10
        }
        switch marqueeType {
        case .left2right:
            marqueeVelocity = marqueeVelocity / 30
        default:
            break
        }
    }
}
