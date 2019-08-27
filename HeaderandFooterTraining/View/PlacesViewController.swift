//
//  PlacesViewController.swift
//  
//
//  Created by brq on 22/02/2019.
//

import UIKit
import GooglePlaces
class PlacesViewController: UIViewController {

    var tableView = UITableView()
    var likeyPlaces : [GMSPlace] = []
    var selectPlace : GMSPlace?
    let cellReuseIdentifier = UITableViewCell(style: .default , reuseIdentifier: "cell").self
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        constrains()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    func constrains(){
        tableView.anchor(
            top: (view.topAnchor, 0),
            left: (view.leftAnchor, 0),
            right: (view.rightAnchor, 0),
            bottom: (view.bottomAnchor, 0)
        )
    }

    func changeViewMap(){
        let vc = MapsViewController()
        vc.selectPlace = selectPlace
        navigationController?.pushViewController(vc, animated: true)
    }



}


extension PlacesViewController: UITableViewDataSource, UITableViewDelegate{


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return likeyPlaces.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let collectionItem = likeyPlaces[indexPath.row]
        cell.textLabel?.text = collectionItem.name

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / 5
    }


    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == tableView.numberOfSections - 1) {
            return 1
        } else {
            return 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectPlace = likeyPlaces[indexPath.row]
        changeViewMap()
    }
}
