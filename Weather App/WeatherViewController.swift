//
//  ViewController.swift
//  Weather App
//
//  Created by Avelardo Valdez on 8/4/20.
//  Copyright © 2020 Avelardo Valdez. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChooseCityViewControllerDelegate {

    private let apiURL = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey = ""
    
    private var weatherInformation = WeatherInformation()
    private let cityNameLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let conditionLabel = UILabel()
    private let chooseCityButton = UIButton(type: .system)
    
    private let locationManager = CLLocationManager()
    
    private var cityNameWeatherInformationStack: UIStackView!
    private var temperatureStackView: UIStackView!
    
    
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
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
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
        temperatureLabel.text = "\(weatherInformation.temperature)"
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
       let chooseCityViewController = ChooseCityViewController()
        chooseCityViewController.delegate = self
        navigationController?.pushViewController(chooseCityViewController, animated: true)
    }
    
    func chosenCity(city: String) {
    
        print(city)
        let urlSession = URLSession.shared
        let url = URL(string: apiURL + "?q=\(city)&appid=\(apiKey)")
        print(url)
        
        let task = urlSession.dataTask(with: url!) { (data, response, error) in
            print("the data \(data)")
            print("the response \(response)")
            print("the error \(error)")
            
            let decoder = JSONDecoder()
            do {
                let jsonData = try decoder.decode(WeatherData.self, from: data!)
            
                print(jsonData.weather[0].main)
                self.updateModel(cityName: jsonData.name, temperature: jsonData.main.temp, condition: jsonData.weather[0].main)
                DispatchQueue.main.async {
                    self.updateUI()
                }
                
            } catch(let error) {
                print(error)
        
            }
            
            
            
        }
        
        
        task.resume()
        
        
    }
    
 
    
    func updateModel(cityName: String, temperature: Double, condition: String) {
        weatherInformation.cityName = cityName
        weatherInformation.temperature = temperature
        weatherInformation.condition = condition
    }
    
    func updateUI() {
        cityNameLabel.text = weatherInformation.cityName
        conditionLabel.text = weatherInformation.condition
        temperatureLabel.text = "\(weatherInformation.temperatureInFahrenheit)˚F"
    }
    
    private func getWeatherForCurrentLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlSession = URLSession.shared
        let url = URL(string: apiURL + "?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)")
        
        let task = urlSession.dataTask(with: url!) { data, response, error in
        let decoder = JSONDecoder()
              do {
                  let jsonData = try decoder.decode(WeatherData.self, from: data!)
              
                  print(jsonData)
                  self.updateModel(cityName: jsonData.name, temperature: jsonData.main.temp, condition: jsonData.weather[0].main)
                  DispatchQueue.main.async {
                      self.updateUI()
                  }
                  
              } catch(let error) {
                  print(error)
          
              }
              
              
              
          }
          
          
          task.resume()
          
          
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinates = manager.location?.coordinate
        
        print(coordinates?.latitude)
        print(coordinates?.longitude)
        
        getWeatherForCurrentLocation(latitude: coordinates!.latitude, longitude: coordinates!.longitude)
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        cityNameLabel.text = "Location Not Found"
    }
}

