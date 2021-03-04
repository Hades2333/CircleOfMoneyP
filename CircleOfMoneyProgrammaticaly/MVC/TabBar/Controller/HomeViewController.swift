//
//  HomeViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import UIKit
import ASPCircleChart

class HomeViewController: UIViewController {

    //MARK: - Variables
    var delegate: GetRootNavDelegate?
    
    //MARK: - GUI Variables
    private lazy var chart: ASPCircleChart = {
        let chart = ASPCircleChart()
        chart.circleWidth = 30.0
        chart.itemSpacing = 0.05
        chart.lineCapStyle = .straight
        chart.latestSliceOnTop = false
        chart.dataSource = self
        return chart
    }()

    private lazy var mainTable: UITableView = {
        let mainTable = UITableView()
        mainTable.separatorStyle = .none
        mainTable.backgroundColor = UIColor(named: "mainBackgroundColor")
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.register(AccountTableViewCell.nib(),
                           forCellReuseIdentifier:  AccountTableViewCell.identifier)
        mainTable.register(CustomAddTableViewCell.nib(),
                           forCellReuseIdentifier:  CustomAddTableViewCell.identifier)
        return mainTable
    }()

    //MARK: - Variables
    var arrayOfMoney: [Double] = []
    var arrayOfColors: [UIColor] = []
    var fetchedCurrency: [String: Double] = [:]

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "mainBackgroundColor")

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "logOut")?.withTintColor(.red),
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(self.backButtonPressed))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "mainBackgroundColor")

        self.edgesForExtendedLayout = []

        chart.reloadData()
        updateValueForChart()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false

        view.addSubviews([self.chart,
                          self.mainTable])

        self.chart.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(60)
            make.height.equalTo(self.chart.snp.width)
        }

        self.mainTable.snp.makeConstraints { (make) in
            make.top.equalTo(self.chart.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }

        NotificationCenter.default.addObserver(self ,
                                               selector: #selector(dataWasUpdated),
                                               name: .accountsAndCategoriesWasUpdated,
                                               object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(Notification.Name.accountsAndCategoriesWasUpdated)
    }

    //MARK: - Methods
    @objc func backButtonPressed() {
        guard let firstStack = delegate?.getRootNav() else { return }
        let root = firstStack.viewControllers[0]
        firstStack.popToViewController(root, animated: false)
    }
    
    @objc func dataWasUpdated() {
        self.mainTable.reloadData()
        updateValueForChart()
    }

    func countMoneyForChart() throws -> [Double] {
        var tempArray: [Double] = []

        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/b8cf407191ff9a2a81cde6e9/latest/USD") else {
            throw NumberError.account
        }

        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in

            guard let self = self else { return }

            if error != nil {
                print(error!)
                return
            }
            guard let safeData = data else { return }
            do {

                let results = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
                self.fetchedCurrency = results.conversion_rates

            } catch {
                print("Ошибка с JSON \(error)")
            }
        }.resume()

        var convertedValue: Double = 0.0

        myCategories.forEach { (category) in

            if category.currency == .USD {
                tempArray.append(category.amountOfMoney)
            } else {
                convertedValue = category.amountOfMoney / (fetchedCurrency["\(category.currency)"]!)
                tempArray.append(convertedValue)
            }
        }
        return tempArray
    }

    func countColorsForChart() -> [UIColor] {
        var tempArray: [UIColor] = []
        myCategories.forEach { (category) in
            tempArray.append(category.color.uiColor)
        }
        return tempArray
    }

    func updateValueForChart() {
        do {
            try self.arrayOfMoney = countMoneyForChart()
        } catch {
            print(error)
        }
        self.arrayOfColors = countColorsForChart()
        self.chart.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if myCategories.count == indexPath.row {
            let next = HomeChooseColorViewController()
            next.modalTransitionStyle = .coverVertical
            next.modalPresentationStyle = .overFullScreen
            self.present(next, animated: false, completion: nil)
        } else {
            let next = HomeDetailViewController()
            next.updateLabelAndId(with: myCategories[indexPath.row].nameOfAccount, id: indexPath.row)
            next.modalTransitionStyle = .coverVertical
            next.modalPresentationStyle = .overFullScreen
            self.present(next, animated: false, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            myCategories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateValueForChart()
        } else if editingStyle == .insert {
            return
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myCategories.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let totalRows = tableView.numberOfRows(inSection: 0)

        if indexPath.row == totalRows - 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomAddTableViewCell.identifier, for: indexPath) as? CustomAddTableViewCell else {
                fatalError("Misconfigured cell type for cell!")
            }
            cell.configureAddCell(title: "Add category")
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AccountTableViewCell.identifier,
                for: indexPath ) as? AccountTableViewCell else {
            fatalError("Misconfigured cell type for cell!")
        }
        cell.configureCategories(myCategories[indexPath.row])
        return cell
    }
}

extension HomeViewController: ASPCircleChartDataSource {

    func numberOfDataPoints() -> Int {
        arrayOfMoney.count
    }

    func dataPointsSum() -> Double {
        return arrayOfMoney.reduce(0.0, { (initial, new) -> Double in
            return initial + new
        })
    }

    func dataPointAtIndex(_ index: Int) -> Double {
        return arrayOfMoney[index]
    }

    func colorForDataPointAtIndex(_ index: Int) -> UIColor {
        arrayOfColors[index]
    }
}
