//
//  Presenter.swift
//  LUIElements
//
//  Created by Ondrej Rafaj on 24/07/2017.
//  Copyright © 2017 manGoweb UK Ltd. All rights reserved.
//

import Foundation
import UIKit


public protocol Presenter: Configurable {
    
    var presentable: Presentable.Type { get }
    
}

public protocol SelectablePresenter: Presenter {
    
    var didSelectCell: (()->())? { get set }
    
}


public protocol PresenterHeaderFooter: Presenter { }
public protocol PresenterHeader: PresenterHeaderFooter { }
public protocol PresenterFooter: PresenterHeaderFooter { }
