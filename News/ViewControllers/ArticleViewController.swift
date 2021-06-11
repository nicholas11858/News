//
//  ArticleViewController.swift
//  News
//
//  Created by NIKOLAY OSIPOV on 10.06.2021.
//

import UIKit

class ArticleViewController: UIViewController {
    // MARK: - Public Properties
    
    var news: Article? = nil
    // MARK: - IB Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var backButton: UINavigationItem!
    //MARK: - Life Cycles Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let title = news?.title else { return }
        titleLabel.text = title
        guard let content = news?.content else { return }
        contentTextView.text = content
    }
}
