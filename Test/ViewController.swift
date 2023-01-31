//
//  ViewController.swift
//  Test
//
//  Created by Vanya Bogdantsev on 30.01.2023.
//

import MapboxMaps
import UIKit

private protocol Parentable: AnyObject {
    func adopt(child: UIViewController)
}

extension Parentable where Self: UIViewController {
    fileprivate func adopt(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
}

final class MapViewController: UIViewController, Parentable {
    
    private var mapView: MapView!
    private let bottomSheetVC = BottomSheetViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        adopt(child: bottomSheetVC)
    }
    
    private func setUpMapView() {
        mapView = MapView(frame: view.bounds)
        mapView.location.options.activityType = .fitness
        mapView.location.options.puckType = .puck2D()
        view.addSubview(mapView)
    }
    
}


