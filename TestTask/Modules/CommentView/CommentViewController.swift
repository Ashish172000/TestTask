//
//  CommentViewController.swift
//  TestTask
//
//  Created by Ashish Yadav on 09/09/23.
//

import UIKit

class CommentViewController: BaseViewController {
    @IBOutlet weak var tblView: UITableView!
     lazy var viewModel = CommentViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        callApi()
    }
    func setTableView() {
        tblView.register(UINib(nibName: "PostTabTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTabTableViewCell")
        tblView.dataSource = self
        tblView.delegate = self
        tblView.separatorStyle = .none
    }
    func callApi() {
        self.showActivityIndicator()
        viewModel.getAllComments { [weak self] error in
            guard let self else { return }
            self.hideActivityIndicator()
            if let error = error {
                self.showAlert(message: error, title: "Alert")
            } else {
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
            }
        }
    }
    @objc func actionFavourite(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if let post = viewModel.postData {
            viewModel.postData?.isFavourite = viewModel.postManger.update(post: post, isFav: sender.isSelected)
            
            tblView.reloadSections(IndexSet(integer: 0), with: .none)
        }
    }
}
extension CommentViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections[indexPath.section]
        switch section {
        case .post:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTabTableViewCell", for: indexPath) as! PostTabTableViewCell
            cell.selectionStyle = .none
            cell.lblNameValue.text = viewModel.postData?.title
            
//            let image = viewModel.postData?.isFavourite ?? false ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
//            cell.btnLike.setImage(image, for: .normal)
            cell.btnLike.isSelected = viewModel.postData?.isFavourite ?? false
            cell.lblBody.text = viewModel.postData?.body
            cell.btnLike.addTarget(self, action: #selector(self.actionFavourite(_:)), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        case .comment:
            let data = viewModel.getComments(indexPath: indexPath.row)
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTabTableViewCell", for: indexPath) as! PostTabTableViewCell
            cell.selectionStyle = .none
            cell.lblName.text = "Name"
            cell.btnLike.isHidden = true
            cell.lblNameValue.text = data.name
            cell.lblBody.text = data.body
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width-16, height: 25))
        let label = UILabel()
        label.frame = CGRect(x: 16, y: 5, width: headerView.frame.width - 5, height: headerView.frame.height - 5)
        let title = viewModel.sections[section] == .post ? "Post" : "Comments"
        label.text = title
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 25
    }
}
