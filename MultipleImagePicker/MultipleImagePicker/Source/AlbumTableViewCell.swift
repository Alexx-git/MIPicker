//
//  AlbumTableViewCell.swift
//  MultipleImagePicker
//
//  Created by ALEXANDER on 3/18/19.
//  Copyright © 2019 ALEXANDER. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

	let previewView = AlbumPreviewView()
	let titleLabel = UILabel()
	let countLabel = UILabel()
	var verticalInset: CGFloat = 5.0
	var sideInset: CGFloat = 5.0
	
	

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(previewView)
		
		
//        previewView.autoMatch(.width, to: .height, of: previewView)
//        previewView.autoSetDimension(.height, toSize: 100.0)
//        previewView.autoAlignAxis(toSuperviewAxis: .horizontal)
//        previewView.autoPinEdge(toSuperviewEdge: .top, withInset: verticalInset, relation: .greaterThanOrEqual)
//        previewView.autoPinEdge(toSuperviewEdge: .left, withInset: sideInset)
        
        previewView.match(dimension: .width, toDimension: .height, ofView: previewView)
        previewView.set(dimension: .height, to: 100.0)
        previewView.alignAxis(toSuperViewAxis: .centerY)
        previewView.pin(edgeToSuperViewEdge: .top, withInset: verticalInset, relation: .greaterThanOrEqual)
        previewView.pin(edgeToSuperViewEdge: .left, withInset: sideInset, relation: .equal)
		
		let textContainerView = UIView()
		contentView.addSubview(textContainerView)
//        textContainerView.autoAlignAxis(toSuperviewAxis: .horizontal)
//        textContainerView.autoPinEdge(toSuperviewEdge: .top, withInset: verticalInset, relation: .greaterThanOrEqual)
//        textContainerView.autoPinEdge(toSuperviewEdge: .right)
//        textContainerView.autoPinEdge(.left, to: .right, of: previewView, withOffset: sideInset)
        
        textContainerView.alignAxis(toSuperViewAxis: .centerY)
        textContainerView.pin(edgeToSuperViewEdge: .top, withInset: verticalInset, relation: .greaterThanOrEqual)
        textContainerView.pin(edgeToSuperViewEdge: .right, withInset: 0.0, relation: .equal)
        textContainerView.pin(edge: .left, toEdge: .right, ofView: previewView, withOffset: sideInset, relation: .equal)
		
		textContainerView.addSubview(titleLabel)
		textContainerView.addSubview(countLabel)
		
		
//        titleLabel.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        titleLabel.pin(edgeToSuperViewEdge: .top, withInset: 0.0, relation: .equal)
        titleLabel.pin(edgeToSuperViewEdge: .right, withInset: 0.0, relation: .equal)
        titleLabel.pin(edgeToSuperViewEdge: .left, withInset: 0.0, relation: .equal)
        
//        countLabel.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
//        countLabel.autoPinEdge(.top, to: .bottom, of: titleLabel)
        countLabel.pin(edgeToSuperViewEdge: .right, withInset: 0.0, relation: .equal)
        countLabel.pin(edgeToSuperViewEdge: .left, withInset: 0.0, relation: .equal)
        countLabel.pin(edgeToSuperViewEdge: .bottom, withInset: 0.0, relation: .equal)
        countLabel.pin(edge: .top, toEdge: .bottom, ofView: titleLabel, withOffset: 0.0, relation: .equal)

	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	class func classReuseIdentifier() -> String {
		return  String(describing:self)
	}
	
	class func register(tableView:UITableView) {
		tableView.register(self.classForCoder(), forCellReuseIdentifier: classReuseIdentifier())
	}
	
	class func dequeue(tableView:UITableView) -> Self {
		func helper<T>(tableView:UITableView) -> T where T : AlbumTableViewCell {
			return tableView.dequeueReusableCell(withIdentifier: classReuseIdentifier()) as! T
		}
		return helper(tableView:tableView)
	}
	
}
