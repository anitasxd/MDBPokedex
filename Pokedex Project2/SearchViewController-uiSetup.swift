//
//  SearchViewController-uiSetup.swift
//  Pokedex Project2
//
//  Created by Anita Shen on 2/10/19.
//  Copyright © 2019 Anita Shen. All rights reserved.
//

import UIKit

extension MainViewController {
    func initUI() {
        let goodLabel = UILabel(frame: LayoutManager.inside(inside: self.view, justified: .TopCenter, verticalPadding: .padding*4, horizontalPadding: 0, width: view.frame.width, height: 30))
        goodLabel.text = "This one works..."
        goodLabel.textAlignment = .center
        view.addSubview(goodLabel)
        
        goodTableView = UITableView(frame: LayoutManager.belowCentered(elementAbove: goodLabel, padding: 0, width: view.frame.width, height: view.frame.height/3))
        goodTableView.delegate = self
        goodTableView.dataSource = self
        goodTableView.register(GoodCell.self, forCellReuseIdentifier: "good")
        goodTableView.layer.borderColor = UIColor.black.cgColor
        goodTableView.layer.borderWidth = 1
        
        view.addSubview(goodTableView)
        
        let badLabel = UILabel(frame: LayoutManager.belowCentered(elementAbove: goodTableView, padding: .padding * 2, width: view.frame.width, height: 30))
        badLabel.text = "and this doesn't."
        badLabel.textAlignment = .center
        view.addSubview(badLabel)
        
        badTableView = UITableView(frame: LayoutManager.belowCentered(elementAbove: badLabel, padding: 0, width: view.frame.width, height: view.frame.height/3))
        badTableView.delegate = self
        badTableView.dataSource = self
        badTableView.register(BadCell.self, forCellReuseIdentifier: "bad")
        badTableView.layer.borderColor = UIColor.black.cgColor
        badTableView.layer.borderWidth = 1
        view.addSubview(badTableView)
        
        
        showFrameButton = UIButton(frame: LayoutManager.inside(inside: self.view, justified: .TopRight, verticalPadding: .padding*2, horizontalPadding: .padding/2, width: 130, height: 30))
        showFrameButton.setTitle("Show Frames", for: .normal)
        showFrameButton.setTitle("Hide Frames", for: .selected)
        showFrameButton.setBackgroundColor(color: .niceBlue, forState: .normal)
        showFrameButton.addTarget(self, action: #selector(toggleFrames(sender:)), for: .touchUpInside)
        showFrameButton.isSelected = self.showFrame
        view.addSubview(showFrameButton)
        
        
    }
    
    @objc func toggleFrames(sender: UIButton) {
        self.showFrame = !self.showFrame
        sender.isSelected = self.showFrame
        goodTableView.reloadData()
        badTableView.reloadData()
        
    }
    
    // UI Initialization Helpers
    
}
