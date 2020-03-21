//
//  InfoCollectionViewCell.swift
//  ProficiencyTest
//
//  Created by VishalP on 21/03/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import UIKit
import SDWebImage

class InfoCollectionViewCell: UICollectionViewCell {
    fileprivate let titleLable: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.numberOfLines = 0
        return title
    }()
    
    fileprivate let descriptionLabel: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.textColor = .black
        description.numberOfLines = 0
        return description
    }()
    
    fileprivate var infoImage: UIImageView? = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViewsAndAutoLayOut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpViewsAndAutoLayOut() {
        
        addSubview(titleLable)
        addSubview(descriptionLabel)
        addSubview(infoImage!)
        
        let constraints = [titleLable.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                           titleLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                           titleLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                           
                           descriptionLabel.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 16),
                           descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                           descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                           
                           infoImage!.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
                           infoImage!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                           infoImage!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                           infoImage!.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK:- Set Data to TableView Cell
    func setData(data: RowInfo){
        titleLable.text = data.title ?? DefaultString.DefaultTitle
        descriptionLabel.text = data.description ?? DefaultString.DefaultDescription
        if let url = data.imageHref{
            let newUrl = URL(string: url)
            self.infoImage!.sd_setImage(with: newUrl) { (image, error, cache, urls) in
                if (error != nil) {
                    // Failed to load image
                    self.infoImage!.image = nil
                } else {
                    // Successful in loading image
                    self.infoImage!.image = image
                }
            }
        }else{
            self.infoImage!.image = nil
        }
    }
    
}
