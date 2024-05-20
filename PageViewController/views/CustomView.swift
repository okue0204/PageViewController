//
//  CustomView.swift
//  PageViewController
//
//  Created by 奥江英隆 on 2024/05/21.
//

import UIKit
import Combine

class CustomView: UIView {
    
    @IBOutlet weak var tagButton: UIButton! {
        didSet {
            tagButton.setTitle(pageTag.title, for: .normal)
            tagButton.setTitleColor(pageTag.color, for: .normal)
        }
    }
    
    let pageTag: Tag
    
    private var tagButtonSubject = PassthroughSubject<Void, Never>()
    lazy var tagButtonPublisher = tagButtonSubject.eraseToAnyPublisher()
    
    init(tag: Tag) {
        self.pageTag = tag
        super.init(frame: .zero)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func didTapTagButton(_ sender: Any) {
        tagButtonSubject.send(())
    }
}
