//
//  SectionView.swift
//  Tic Tac Toe
//
//  Created by Melany on 01.03.2022.
//

import UIKit

@objc protocol SectionViewDelegate {
    func itemSelected(tag: Int)
}

class SectionView: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var delegate: SectionViewDelegate?
    
    let radiusPercent = 2.96
    let borderPercent = 16.0
    
    @IBOutlet weak var button: UIButton! {
        didSet{
            button.backgroundColor = .clear
            button.layer.cornerRadius = bounds.height / radiusPercent
            button.layer.borderWidth = bounds.height / borderPercent
            button.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }

    func initSubviews() {
        let nib = UINib(nibName: String(describing: SectionView.self), bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        button.layoutSubviews()
    }
    
    func populate(model: SectionViewModel) {
        imageView.image = model.image
        button.backgroundColor = model.color
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        delegate?.itemSelected(tag: tag)
    }
}
