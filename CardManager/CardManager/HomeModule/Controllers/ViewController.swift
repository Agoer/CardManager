//
//  ViewController.swift
//  CardManager
//  提醒展示主页
//  Created by 李二狗 on 2018/1/10.
//  Copyright © 2018年 李二狗. All rights reserved.
//

import UIKit
import MJRefresh


class ViewController: UIViewController {

    var dataArray:[CMHomeModel] = []
    @IBOutlet weak var tableView: UITableView!
    fileprivate var sectionHeader:CMHomeSectionHeaderView!
    fileprivate var tableViewFooter:CMHomeFooterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.cm_initUI()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func cm_initUI() {
        //tableview
        prepareSectionHeader()
        tableView .register(UINib.init(nibName: "CMHomeCell", bundle: nil), forCellReuseIdentifier: "CMHomeCell")
        prepareTableViewFooter()
        tableView.tableFooterView = tableViewFooter
        
        //添加提醒
        tableViewFooter.addButton.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            let main = UIStoryboard.init(name: "Main", bundle: nil)
            let nav_addVC = main.instantiateViewController(withIdentifier: "nav_CMAddControllerSID") as! UINavigationController

            self.present(nav_addVC, animated: true, completion: {
                
            })
        }
        
        //查看全部
        tableViewFooter.addButton.reactive.controlEvents(.touchUpInside).observeValues { (button) in
           
        }
        
        self.cm_configRefresh()
        
    }
    
    func cm_configRefresh() {
        let header:MJRefreshNormalHeader = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(refreshData))
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.isHidden = true
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
//        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
    }
    
    @objc func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
           self.tableView.mj_header.endRefreshing()
        }
    }
    
    @objc func loadMoreData() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
           self.tableView.mj_footer.endRefreshing()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController {
    
    fileprivate  func prepareSectionHeader() {
        sectionHeader =  Bundle.main.loadNibNamed("CMHomeSectionHeaderView", owner: nil, options: nil)?.first as! CMHomeSectionHeaderView
        sectionHeader.frame  = CGRect(x: 0, y: 0, width: view.frame.width, height: 40)
        sectionHeader.contentView.backgroundColor = UIColor.white
    }
    
    fileprivate  func prepareTableViewFooter() {
        tableViewFooter =  Bundle.main.loadNibNamed("CMHomeFooterView", owner: nil, options: nil)?.first as! CMHomeFooterView
        tableViewFooter.frame  = CGRect(x: 0, y: 0, width: view.frame.width, height: 70)
    }
}

extension ViewController:UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
//        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CMHomeCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

