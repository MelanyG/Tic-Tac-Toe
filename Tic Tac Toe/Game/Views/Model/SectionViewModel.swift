//
//  SectionViewModel.swift
//  Tic Tac Toe
//
//  Created by Melany on 01.03.2022.
//

import UIKit

struct SectionViewModel {
    var image: UIImage?
    var color: UIColor?

    init(activePlayer: Int, win: Bool) {
        let imageName = activePlayer == 1 ? "close" : "circle"
        image = UIImage(named: imageName)
        color = win ? .blue : .clear
    }
}
