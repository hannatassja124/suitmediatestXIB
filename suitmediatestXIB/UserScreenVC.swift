//
//  userScreenVC.swift
//  suitmediatestXIB
//
//  Created by Hannatassja Hardjadinata on 28/05/22.
//

import Foundation
import UIKit
import MapKit

protocol passData {
  func dismissData(data: user)
}

class UserScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, passData {
    
    var userTableView = UITableView()
    var page = 1
    var per_page = 12
    var userArr = [user]()
    let emptyStateLabel = UILabel()
    let userMapView = MKMapView()
    var arrAnnotation: [MKPlacemark] = []
    var delegate: isAbleToReceiveData!
    let refreshControl = UIRefreshControl()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyBackground()
        
        fetchData()
        setup()
        
        setSubview()
        setAutoLayout()
        
    }
    
    //MARK: - Function
    
    func fetchData() {
        let url = URL(string: "https://reqres.in/api/users?page=\(page)&per_page=\(per_page)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(info.self, from: data)
                    res.data.forEach{ user in
                        self.userArr.append(user)
                    }
                } catch let error {
                    print("error", error)
                }
            }
        }
        task.resume()
    }
    
    func setup() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_show_map.png"), style: .plain, target: self, action: #selector(changeToMapView(sender:)))
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        userTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        userTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "userCell")
        
        userTableView.dataSource = self
        userTableView.delegate = self
        
        userMapView.delegate = self

        userMapView.frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight)

        userMapView.mapType = MKMapType.standard
        userMapView.isZoomEnabled = true
        userMapView.isScrollEnabled = true
        
        userMapView.center = view.center
        
        userMapView.isHidden = true
        
        refreshControl.addTarget(self, action: #selector(refreshTable(refreshControl:)), for: .valueChanged)
        
        userTableView.refreshControl = refreshControl
        
    }
    
    func setSubview() {
        self.view.addSubview(userTableView)
        self.view.addSubview(userMapView)
    }
    
    func setAutoLayout() {
        
    }
    
    func updatePinMap(title: String, location: CLLocationCoordinate2D){
        let pin = MapPin(title: "\(title)", coordinate: location)
        let coordinateRegion = MKCoordinateRegion(center: pin.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        userMapView.setRegion(coordinateRegion, animated: true)
        userMapView.showAnnotations([pin], animated: true)
    }
    
    func addPinMap(){
        for i in 0..<userArr.count {
            updatePinMap(title:"\(userArr[i].id)", location: userArr[i].location)
        }
        
    }
    
    func dismissData(data: user) {
        delegate.pass(data: data)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Button Action
    @objc func changeToMapView(sender: UIButton){
        userMapView.isHidden = !userMapView.isHidden
        userTableView.isHidden = !userTableView.isHidden
        
        if userMapView.isHidden == false {
            addPinMap()
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "Vector.png")
        } else {
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "ic_show_map.png")
        }

    }
    
    @objc func refreshTable(refreshControl: UIRefreshControl){
        print("refresh")
        fetchData()
        userTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
}

//MARK: — MKMapView Delegate Methods
extension UserScreenVC {
   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
       guard !(annotation is MKUserLocation) else {
           return nil
       }

        let annotationIdentifier = "Identifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
           annotationView = dequeuedAnnotationView
           annotationView?.annotation = annotation
       }
       else {
           annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
           annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

       }

        if let annotationView = annotationView {

           annotationView.canShowCallout = true
           annotationView.image = UIImage(named: "ic_pin_point.png")
       }
         return annotationView
       }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("pin tapped")
        
        let coordinateRegion = MKCoordinateRegion(center: view.annotation!.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        userMapView.setRegion(coordinateRegion, animated: true)
        
        var selectedData: user! = nil
        
        guard let id = view.annotation?.title else {
            return
        }

        let num = id ?? ""
        if let foo = userArr.first(where: {$0.id == Int(num)}) {
            selectedData = foo
        }
        
        let vc = bottomSheetVC()
        vc.modalPresentationStyle = .automatic
        
        vc.userData = selectedData
        vc.delegate = self
        
        self.present(vc, animated: true)
    }
}

extension UserScreenVC {
    
    //MARK: - Table Function
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userArr.count == 0 {
            self.userTableView.setEmptyMessage("User Data is Empty")
        } else {
            self.userTableView.restore()
        }
        
        return userArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.pass(data: userArr[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath as IndexPath) as! CustomTableViewCell
        cell.usernameLabel.text = "\(userArr[indexPath.row].first_name) \(userArr[indexPath.row].last_name)"
        cell.emailLabel.text = "\(userArr[indexPath.row].email)"
        guard let imageURL = URL(string: "\(userArr[indexPath.row].avatar)") else {
            fatalError("image not found")
        }
        cell.userIV.load(url: imageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
