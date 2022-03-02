//
//  GameViewController.swift
//  Tic Tac Toe
//
//  Created by Melany on 01.03.2022.
//

import UIKit

protocol GameViewControllable: AnyObject {
    var currentPresenter: GameViewPresentable! { set get }
    func blockUI()
    func unblockUI()
    func updateItem(tag: Int, model: SectionViewModel)
}

class GameViewController: UIViewController {
    var currentPresenter: GameViewPresentable!
    
    @IBOutlet weak var blockView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    fileprivate var block: Bool = true {
        didSet {
            DispatchQueue.main.async {
                self.blockView.isHidden = self.block
            }
        }
    }
}

extension GameViewController: GameViewControllable {
    func updateItem(tag: Int, model: SectionViewModel) {
        let section = view.viewWithTag(tag) as? SectionView
        section?.populate(model: model)
    }
    
    func blockUI() {
        block = false
    }
    
    func unblockUI() {
        block = true
    }
}

extension GameViewController: SectionViewDelegate {
    func itemSelected(tag: Int) {
        currentPresenter.itemSelected(tag: tag)
    }
}
