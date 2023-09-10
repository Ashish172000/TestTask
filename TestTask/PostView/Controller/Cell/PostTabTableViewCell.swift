//
//  PostTabTableViewCell.swift
//  TestTask
//
//  Created by Ashish Yadav on 09/09/23.
//

import UIKit

class PostTabTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblNameValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setUI() {
        
        lblNameValue.textColor = UIColor.black.withAlphaComponent(0.6)
        lblBody.textColor = UIColor.black.withAlphaComponent(0.6)
        mainView.layer.shadowRadius = 10
        mainView.layer.cornerRadius = 10
        mainView.layer.borderWidth = 1
        mainView.layer.shadowOpacity = 0.3
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.borderColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 3)
//        let image = viewModel.postData?.isFavourite ?? false ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        btnLike.setImage(UIImage(systemName: "heart"), for: .normal)
        btnLike.setImage(UIImage(systemName: "heart.fill"), for: .selected)
    }
}
