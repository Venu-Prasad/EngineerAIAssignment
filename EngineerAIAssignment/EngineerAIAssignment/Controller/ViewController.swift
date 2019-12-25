//
//  ViewController.swift
//  EngineerAIAssignment
//
//  Created by Kushal Mandala on 25/12/19.
//  Copyright © 2019 Indovations. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var postListArray : [PostObject] = []
    var page = 1
    var refreshController = UIRefreshControl()
    var selectedPostListArray : [PostObject] = []
    @IBOutlet weak var postTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        refreshController.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        self.postTableView.refreshControl = refreshController
        self.title = "Selected" + String(selectedPostListArray.count)
        self.refreshPage()
    }
    
    @objc func refreshPage(){
        self.page = 1
        self.fetchPosts(currentpage: page)
        self.refreshController.endRefreshing()
    }
    
    func appendPosts(additionalPosts : [PostObject]){
        
        for post in additionalPosts{
            self.postListArray.append(post)
        }
    }
    
    func fetchPosts(currentpage : Int){
        
        let url = config.Base_URL + "\(currentpage)"
        NetworkManager.getPosts(url: url) { (PostsList) in
            if self.page == 1
            {
                self.postListArray = PostsList.hits
            }
            else
            {
                self.appendPosts(additionalPosts: PostsList.hits)
            }
            DispatchQueue.main.async {
                self.refreshController.endRefreshing()
                self.postTableView.reloadData()
            }
        }
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let postObject = self.postListArray[indexPath.row]
        cell.lblTitle.text = postObject.title
        cell.lblCreatedAt.text = postObject.created_at
        
        if self.selectedPostListArray.contains(where: { $0.objectID == postObject.objectID }) {
            cell.toggle.setOn(true, animated: true)
        }
        else
        {
            cell.toggle.setOn(false, animated: true)
            
        }
        cell.toggle.addTarget(self, action: #selector(toggleSelected), for: .valueChanged)
        if indexPath.row == self.postListArray.count-1 {
            self.loadMore()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let post = self.postListArray[indexPath.row]
        if let post = selectedPostListArray.firstIndex(where: { $0.objectID == post.objectID}){
            self.selectedPostListArray.remove(at: post)
        }
        else
        {
            self.selectedPostListArray.append(post)
        }
        self.title = "Selected" + String(self
            .selectedPostListArray.count)
        postTableView.reloadData()
    }
    
    func loadMore(){
        page = page + 1
        self.fetchPosts(currentpage: page)
    }
    
    @objc func toggleSelected(sender: UISwitch){
        
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: self.postTableView)
        let indexPath = self.postTableView.indexPathForRow(at: buttonPosition)
        let post = self.postListArray[indexPath!.row]
        
        if let post = selectedPostListArray.firstIndex(where: { $0.objectID == post.objectID}){
            self.selectedPostListArray.remove(at: post)
        }
        else
        {
            self.selectedPostListArray.append(post)
        }
        self.title = "Selected" + String(self
            .selectedPostListArray.count)
        postTableView.reloadData()
    }
}

