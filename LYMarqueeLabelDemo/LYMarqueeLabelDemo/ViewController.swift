//
//  ViewController.swift
//  LYMarqueeLabelDemo
//
//  Created by gordon on 2018/9/19.
//  Copyright © 2018 rrl360. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x: 50, y: 100, width: 250, height: 50)
        let attr = NSMutableAttributedString.init(string: "981249812093d28r9r")
        attr.addAttribute(.font, value: UIFont.systemFont(ofSize: 15), range: NSMakeRange(0, attr.length))
        let marquee = LYMarqueeLabel.init(frame: rect)
        view.addSubview(marquee)
        marquee.set(marqueeTitle: attr, true)
        
        view.backgroundColor = UIColor.lightGray
    }
}

