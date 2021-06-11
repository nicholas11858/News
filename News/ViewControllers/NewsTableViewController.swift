//
//  NewsTableViewController.swift
//  News
//
//  Created by NIKOLAY OSIPOV on 09.06.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
    // MARK: - Private Properties
    
   private let networkService = NetworkService()
   private let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged )
            return refreshControl
    }()
    
    private var timer: Timer?
    private var oneNews: News?
    private var news: News?
    
    private let jsonUrlString = "https://newsapi.org/v2/everything?q=apple&from=2021-06-08&to=2021-06-08&sortBy=popularity&apiKey=cfacef486c4d4dcabd7b5dfca3045036"
    
    // MARK: - Life Cycles Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        tableView.refreshControl = myRefreshControl
        refresh()
        
        startTimerForRefresh()

    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let articleVC = segue.destination as? ArticleViewController,
              let indexPath = tableView.indexPathForSelectedRow
        else { return }
        
        articleVC.news = self.news?.articles[indexPath.row]
    }
    // MARK: - Private Methods
    
   @objc private func refresh() {
    
    networkService.getNewNews(urlstring: jsonUrlString) { (result) in
        switch result {
        case .success(let news):
            self.news = news
            self.tableView.reloadData()
        case .failure(let error):
            print(error)
        }
    }
    myRefreshControl.endRefreshing()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.articles.count ?? 5
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        let news = self.news?.articles[indexPath.row]
        
        cell.titleLabel.text = news?.title
        cell.descriptionLabel.text = news?.description
        
        return cell
    }
    
    // MARK: - Private Methods
    
    private func startTimerForRefresh() {
        timer = Timer.scheduledTimer(
            timeInterval: 10.0,
            target: self,
            selector: #selector(refresh),
            userInfo: .none,
            repeats: true
        )
    }
}
