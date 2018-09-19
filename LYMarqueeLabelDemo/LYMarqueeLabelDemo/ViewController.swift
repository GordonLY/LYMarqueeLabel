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
        
        let rect = CGRect(x: 50, y: 100, width: 260, height: 50)
        let attr = NSAttributedString.init(string: "981249812093d28r9r")
        let marquee = LYMarqueeLabel.init(frame: rect)
        view.addSubview(marquee)
        marquee.start(attr)
        
        view.backgroundColor = UIColor.lightGray
    }


}
