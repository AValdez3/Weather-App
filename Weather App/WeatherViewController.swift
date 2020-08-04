//
//  ViewController.swift
//  Weather App
//
//  Created by Avelardo Valdez on 8/4/20.
//  Copyright © 2020 Avelardo Valdez. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    let weatherInformation = WeatherInformation()
    let cityNameLabel = UILabel()
    let temperatureLabel = UILabel()
    let conditionLabel = UILabel()
    let chooseCityButton = UIButton(type: .system)
    
    var cityNameWeatherInformationStack: UIStackView!
    var temperatureStackView: UIStackView!
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpCityNameLabel()
        setUpTemperatureLabel()
        setUpConditionLabel()
        setUpChooseCityButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        cityNameWeatherInformationStack = setUpCityNameWeatherInformationStack(with: [cityNameLabel, conditionLabel])
        temperatureStackView = setUpTemperatureStackView(with: [cityNameWeatherInformationStack, temperatureLabel])
        let views: [UIView] = [temperatureStackView]
        setUpVerticalStackView(with: views)
         
    }
    
    
    private func setUpCityNameLabel() {
        cityNameLabel.text = weatherInformation.cityName
        cityNameLabel.font = UIFont.systemFont(ofSize: 40)
    }
    
    private func setUpTemperatureLabel() {
        temperatureLabel.text = weatherInformation.temperature
        temperatureLabel.font = UIFont.systemFont(ofSize: 50)
    }
    
    private func setUpConditionLabel() {
        conditionLabel.text = weatherInformation.condition
    }
    
    private func setUpChooseCityButton() {
        chooseCityButton.setTitle("Choose a City", for: .normal)
        chooseCityButton.addTarget(self, action: #selector(navigateToChooseACityViewController), for: .touchUpInside)
        view.addSubview(chooseCityButton)
        chooseCityButton.translatesAutoresizingMaskIntoConstraints = false
        chooseCityButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        chooseCityButton.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true

    }
       
    private func setUpVerticalStackView(with views: [UIView]) {
        let verticalStackView = UIStackView(arrangedSubviews: views)
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 10
        verticalStackView.distribution = .fillEqually
        view.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 3).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        verticalStackView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setUpCityNameWeatherInformationStack(with views: [UIView]) -> UIStackView {
        let verticalStackView = UIStackView(arrangedSubviews: views)
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 3
        verticalStackView.alignment = .leading
        
        return verticalStackView
    }
    
    private func setUpTemperatureStackView(with views: [UIView]) -> UIStackView {
        let horizontalStackView = UIStackView(arrangedSubviews: views)
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 1
        return horizontalStackView
        
    }
    
    @objc func navigateToChooseACityViewController() {
       
        navigationController?.pushViewController(ChooseCityViewController(), animated: true)
    }
}

