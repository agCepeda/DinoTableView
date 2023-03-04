//
//  DinoTableView.swift
//  DinoTableView
//
//  Created by Agustin Cepeda on 24/02/23.
//

import UIKit


public protocol DinoTableViewDelegate: AnyObject {
}

public protocol DinoTableViewDataSource: AnyObject {
  func getLayoutSettings() -> LayoutSettings
  func getColumns() -> [ColumnModel]
  func getRowCount() -> Int
  func getRow(from index: Int) -> RowModel
}

public class DinoTableView: UIView {
  
  let layout = DinoTableViewLayout()
  
  var dataSource: DinoTableViewDataSource? {
    get { layout.dataSource }
    set { layout.dataSource = newValue }
  }
  var delegate: DinoTableViewDelegate? {
    get { layout.delegate }
    set { layout.delegate = newValue }
  }

  public init() {
    super.init(frame: .zero)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // Only override draw() if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  public override func draw(_ rect: CGRect) {
    // Drawing code
  }
  
}

