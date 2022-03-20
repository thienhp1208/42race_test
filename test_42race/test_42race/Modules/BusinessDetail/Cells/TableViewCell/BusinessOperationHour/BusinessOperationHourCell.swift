//
//  BusinessOperationHourCell.swift
//  test_42race
//
//  Created by For Test Only on 20/03/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable

class BusinessOperationHourCell: UITableViewCell, NibReusable {
    
    // MARK: - Outlets
    @IBOutlet weak var stackViewModayHour: UIStackView!
    @IBOutlet weak var stackViewTuesdayHour: UIStackView!
    @IBOutlet weak var stackViewWednesdayHour: UIStackView!
    @IBOutlet weak var stackViewThursdayHour: UIStackView!
    @IBOutlet weak var StackViewFridayHour: UIStackView!
    @IBOutlet weak var stackViewSaturdayHour: UIStackView!
    @IBOutlet weak var stackViewSundayHour: UIStackView!
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    var businessDetail: PublishSubject<BusinessDetail> = PublishSubject()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        binding()
    }
    
}

// MARK: - Helper Methods
extension BusinessOperationHourCell {
    private func configUI() {
        
    }
    
    private func binding() {
        businessDetail
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] detail in
                guard let hours = detail.hours,
                      let openHours = hours.first?.hourOpen
                else { return }
                var openDays: [Int] = []
                
                openHours.forEach { open in
                    if let openDay = open.day {
                        addOpeningHour(to: openDay, with: open, isDuplicate: openDays.contains(openDay))
                        openDays.append(openDay)
                    }
                }
                
            })
            .disposed(by: disposeBag)
    }
    
    func updateData(detail: BusinessDetail?) {
        if let detail = detail {
            businessDetail.onNext(detail)
        } else {
            
        }
    }
    
    private func addOpeningHour(to day: Int, with open: Open, isDuplicate: Bool) {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        if let startHour = open.start,
           let endHour = open.end,
           let isOvernight = open.isOvernight {
            
            let startTime = self.convertTime(with: startHour, fromFormat: "HHmm", toFormat: "HH:mm")
            let endTime = self.convertTime(with: endHour, fromFormat: "HHmm", toFormat: "HH:mm")
            let isNextDay = isOvernight ? "(Next day)" : ""
            label.text = "\(startTime) - \(endTime)\(isNextDay)"
            if day == 0 {
                if !isDuplicate {
                    removeStackViewSubView(stackView: stackViewModayHour)
                }
                stackViewModayHour.addArrangedSubview(label)
            } else if day == 1 {
                if !isDuplicate {
                    removeStackViewSubView(stackView: stackViewTuesdayHour)
                }
                stackViewTuesdayHour.addArrangedSubview(label)
            } else if day == 2 {
                if !isDuplicate {
                    removeStackViewSubView(stackView: stackViewWednesdayHour)
                }
                stackViewWednesdayHour.addArrangedSubview(label)
            } else if day == 3 {
                if !isDuplicate {
                    removeStackViewSubView(stackView: stackViewThursdayHour)
                }
                stackViewThursdayHour.addArrangedSubview(label)
            } else if day == 4 {
                if !isDuplicate {
                    removeStackViewSubView(stackView: StackViewFridayHour)
                }
                StackViewFridayHour.addArrangedSubview(label)
            } else if day == 5 {
                if !isDuplicate {
                    removeStackViewSubView(stackView: stackViewSaturdayHour)
                }
                stackViewSaturdayHour.addArrangedSubview(label)
            } else {
                if !isDuplicate {
                    removeStackViewSubView(stackView: stackViewSundayHour)
                }
                stackViewSundayHour.addArrangedSubview(label)
            }
        }
        
    }
    
    private func removeStackViewSubView(stackView: UIStackView) {
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    private func convertTime(with text: String, fromFormat: String, toFormat: String) -> String {
        let fromFormatter = DateFormatter()
        fromFormatter.dateFormat = fromFormat
        
        let toFormmatter = DateFormatter()
        toFormmatter.dateFormat = toFormat
        
        if let fromTime = fromFormatter.date(from: text) {
            return toFormmatter.string(from: fromTime)
        }
        return ""
    }
}
