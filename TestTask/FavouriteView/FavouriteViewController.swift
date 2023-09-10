//
//  FavouriteViewController.swift
//  TestTask
//
//  Created by Ashish Yadav on 09/09/23.
//

import UIKit

class FavouriteViewController: BaseViewController {
    @IBOutlet weak var tbleView: UITableView!
    var viewModel = FavouriteViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getfavUser()
        tbleView.reloadData()
    }
    func setTableView() {
        tbleView.register(UINib(nibName: "PostTabTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTabTableViewCell")
        tbleView.dataSource = self
        tbleView.delegate = self
        tbleView.separatorStyle = .none
     }
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension FavouriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postData = viewModel.getItems(indexPath: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTabTableViewCell", for: indexPath) as! PostTabTableViewCell
        cell.selectionStyle = .none
        cell.lblNameValue.text = postData.title
        cell.btnLike.isHidden = true
        cell.lblBody.text = postData.body
        return cell
    }
}
