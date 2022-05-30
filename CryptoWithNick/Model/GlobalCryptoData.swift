//
//  GlobalCryptoData.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/29.
//
// JSON data:
/*
URL: https://api.coingecko.com/api/v3/global
{
    "data": {
        "active_cryptocurrencies": 13442,
        "upcoming_icos": 0,
        "ongoing_icos": 49,
        "ended_icos": 3376,
        "markets": 623,
        "total_market_cap": {
            "btc": 43421540.36754324,
            "eth": 705765139.3296642,
            "ltc": 20030982384.646572,
            "bch": 7036609495.134141,
            "bnb": 4186489511.270662,
            "eos": 1007493728604.3469,
            "xrp": 3283312036209.8384,
            "xlm": 10151877844388.82,
            "link": 193129354916.3174,
            "dot": 133138024224.25293,
            "yfi": 169174095.41498765,
            "usd": 1266435815743.7551,
            "aed": 4651745394808.4,
            "ars": 151317117451462.22,
            "aud": 1767551803675.4028,
            "bdt": 111212707041804.12,
            "bhd": 477176551706.6428,
            "bmd": 1266435815743.7551,
            "brl": 5991507844283.727,
            "cad": 1611602897324.7197,
            "chf": 1212375470077.1023,
            "clp": 1046709201712215.1,
            "cny": 8483346955341.12,
            "czk": 29134482584766.676,
            "dkk": 8775007123706.921,
            "eur": 1180039564393.7158,
            "gbp": 1002791740493.8516,
            "hkd": 9940614385544.418,
            "huf": 465047262681357.8,
            "idr": 1.8413216899424772e+16,
            "ils": 4235809879843.67,
            "inr": 98392184683926.98,
            "jpy": 161008311862265.0,
            "krw": 1593644839990344.8,
            "kwd": 387035449649.4494,
            "lkr": 449269407531117.06,
            "mmk": 2.343240317032554e+15,
            "mxn": 24798295002167.19,
            "myr": 5545722437141.922,
            "ngn": 525849479413123.8,
            "nok": 11969268527787.506,
            "nzd": 1939472998534.2517,
            "php": 66266262923842.66,
            "pkr": 253413806730325.66,
            "pln": 5393686817461.885,
            "rub": 83268286594476.81,
            "sar": 4750389346932.489,
            "sek": 12406880358174.512,
            "sgd": 1740716028739.794,
            "thb": 43133490590291.43,
            "try": 20539056059732.246,
            "twd": 37124679433457.19,
            "uah": 37391121065424.08,
            "vef": 126808218230.42235,
            "vnd": 2.9387643104333864e+16,
            "zar": 19728872743147.406,
            "xdr": 919393142719.681,
            "xag": 57244456587.67107,
            "xau": 683280115.6682302,
            "bits": 43421540367543.24,
            "sats": 4342154036754324.5
        },
        "total_volume": {
            "btc": 1885879.563546441,
            "eth": 30652713.875627685,
            "ltc": 869983422.909625,
            "bch": 305613249.35053504,
            "bnb": 181827151.81169364,
            "eos": 43757356765.638016,
            "xrp": 142600447091.98145,
            "xlm": 440915241520.6222,
            "link": 8387972892.593114,
            "dot": 5782436018.855488,
            "yfi": 7347550.697742141,
            "usd": 55003701002.73218,
            "aed": 202034094153.13614,
            "ars": 6571988395643.71,
            "aud": 76768115452.50333,
            "bdt": 4830178055442.448,
            "bhd": 20724679489.716473,
            "bmd": 55003701002.73218,
            "brl": 260222509443.92685,
            "cad": 69994959711.02701,
            "chf": 52655758018.02858,
            "clp": 45460558878758.21,
            "cny": 368447791536.90186,
            "czk": 1265365641937.9546,
            "dkk": 381115143877.83167,
            "eur": 51251348520.325775,
            "gbp": 43553140535.38539,
            "hkd": 431739670221.53015,
            "huf": 20197881543362.84,
            "idr": 799720810359125.0,
            "ils": 183969228632.8084,
            "inr": 4273358539044.469,
            "jpy": 6992895284966.083,
            "krw": 69215007340815.664,
            "kwd": 16809681063.444998,
            "lkr": 19512619474523.93,
            "mmk": 101771355621297.7,
            "mxn": 1077036819963.6713,
            "myr": 240861206690.965,
            "ngn": 22838636730354.53,
            "nok": 519847953713.4669,
            "nzd": 84234977871.02634,
            "php": 2878069039993.866,
            "pkr": 11006240570646.719,
            "pln": 234258012385.587,
            "rub": 3616499061314.5483,
            "sar": 206318387427.9396,
            "sek": 538854262580.15765,
            "sgd": 75602587028.2555,
            "thb": 1873369017315.1206,
            "try": 892050022862.3114,
            "twd": 1612394992304.393,
            "uah": 1623967055947.2554,
            "vef": 5507520581.403579,
            "vnd": 1276360881768401.2,
            "zar": 856862230201.3282,
            "xdr": 39930981813.2526,
            "xag": 2486234939.8757267,
            "xau": 29676146.802004173,
            "bits": 1885879563546.441,
            "sats": 188587956354644.1
        },
        "market_cap_percentage": {
            "btc": 43.87820615926708,
            "eth": 17.14838311808191,
            "usdt": 5.7344559227118115,
            "usdc": 4.252219605287863,
            "bnb": 4.016185364812373,
            "xrp": 1.4712451932737558,
            "busd": 1.4217196659871079,
            "ada": 1.2495072627889974,
            "sol": 1.1568172141554378,
            "doge": 0.8571340633602956
        },
        "market_cap_change_percentage_24h_usd": 1.2071904702747671,
        "updated_at": 1653821192
    }
}
*/


import Foundation

struct GlobalCryptoData: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { (key, value) in
           return key == "usd" })
        {
            return item.value.formattedWithAbbreviations()
        }
        return ""
    }
    var volume: String {
        if let item = totalVolume.first(where: { (key, value) in
            return key == "usd"
        }) {
            return item.value.formattedWithAbbreviations()
        }
        return ""
    }
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" })
        {
            return item.value.asPercentString()
        }
        return ""
    }
}
