//
//  ViewController.swift
//  TestTask
//
//  Created by Ashish Yadav on 08/09/23.
//

import UIKit

class ViewController: BaseViewController {
    
    @IBOutlet weak var tbleView: UITableView!
   var viewModel = PostViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    func setTableView() {
        tbleView.register(UINib(nibName: "PostTabTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTabTableViewCell")
        tbleView.dataSource = self
        tbleView.delegate = self
        tbleView.separatorStyle = .none
     }
    
    func getData() {
        self.showActivityIndicator()
        viewModel.checkAndGetLocalData() { [weak self] error in
            guard let self else { return }
            self.hideActivityIndicator()
            if let error = error {
                self.showAlert(message: error, title: "Error")
            } else {
                DispatchQueue.main.async {
                    self.tbleView.reloadData()
                }
            }
        }
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postData = viewModel.getItem(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTabTableViewCell", for: indexPath) as! PostTabTableViewCell
        cell.selectionStyle = .none
        cell.lblNameValue.text = postData.title
        cell.btnLike.isHidden = true
        cell.lblBody.text = postData.body
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postData = viewModel.postInfo[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommentViewController")  as! CommentViewController
        vc.viewModel.postData = postData
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

