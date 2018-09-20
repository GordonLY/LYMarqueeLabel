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
public enum LYMarqueeLabelState {
    case none
    case playing
    case pause
    case stop
}

open class LYMarqueeLabel: UIScrollView {
    
    public weak var marqueeDelegate: LYMarqueeLabelDelegate?
    ///  当前的状态
    public private(set) var state = LYMarqueeLabelState.none
    ///  跑马灯文字
    private var marqueeTitle: NSAttributedString
    ///  类型
    private var marqueeType: LYMarqueeLabelType
    ///  速率 秒 [0...10]
    private var marqueeVelocity: TimeInterval
    ///  内边距
    private var marqueeInset: UIEdgeInsets
    ///  每次循环滚动的间距
    private var marqueeSpace: CGFloat
    ///  水平滚动时，给左侧一个空白区域 default = 0
    ///  会与marqueeInset.left叠加，stop时会去掉
    private var horizontailLeftSpace: CGFloat
 
    public init(frame: CGRect = .zero,
         type: LYMarqueeLabelType = .left2right,
         velocity: TimeInterval = 1,
         inset: UIEdgeInsets = .zero,
         space: CGFloat = 30,
         hLeftSpace: CGFloat = 0) {
        self.marqueeTitle = NSAttributedString()
        self.marqueeType = type
        self.marqueeVelocity = velocity
        self.marqueeInset = inset
        self.marqueeSpace = space
        self.horizontailLeftSpace = hLeftSpace
        super.init(frame: frame)
        p_init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var leftLabel = UILabel()
    private lazy var rightLabel = UILabel()
    private var timer: Timer?
}

// MARK: - ********* Public Mehtod
extension LYMarqueeLabel {
    public func set(marqueeTitle attrTitle: NSAttributedString,
                      _ playImmediately: Bool = true) {
        if !attrTitle.isEqual(to: marqueeTitle) {
            self.marqueeTitle = attrTitle
            p_endTimer()
            p_initMarqueeType()
            if playImmediately {
                p_start()
            } else {
                stop()
            }
        }
    }
    /// user for state after pause
    public func play() {
        guard state != .playing else { return }
        if state == .stop {
            p_initMarqueeType()
            p_start()
        } else {
            p_start()
        }
    }
    /// pause at this position
    public func pause() {
        p_endTimer()
        state = .pause
    }
    /// stop scrolling and reset layout
    public func stop() {
        state = .stop
        p_resetLayout()
    }
    public func layoutChanged() {
        p_layoutChanged()
    }
}


// MARK: - ********* Private method of Logic
extension LYMarqueeLabel {
    
    // MARK: === 开始 Marquee
    private func p_start() {
//        guard marqueeTitle.length > 0 else { return }
        state = .playing
        p_startTimer()
    }
    // MARK: === start timer
    private func p_startTimer() {
//        guard marqueeTitle.length > 0 else { return }
        timer = Timer.lyEvery(marqueeVelocity, { [weak self]() in
            guard let `self` = self else { return }
            self.p_updateMarquee()
        })
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
        let maxOffsetX = marqueeInset.left + leftLabel.m_width + marqueeSpace
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
        
        let titleWidth = marqueeTitle.boundingRect(with: CGSize(width: 0, height: self.m_height), options: .usesLineFragmentOrigin, context: nil).width
        let labelWidth = max(titleWidth, self.m_width)
        leftLabel.frame = CGRect(x: marqueeInset.left + horizontailLeftSpace, y: 0, width: labelWidth, height: self.m_height)
        rightLabel.frame = CGRect(x: leftLabel.frame.maxX + marqueeSpace, y: 0, width: labelWidth, height: self.m_height)
        leftLabel.attributedText = marqueeTitle
        rightLabel.attributedText = marqueeTitle
        self.setContentOffset(.zero, animated: false)
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
    // MARK: === reset layout
    private func p_resetLayout() {
        p_endTimer()
        self.setContentOffset(.zero, animated: false)
        leftLabel.m_left = marqueeInset.left
    }
    // MARK: === layout changed
    private func p_layoutChanged() {
        guard marqueeTitle.length > 0 else { return }
        guard leftLabel.superview != nil else { return }
        p_endTimer()
        let titleWidth = marqueeTitle.boundingRect(with: CGSize(width: 0, height: self.m_height), context: nil).width
        let labelWidth = max(titleWidth, self.m_width)
        leftLabel.m_size = CGSize(width: labelWidth, height: self.m_height)
        rightLabel.frame = CGRect(x: leftLabel.frame.maxX + marqueeSpace, y: 0, width: labelWidth, height: self.m_height)
        if state == .playing {
            self.contentOffset = CGPoint(x: self.contentOffset.x + 1, y: self.contentOffset.y)
            p_startTimer()
        } else {
            self.setContentOffset(.zero, animated: false)
        }
    }
}


