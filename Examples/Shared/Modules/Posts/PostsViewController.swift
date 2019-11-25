//
// Created by mac on 9/25/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import UIKit
import RxSwift

final class PostsViewController: UIViewController, ViewControllerProtocol {
    var vm: PostsViewModel!
    var list: [Post] = []
    private let disposeBag = DisposeBag()

  
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
            tableView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPosts()
    }

    private func loadPosts() {
        vm.posts()
                .subscribe(onSuccess: { [weak self] posts in
                    self?.list = posts
                    self?.tableView.reloadData()
                })
                .disposed(by: disposeBag)
    }
}

// MARK: TableView Data Source
extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { list.count }
    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        cell.item = list[indexPath.row]
        return cell
    }

}

// MARK: Options
extension PostsViewController {
    
    @IBAction func showOptions(_ sender: UIButton) {
        let loadPostsAction = UIAlertAction(title: "Load Posts", style: .default) {
            [weak self] alert -> Void in
            Defaults.shared.endpoint = .posts
            self?.loadPosts()
        }
        let error404Action = UIAlertAction(title: "404 Error", style: .default){
            [weak self] alert -> Void in
            Defaults.shared.endpoint = .error404
            self?.loadPosts()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)

        let alertController = UIAlertController(
                title: title,
                message: "Options",
                preferredStyle: .actionSheet
        )

        [loadPostsAction, error404Action, cancel].forEach { alertController.addAction($0) }
        present(alertController, animated: true)
    }
}


