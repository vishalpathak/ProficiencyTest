//
//  ViewController.swift
//  ProficiencyTest
//
//  Created by VishalP on 20/03/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK:- UI Compenents
    
    fileprivate var collectionInfoView: UICollectionView!
    fileprivate let cellId = "cellId"
    var activity = UIActivityIndicatorView()
    
    //MARK:- Data Variables
    var arrayInfoList = ["One", "Two", "Three", "Four"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIForViews()
        fetchDataFromAPI()
    }

    //MARK:- Set UI for views
    func setUpUIForViews() -> Void {
        let refresh = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(fetchDataFromAPI))
        self.navigationItem.rightBarButtonItem  = refresh
    
        view.backgroundColor = .white
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 200)
        collectionInfoView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionInfoView.delegate = self
        collectionInfoView.dataSource = self
        collectionInfoView.frame = view.frame
        collectionInfoView.backgroundColor = .green
        collectionInfoView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionInfoView)
    }
    
    //MARK:- Fetch Data from API, assign to array, Populate View and assign To collection view cell
    @objc func fetchDataFromAPI() {
        NetworkService.getDataFromAPI(BaseUrlPath) { (data: DataInfo?, error: Error?) in
            if let err = error{
                print("Error:\(err.localizedDescription)")
                return
            }
            if let dt = data{
                print("All Data:\(dt)")
            }
        }
    }
}

extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionInfoView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}

