//
//  CustomCheckCell.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 4/5/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation
import Eureka

public final class ImageCheckRow<T: Equatable>: Row<T, ImageCheckCell<T>>, SelectableRowType, RowType {
    public var selectableValue: T?
    required public init(tag: String?) {
        super.init(tag: tag)
        displayValueFor = nil
    }
}

public class ImageCheckCell<T: Equatable> : Cell<T>, CellType {
    
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    public override func update() {
        super.update()
    }
    
    public override func setup() {
        super.setup()
        self.row.cellStyle = .Subtitle
    }
    
    public override func didSelect() {
        row.reload()
        row.select()
        row.deselect()
    }
}

public final class ImagePushRow<T: Equatable> : SelectorRow<Speciality, ImageCheckCell<Speciality>, MySelectorViewController<Speciality>>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
        presentationMode = .Show(controllerProvider: ControllerProvider.Callback {
            return MySelectorViewController<Speciality>(){ _ in }
            }, completionCallback: { vc in
                self.updateCell()
                vc.navigationController?.popViewControllerAnimated(true)
        })
    }
}

/// Selector Controller (used to select one option among a list)
public class MySelectorViewController<T:Equatable> : _SelectorViewController<T, ImageCheckRow<T>>  {
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience public init(_ callback: (UIViewController) -> ()){
        self.init(nibName: nil, bundle: nil)
        completionCallback = callback
}
}
