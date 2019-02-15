//
//  File.swift
//  Pokedex Project2
//
//  Created by Anita Shen on 2/10/19.
//  Copyright © 2019 Anita Shen. All rights reserved.
//

import Foundation
import UIKit
//import ARMDevSuite

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.data.count
    }
    
    func height(for index: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.badTableView {
            if indexPath.row == 0 {
                print("Current True size is \(tableView.frame.width) x \(height(for: indexPath))")
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "bad") as! BadCell
            
            for subview in cell.contentView.subviews {
                subview.removeFromSuperview()
            }
            // Initialize Cell
            cell.awakeFromNib()
            cell.nameLabel.text = Constants.data[indexPath.row]
            
            if indexPath.row == 0 {
                print("Current Perceived size is \(cell.contentView.frame.width) x \(cell.contentView.frame.height))")
            }
            
            if showFrame {
                cell.addFrames()
            }
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "good") as! GoodCell
            
            for subview in cell.contentView.subviews {
                subview.removeFromSuperview()
            }
            // Initialize Cell
            cell.awakeFromNib()
            
            
            let size = CGSize(width: tableView.frame.width, height: height(for: indexPath))
            cell.initCellFrom(size: size)
            cell.nameLabel.text = Constants.data[indexPath.row]
            
            if showFrame {
                cell.addFrames()
            }
            
            return cell
            
        }
    }
    
    
    
    
}
