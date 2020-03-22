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
    lazy var flowLayout:UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = UICollectionView.ScrollDirection.vertical
        return flow
    }()
    
    fileprivate let cellId = "cellId"
    lazy var collectionInfoView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.setCollectionViewLayout(self.flowLayout, animated: true)
        cv.dataSource = self
        cv.delegate = self
        cv.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        cv.backgroundColor = .gray
        return cv
    }()
    
    var activity = UIActivityIndicatorView()
    
    //MARK:- Data Variables
    var arrayInfoList = [DataInfoViewModel]()
    
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
        self.view.addSubview(collectionInfoView)

        let views = ["collection":self.collectionInfoView]

        var constraints =  NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collection]-0-|", options: NSLayoutConstraint.FormatOptions.alignAllTop, metrics: nil, views: views)
        self.view.addConstraints(constraints)

        //let stringConstraint = "V:|-\(slice)-[collection]-\(slice)-|"
        let stringConstraint = "V:|-0-[collection]-0-|"

        constraints =  NSLayoutConstraint.constraints(withVisualFormat: stringConstraint, options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: views)
        self.view.addConstraints(constraints)
    }
    
    //MARK:- Fetch Data from API, assign to array, Populate View and assign To collection view cell
    @objc func fetchDataFromAPI() {
        if ReachabilityCheck.isConnectedToNetwork(){
            NetworkService.getDataFromAPI(BaseUrlPath) { (data: DataInfo?, error: Error?) in
                if let err = error{
                    print("Error:\(err.localizedDescription)")
                    UIAlertHelper.presentAlertOnController(self, title: AlertMessages.AlertTitle, message: AlertMessages.CommonError)
                    return
                }
                if let dt = data{
                    //Map data Model Object to view model object
                    self.arrayInfoList = dt.rows.map({ (rowObj: RowInfo) -> DataInfoViewModel in
                        return DataInfoViewModel(dataInfo: rowObj)
                    })
                    DispatchQueue.main.async {
                        self.navigationItem.title = dt.title ?? DefaultString.DefaultNavigationTitle
                        self.collectionInfoView.reloadData()
                    }
                }
            }
        }else{
            UIAlertHelper.presentAlertOnController(self, title: AlertMessages.AlertTitle, message: AlertMessages.MessageInfo)
        }
    }
}

extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionInfoView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InfoCollectionViewCell
        cell.backgroundColor = .white
        let rowObj = arrayInfoList[indexPath.row] //Get ViewModel Object and send to table view cell
        cell.dataInfoModel = rowObj
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad{
            if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight{
                return CGSize(width: (collectionView.frame.size.width-10)/2, height: (collectionView.frame.size.height-10)/2)

            }else{
                return CGSize(width: (collectionView.frame.size.width-5)/2, height: (collectionView.frame.size.height-10)/3)
            }
        }else{
            return CGSize(width: (view.frame.width - 1), height: (view.frame.width - 1))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 1
    }
}

