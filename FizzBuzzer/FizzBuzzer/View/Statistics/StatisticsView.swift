//
//  StatisticsView.swift
//  FizzBuzzer
//
//  Created by Julien Lebeau on 23/02/2021.
//

import SwiftUI

struct StatisticsView: View {
    
    @ObservedObject var viewModel : StatisticsViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if self.viewModel.formHitStatistics.isEmpty {
                    Text(self.emptyHistoryText)
                        .foregroundColor(self.emptyHistoryTextColor)
                } else {
                    ScrollView {
                        VStack {
                            self.histogramView
                            
                            Text(self.viewModel.totalNumberOfHitTitle)
                                .font(self.histogramTotalHitTitleFont)
                                .bold()
                        }
                        .padding(.vertical, self.histogramAndTitleVerticalPadding)
                        
                        self.legendListView
                    }
                }
            }
            .navigationTitle(self.navigationtitle)
        }
        .onAppear {
            self.viewModel.load()
        }
    }
    
    @ViewBuilder
    var histogramView: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(self.viewModel.formHitStatistics) { formHit in
                    Rectangle()
                        .fill(formHit.color)
                        .frame(width: geometry.size.width * CGFloat(formHit.percentage))
                }
            }
        }
        .frame(height: self.histogramHeight)
        .padding(self.histogramPadding)
    }
    
    @ViewBuilder
    var legendListView: some View {
        LazyVStack {
            ForEach(self.viewModel.formHitStatistics) { formHit in
                ZStack {
                    
                    RoundedRectangle(cornerRadius: self.legendTileCornerRadius)
                        .fill(self.legendTileBackgroundColor)
                    
                    HStack(spacing: self.legendTileMiddleSpacing) {
                        VStack {
                            Rectangle()
                                .fill(formHit.color)
                                .frame(width: self.legendTileColorRectangleSize.width,
                                       height: self.legendTileColorRectangleSize.height)
                            
                            Text(self.viewModel.hitDescription(for: formHit))
                                .bold()
                                .multilineTextAlignment(.center)
                            
                            Text(NSNumber(value: formHit.percentage),
                                 formatter: Self.percentageFormatter)
                                .font(self.legendTilePercentageTextFont)
                        }
                        .frame(width: self.legendTileLeftPartWidth)
                        
                        VStack(alignment: .leading) {
                            Text(self.viewModel.limitDescription(for: formHit))
                            ForEach(formHit.mappings, id: \.self) { mapping in
                                Text(self.viewModel.mappingDescription(for: mapping))
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(self.legendContentPadding)
                }
            }
        }
        .padding(self.legendListPadding)
    }
    
    static let percentageFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    
    //MARK: - UIConstants
    let navigationtitle: String = "History"
    let emptyHistoryText: String = "No History"
    let emptyHistoryTextColor: Color = Color.secondary
    
    let histogramHeight: CGFloat = 40
    let histogramPadding: EdgeInsets = EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10)
    let histogramAndTitleVerticalPadding: CGFloat = 40
    let histogramTotalHitTitleFont: Font = Font.title3
    
    let legendTileBackgroundColor: Color = Color.gray.opacity(0.2)
    let legendTileCornerRadius: CGFloat = 10
    let legendTileColorRectangleSize: CGSize = CGSize(width: 40, height: 30)
    let legendTileLeftPartWidth: CGFloat = 80
    let legendTileMiddleSpacing: CGFloat = 20
    let legendContentPadding: CGFloat = 10
    let legendTilePercentageTextFont : Font = Font.caption
    
    let legendListPadding: CGFloat = 10
    
}

#if DEBUG

class FakeRepo: Repository {
    var fizzBuzzParametersHits: [FizzBuzzerParameter : Int]
    
    init() {
        let fakeMapping1 = [
            ReplacementMapping(toReplace: 3, replacement: "Fizz"),
            ReplacementMapping(toReplace: 5, replacement: "Buzz")
        ]
        
        let fakeMapping2 = [
            ReplacementMapping(toReplace: 5, replacement: "Fizz"),
            ReplacementMapping(toReplace: 7, replacement: "Buzz")
        ]
        
        let fakeMapping3 = [
            ReplacementMapping(toReplace: 3, replacement: "Fizz"),
            ReplacementMapping(toReplace: 5, replacement: "Buzz"),
            ReplacementMapping(toReplace: 7, replacement: "Boum")
        ]
        
        self.fizzBuzzParametersHits = [
            FizzBuzzerParameter(mappings: fakeMapping1, limit: 100) : 200,
            FizzBuzzerParameter(mappings: fakeMapping2, limit: 200) : 30,
            FizzBuzzerParameter(mappings: fakeMapping3, limit: 201) : 1,
            FizzBuzzerParameter(mappings: fakeMapping2, limit: 202) : 31,
            FizzBuzzerParameter(mappings: fakeMapping2, limit: 203) : 32,
            FizzBuzzerParameter(mappings: fakeMapping2, limit: 204) : 33,
            FizzBuzzerParameter(mappings: fakeMapping2, limit: 205) : 34,
            FizzBuzzerParameter(mappings: fakeMapping2, limit: 206) : 35,
            FizzBuzzerParameter(mappings: fakeMapping2, limit: 207) : 36
        ]
    }
    
    func addHit(to fizzbuzzParameter: FizzBuzzerParameter) {
        
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        let view = TabView {
            StatisticsView(viewModel: StatisticsViewModel(repository: FakeRepo()))
        }
        
        view.colorScheme(.light)
        view.colorScheme(.dark)
    }
}
#endif
