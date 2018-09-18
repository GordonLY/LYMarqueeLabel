//
//  ViewController.swift
//  LYMarqueeLabelDemo
//
//  Created by gordon on 2018/9/18.
//  Copyright © 2018 rrl360. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let rect = CGRect(x: 50, y: 100, width: 260, height: 50)
        let attr = NSAttributedString.init(string: "981249812093d28r9r")
        let marquee = LYMarqueeLabel.init(frame: rect, attrTitle: attr)
        view.addSubview(marquee)
        marquee.start()
        
        view.backgroundColor = UIColor.lightGray
    }


}

