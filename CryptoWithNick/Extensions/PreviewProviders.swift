//
//  PreviewProviders.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/23.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}
class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    private init() { }
    
    let homeVM = ContentViewModel()
    
    let stat1 = StatisticModel(title: "Market Cap", value: "$12.58n", percentageChange: 27.34)
    let stat2 = StatisticModel(title: "Total Volume", value: "$1.25Tr")
    let stat3 = StatisticModel(title: "Portfolio Value", value: "$50.4k", percentageChange: -12.34)

    
    let coin = CoinModel(id: "bitcoin",
                         symbol: "btc",
                         name: "Bitcoin",
                         image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
                         currentPrice: 30097,
                         marketCap: 573414820407,
                         marketCapRank: 1,
                         fullyDilutedValuation: 632191301441,
                         totalVolume: 22343859530,
                         high24H: 30625,
                         low24H: 29930,
                         priceChange24H: 127.47,
                         priceChangePercentage24H: 0.42533,
                         marketCapChange24H: 2473234071,
                         marketCapChangePercentage24H: 0.43319,
                         circulatingSupply: 19047575.0,
                         totalSupply: 21000000.0,
                         maxSupply: 21000000.0,
                         ath: 69045,
                         athChangePercentage: -56.36609,
                         athDate: "2021-11-10T14:24:11.849Z",
                         atl: 67.81,
                         atlChangePercentage: 44329.11073,
                         atlDate: "2013-07-06T00:00:00.000Z",
                         lastUpdated: "2022-05-23T18:07:51.927Z",
                         sparklineIn7D: SparklineIn7D(price:
                                                        [29749.142413381916,
                                                         29905.188846986126,
                                                         29709.378779871986,
                                                         29886.47606399331,
                                                         30140.03797986179,
                                                         30048.5631998,
                                                         29923.606993639707,
                                                         30208.878000777062,
                                                         30014.09358296287,
                                                         30064.841721262856,
                                                         30415.908178918882,
                                                         30397.64899397003,
                                                         30473.91779446803,
                                                         30524.318345463787,
                                                         30487.056295837763,
                                                         30672.568541478813,
                                                         30684.401316348394,
                                                         30534.81470763958,
                                                         30420.20048347511,
                                                         30555.493228652784,
                                                         30651.913297166047,
                                                         30117.675833631245,
                                                         30159.756842891627,
                                                         30179.52933749825,
                                                         30203.907490377118,
                                                         29835.267384143248,
                                                         30156.522808580165,
                                                         30210.137401842963,
                                                         30535.565254403686,
                                                         30370.987063478926,
                                                         30502.19328027689,
                                                         30534.701651143925,
                                                         30262.29005749098,
                                                         30229.94488609894,
                                                         29869.603468784113,
                                                         29860.595314682556,
                                                         30027.881391536717,
                                                         29850.866134310378,
                                                         29881.144768342547,
                                                         29907.88149438243,
                                                         29946.89188314115,
                                                         29976.28891176134,
                                                         29851.722908349042,
                                                         29583.133426780576,
                                                         29402.681241556325,
                                                         29204.99698805408,
                                                         29014.26599807768,
                                                         29128.983080913495,
                                                         28963.28695458867,
                                                         29197.82080184199,
                                                         29344.38809720751,
                                                         29241.649429828303,
                                                         29157.041891112087,
                                                         28975.01878983267,
                                                         28772.200501112577,
                                                         28933.53974183301,
                                                         28853.477590685474,
                                                         29100.110152170204,
                                                         29222.77355574537,
                                                         29148.070503245166,
                                                         29078.472251350275,
                                                         29286.656996261212,
                                                         29185.483322189215,
                                                         29056.226100091822,
                                                         29086.762422998854,
                                                         29224.199174464593,
                                                         29462.75248548161,
                                                         29530.45376871893,
                                                         29627.800179670576,
                                                         29840.233937359586,
                                                         30401.478706403686,
                                                         30186.035736931997,
                                                         30189.79125483797,
                                                         30219.79652704418,
                                                         30028.522614298352,
                                                         30472.01255538265,
                                                         30226.486301814184,
                                                         30232.007727975822,
                                                         30289.310877173142,
                                                         30222.997986532428,
                                                         30448.564764580642,
                                                         30204.782777609496,
                                                         30239.692311994073,
                                                         30355.59330787842,
                                                         30335.778359754542,
                                                         30498.4928562101,
                                                         30247.253836113927,
                                                         30353.09022539717,
                                                         29610.749273550864,
                                                         29233.558880619712,
                                                         28883.583563813074,
                                                         28941.11591341604,
                                                         29078.642709409283,
                                                         29361.983436757986,
                                                         29209.395363568612,
                                                         29218.857806706103,
                                                         29194.913885389316,
                                                         29256.813374416255,
                                                         29313.84120108591,
                                                         29158.69802123103,
                                                         29227.28615150176,
                                                         29281.41029204116,
                                                         29255.988512722528,
                                                         29290.06697649485,
                                                         29377.041270304915,
                                                         29482.022669025562,
                                                         29403.868537604212,
                                                         29332.91144408883,
                                                         29310.33773441654,
                                                         29310.68064074855,
                                                         29315.265376915155,
                                                         29355.49900328947,
                                                         29408.829445605934,
                                                         29497.347529518447,
                                                         29586.643167160633,
                                                         29456.156222490306,
                                                         29488.44296610853,
                                                         29506.42157055718,
                                                         29435.79656041014,
                                                         29400.69738961443,
                                                         29438.097435799475,
                                                         29491.507947760598,
                                                         29512.56199034459,
                                                         29536.76112195805,
                                                         29437.63395643593,
                                                         29412.806868676085,
                                                         29348.146110206842,
                                                         29421.371906529017,
                                                         29440.270841599387,
                                                         29465.85503423404,
                                                         29577.488869025095,
                                                         30025.810045074377,
                                                         30236.777415095316,
                                                         29919.258535544526,
                                                         30195.853504758594,
                                                         30059.79716769435,
                                                         30009.759324959436,
                                                         29888.987158689626,
                                                         29958.666956261368,
                                                         29978.384670416777,
                                                         30049.27974428577,
                                                         29976.10252024696,
                                                         29974.13309415041,
                                                         30069.910565295708,
                                                         30341.531208439646,
                                                         30351.050417138096,
                                                         30300.123520864105,
                                                         30233.304059660284,
                                                         30162.200777993916,
                                                         30169.673747371988,
                                                         30172.13926006517,
                                                         30276.76118473994,
                                                         30528.731586363934,
                                                         30546.4547069185,
                                                         30381.50734327177,
                                                         30495.217363563523,
                                                         30483.75338516015,
                                                         30440.18813153408,
                                                         30433.124856438022,
                                                         30435.747186647808,
                                                         30278.200334421705,
                                                         30415.521868185282,
                                                         30292.474385454425]),
                         priceChangePercentage24HInCurrency: 0.42532664875584564, currentHoldings: 1.5)
    
    let krwCoin = CoinModel(id: "bitcoin",
                            symbol: "btc",
                            name: "Bitcoin",
                            image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
                            currentPrice: 30097 * 1250,
                            marketCap: 573414820407 * 1250,
                            marketCapRank: 1,
                            fullyDilutedValuation: 632191301441,
                            totalVolume: 22343859530 * 1250,
                            high24H: 30625 * 1250,
                            low24H: 29930 * 1250,
                            priceChange24H: 127.47 * 1250,
                            priceChangePercentage24H: 0.42533,
                            marketCapChange24H: 2473234071 * 1250,
                            marketCapChangePercentage24H: 0.43319,
                            circulatingSupply: 19047575.0,
                            totalSupply: 21000000.0,
                            maxSupply: 21000000.0,
                            ath: 69045,
                            athChangePercentage: -56.36609,
                            athDate: "2021-11-10T14:24:11.849Z",
                            atl: 67.81,
                            atlChangePercentage: 44329.11073,
                            atlDate: "2013-07-06T00:00:00.000Z",
                            lastUpdated: "2022-05-23T18:07:51.927Z",
                            sparklineIn7D: SparklineIn7D(price:
                                                           [29749.142413381916,
                                                            29905.188846986126,
                                                            29709.378779871986,
                                                            29886.47606399331,
                                                            30140.03797986179,
                                                            30048.5631998,
                                                            29923.606993639707,
                                                            30208.878000777062,
                                                            30014.09358296287,
                                                            30064.841721262856,
                                                            30415.908178918882,
                                                            30397.64899397003,
                                                            30473.91779446803,
                                                            30524.318345463787,
                                                            30487.056295837763,
                                                            30672.568541478813,
                                                            30684.401316348394,
                                                            30534.81470763958,
                                                            30420.20048347511,
                                                            30555.493228652784,
                                                            30651.913297166047,
                                                            30117.675833631245,
                                                            30159.756842891627,
                                                            30179.52933749825,
                                                            30203.907490377118,
                                                            29835.267384143248,
                                                            30156.522808580165,
                                                            30210.137401842963,
                                                            30535.565254403686,
                                                            30370.987063478926,
                                                            30502.19328027689,
                                                            30534.701651143925,
                                                            30262.29005749098,
                                                            30229.94488609894,
                                                            29869.603468784113,
                                                            29860.595314682556,
                                                            30027.881391536717,
                                                            29850.866134310378,
                                                            29881.144768342547,
                                                            29907.88149438243,
                                                            29946.89188314115,
                                                            29976.28891176134,
                                                            29851.722908349042,
                                                            29583.133426780576,
                                                            29402.681241556325,
                                                            29204.99698805408,
                                                            29014.26599807768,
                                                            29128.983080913495,
                                                            28963.28695458867,
                                                            29197.82080184199,
                                                            29344.38809720751,
                                                            29241.649429828303,
                                                            29157.041891112087,
                                                            28975.01878983267,
                                                            28772.200501112577,
                                                            28933.53974183301,
                                                            28853.477590685474,
                                                            29100.110152170204,
                                                            29222.77355574537,
                                                            29148.070503245166,
                                                            29078.472251350275,
                                                            29286.656996261212,
                                                            29185.483322189215,
                                                            29056.226100091822,
                                                            29086.762422998854,
                                                            29224.199174464593,
                                                            29462.75248548161,
                                                            29530.45376871893,
                                                            29627.800179670576,
                                                            29840.233937359586,
                                                            30401.478706403686,
                                                            30186.035736931997,
                                                            30189.79125483797,
                                                            30219.79652704418,
                                                            30028.522614298352,
                                                            30472.01255538265,
                                                            30226.486301814184,
                                                            30232.007727975822,
                                                            30289.310877173142,
                                                            30222.997986532428,
                                                            30448.564764580642,
                                                            30204.782777609496,
                                                            30239.692311994073,
                                                            30355.59330787842,
                                                            30335.778359754542,
                                                            30498.4928562101,
                                                            30247.253836113927,
                                                            30353.09022539717,
                                                            29610.749273550864,
                                                            29233.558880619712,
                                                            28883.583563813074,
                                                            28941.11591341604,
                                                            29078.642709409283,
                                                            29361.983436757986,
                                                            29209.395363568612,
                                                            29218.857806706103,
                                                            29194.913885389316,
                                                            29256.813374416255,
                                                            29313.84120108591,
                                                            29158.69802123103,
                                                            29227.28615150176,
                                                            29281.41029204116,
                                                            29255.988512722528,
                                                            29290.06697649485,
                                                            29377.041270304915,
                                                            29482.022669025562,
                                                            29403.868537604212,
                                                            29332.91144408883,
                                                            29310.33773441654,
                                                            29310.68064074855,
                                                            29315.265376915155,
                                                            29355.49900328947,
                                                            29408.829445605934,
                                                            29497.347529518447,
                                                            29586.643167160633,
                                                            29456.156222490306,
                                                            29488.44296610853,
                                                            29506.42157055718,
                                                            29435.79656041014,
                                                            29400.69738961443,
                                                            29438.097435799475,
                                                            29491.507947760598,
                                                            29512.56199034459,
                                                            29536.76112195805,
                                                            29437.63395643593,
                                                            29412.806868676085,
                                                            29348.146110206842,
                                                            29421.371906529017,
                                                            29440.270841599387,
                                                            29465.85503423404,
                                                            29577.488869025095,
                                                            30025.810045074377,
                                                            30236.777415095316,
                                                            29919.258535544526,
                                                            30195.853504758594,
                                                            30059.79716769435,
                                                            30009.759324959436,
                                                            29888.987158689626,
                                                            29958.666956261368,
                                                            29978.384670416777,
                                                            30049.27974428577,
                                                            29976.10252024696,
                                                            29974.13309415041,
                                                            30069.910565295708,
                                                            30341.531208439646,
                                                            30351.050417138096,
                                                            30300.123520864105,
                                                            30233.304059660284,
                                                            30162.200777993916,
                                                            30169.673747371988,
                                                            30172.13926006517,
                                                            30276.76118473994,
                                                            30528.731586363934,
                                                            30546.4547069185,
                                                            30381.50734327177,
                                                            30495.217363563523,
                                                            30483.75338516015,
                                                            30440.18813153408,
                                                            30433.124856438022,
                                                            30435.747186647808,
                                                            30278.200334421705,
                                                            30415.521868185282,
                                                            30292.474385454425]
                                .map({ price -> Double in
        return price * 1250
    })),
                            priceChangePercentage24HInCurrency: 0.42532664875584564, currentHoldings: 1.5)
}
/* {
 "id": "bitcoin",
 "symbol": "btc",
 "name": "Bitcoin",
 "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
 "current_price": 30338,
 "market_cap": 577747398069,
 "market_cap_rank": 1,
 "fully_diluted_valuation": 636984298935,
 "total_volume": 18485522731,
 "high_24h": 30452,
 "low_24h": 29411,
 "price_change_24h": 906.44,
 "price_change_percentage_24h": 3.07979,
 "market_cap_change_24h": 17379504803,
 "market_cap_change_percentage_24h": 3.10145,
 "circulating_supply": 19047087.0,
 "total_supply": 21000000.0,
 "max_supply": 21000000.0,
 "ath": 69045,
 "ath_change_percentage": -56.14909,
 "ath_date": "2021-11-10T14:24:11.849Z",
 "atl": 67.81,
 "atl_change_percentage": 44550.06295,
 "atl_date": "2013-07-06T00:00:00.000Z",
 "roi": null,
 "last_updated": "2022-05-23T06:03:17.736Z",
 "sparkline_in_7d": {
     "price": [
         30385.718264259143,
         29608.509262272964,
         29624.211060059864,
         29880.59110547924,
         29715.831005344637,
         30158.57266755717,
         30046.528305883057,
         29903.486114746098,
         29666.206382563938,
         29600.889917121327,
         29648.025003886807,
         29293.297853939406,
         29749.142413381916,
         29905.188846986126,
         29709.378779871986,
         29886.47606399331,
         30140.03797986179,
         30048.5631998,
         29923.606993639707,
         30208.878000777062,
         30014.09358296287,
         30064.841721262856,
         30415.908178918882,
         30397.64899397003,
         30473.91779446803,
         30524.318345463787,
         30487.056295837763,
         30672.568541478813,
         30684.401316348394,
         30534.81470763958,
         30420.20048347511,
         30555.493228652784,
         30651.913297166047,
         30117.675833631245,
         30159.756842891627,
         30179.52933749825,
         30203.907490377118,
         29835.267384143248,
         30156.522808580165,
         30210.137401842963,
         30535.565254403686,
         30370.987063478926,
         30502.19328027689,
         30534.701651143925,
         30262.29005749098,
         30229.94488609894,
         29869.603468784113,
         29860.595314682556,
         30027.881391536717,
         29850.866134310378,
         29881.144768342547,
         29907.88149438243,
         29946.89188314115,
         29976.28891176134,
         29851.722908349042,
         29583.133426780576,
         29402.681241556325,
         29204.99698805408,
         29014.26599807768,
         29128.983080913495,
         28963.28695458867,
         29197.82080184199,
         29344.38809720751,
         29241.649429828303,
         29157.041891112087,
         28975.01878983267,
         28772.200501112577,
         28933.53974183301,
         28853.477590685474,
         29100.110152170204,
         29222.77355574537,
         29148.070503245166,
         29078.472251350275,
         29286.656996261212,
         29185.483322189215,
         29056.226100091822,
         29086.762422998854,
         29224.199174464593,
         29462.75248548161,
         29530.45376871893,
         29627.800179670576,
         29840.233937359586,
         30401.478706403686,
         30186.035736931997,
         30189.79125483797,
         30219.79652704418,
         30028.522614298352,
         30472.01255538265,
         30226.486301814184,
         30232.007727975822,
         30289.310877173142,
         30222.997986532428,
         30448.564764580642,
         30204.782777609496,
         30239.692311994073,
         30355.59330787842,
         30335.778359754542,
         30498.4928562101,
         30247.253836113927,
         30353.09022539717,
         29610.749273550864,
         29233.558880619712,
         28883.583563813074,
         28941.11591341604,
         29078.642709409283,
         29361.983436757986,
         29209.395363568612,
         29218.857806706103,
         29194.913885389316,
         29256.813374416255,
         29313.84120108591,
         29158.69802123103,
         29227.28615150176,
         29281.41029204116,
         29255.988512722528,
         29290.06697649485,
         29377.041270304915,
         29482.022669025562,
         29403.868537604212,
         29332.91144408883,
         29310.33773441654,
         29310.68064074855,
         29315.265376915155,
         29355.49900328947,
         29408.829445605934,
         29497.347529518447,
         29586.643167160633,
         29456.156222490306,
         29488.44296610853,
         29506.42157055718,
         29435.79656041014,
         29400.69738961443,
         29438.097435799475,
         29491.507947760598,
         29512.56199034459,
         29536.76112195805,
         29437.63395643593,
         29412.806868676085,
         29348.146110206842,
         29421.371906529017,
         29440.270841599387,
         29465.85503423404,
         29577.488869025095,
         30025.810045074377,
         30236.777415095316,
         29919.258535544526,
         30195.853504758594,
         30059.79716769435,
         30009.759324959436,
         29888.987158689626,
         29958.666956261368,
         29978.384670416777,
         30049.27974428577,
         29976.10252024696,
         29974.13309415041,
         30069.910565295708,
         30341.531208439646,
         30351.050417138096,
         30300.123520864105,
         30233.304059660284,
         30162.200777993916,
         30169.673747371988,
         30172.13926006517
     ]
 },
 "price_change_percentage_24h_in_currency": 3.0797862740647126
}*/
