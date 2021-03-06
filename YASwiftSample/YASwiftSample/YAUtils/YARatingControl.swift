//
//  YARatingControl.swift
//  Yashica Agrawal
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    // MARK: Properties
    
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    var spacing = 0
    var stars = 5
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        var filledStarImage: UIImage!
        var emptyStarImage: UIImage!
        
        let viewHeight = frame.size.height
        
        if viewHeight > 20.0 {
            filledStarImage = UIImage(named: "iconRatingFilledBig")
            emptyStarImage = UIImage(named: "iconRatingEmptyBig")
        } else {
            filledStarImage = UIImage(named: "iconRatingFilled")
            emptyStarImage = UIImage(named: "iconRatingEmpty")
        }
     //   let filledStarImage = UIImage(named: "iconRatingFilled")
      //  let emptyStarImage = UIImage(named: "iconRatingEmpty")
        
        for _ in 0..<stars {
            
            let button = UIButton()
            
            button.setImage(emptyStarImage, for: UIControl.State())
            button.setImage(filledStarImage, for: .selected)
            button.setImage(filledStarImage, for: [.highlighted, .selected])
            
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), for: .touchDown)
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()

    }
    
    override var intrinsicContentSize : CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + spacing) * stars
        
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Action
    @objc func ratingButtonTapped(_ button: UIButton) {
        rating = ratingButtons.firstIndex(of: button)! + 1
        
        updateButtonSelectionStates()

    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
        }
    }
}
