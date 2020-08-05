//
//  ChooseCityViewController.swift
//  Weather App
//
//  Created by Avelardo Valdez on 8/4/20.
//  Copyright © 2020 Avelardo Valdez. All rights reserved.
//

import UIKit

protocol ChooseCityViewControllerDelegate: class {
    func chosenCity(city: String)
}

class ChooseCityViewController: UIViewController {
    
    private let cityNameInput = UITextField()
    private let chooseCityButton = UIButton(type: .system)
    
    weak var delegate: ChooseCityViewControllerDelegate?
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        setUpTextInputField()
        setUpChooseCityButton()
    }
    
    
    private func setUpTextInputField() {
        cityNameInput.placeholder = "Enter a City Name"
        cityNameInput.textAlignment = .center
        view.addSubview(cityNameInput)
        cityNameInput.translatesAutoresizingMaskIntoConstraints = false
        cityNameInput.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        cityNameInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.70).isActive = true
        cityNameInput.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setUpChooseCityButton() {
        chooseCityButton.setTitle("Get Weather", for: .normal)
        chooseCityButton.addTarget(self, action: #selector(getWeather), for: .touchUpInside)
        view.addSubview(chooseCityButton)
        chooseCityButton.translatesAutoresizingMaskIntoConstraints = false
        chooseCityButton.topAnchor.constraint(equalTo: cityNameInput.bottomAnchor, constant: 10).isActive = true
        chooseCityButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func getWeather() {
        guard let cityName = cityNameInput.text else { return }
        let trimmedText = cityName.trimmingCharacters(in: .whitespaces)
        if trimmedText.isEmpty {
            return
        }
    
        if cityName.contains(" ") {
            let cityNameWithoutWhiteSpaces = cityName.replacingOccurrences(of: " ", with: "%20")
            delegate?.chosenCity(city: cityNameWithoutWhiteSpaces)
        } else {
            delegate?.chosenCity(city: cityName)

        }
        
        navigationController?.popViewController(animated: true)
    }
    
}
