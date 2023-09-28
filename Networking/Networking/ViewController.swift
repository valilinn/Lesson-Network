//
//  ViewController.swift
//  Networking
//
//  Created by Валентина Лінчук on 27/09/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 400
        
        let nib = UINib(nibName: "PostTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "postTableViewCell")
        
        networkManager.getAllPosts{[weak self] (posts) in
            DispatchQueue.main.async {
                self?.posts = posts
            }
        }
    }

    @IBAction func createPost(_ sender: Any) {
        
        let post = Post(usetId: 1, title: "myTitle", body: "myBody")
        
        networkManager.postCreatePost(post) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Alert!", message: "Created", preferredStyle: .alert)
                self.present(alert, animated: true)
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell()}
        cell.configure(posts[indexPath.row])
        return cell
    }

    
    
}
