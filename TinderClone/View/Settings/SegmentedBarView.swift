//
//  SegmentedBarView.swift
//  TinderClone
//
//  Created by MacBook on 29/11/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import UIKit

class SegmentedBarView: UIStackView {
    init(numberOfSegment: Int) {
        super.init(frame: .zero)
        
        (0..<numberOfSegment).forEach { (_) in
        let barView = UIView()
        barView.backgroundColor = UIColor()
            addArrangedSubview(barView)
        }
        spacing = 4
        distribution = .fillEqually
        arrangedSubviews.first?.backgroundColor = .white
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setHighLighted(index: Int){
        arrangedSubviews.forEach({$0.backgroundColor = .barDeselectedColor })
        arrangedSubviews[index].backgroundColor = .white
    }
           

}
    


