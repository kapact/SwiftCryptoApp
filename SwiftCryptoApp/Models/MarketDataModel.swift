//
//  MarketDataModel.swift
//  SwiftCryptoApp
//
//  Created by Akshay kumar shaw on 08/12/24.
//

import Foundation

// Json Data
/*
 URL: https://api.coingecko.com/api/v3/global
 JSON Response:
 {
     "data": {
         "active_cryptocurrencies": 15978,
         "upcoming_icos": 0,
         "ongoing_icos": 49,
         "ended_icos": 3376,
         "markets": 1183,
         "total_market_cap": {
             "btc": 38538168.80334752,
             "eth": 965736281.7550626,
             "ltc": 29149909185.779583,
             "bch": 6277641788.689403,
             "bnb": 5147467650.021562,
             "eos": 2924666718537.9644,
             "xrp": 1509010600908.7026,
             "xlm": 7919063826888.747,
             "link": 153110962623.52307,
             "dot": 368998169775.902,
             "yfi": 284162244.0340964,
             "usd": 3835962571360.5474,
             "aed": 14089490524607.29,
             "ars": 3887254922397665.5,
             "aud": 6001194660540.437,
             "bdt": 458915393732606.56,
             "bhd": 1445083819882.9453,
             "bmd": 3835962571360.5474,
             "brl": 23360244867071.465,
             "cad": 5432298395432.239,
             "chf": 3375025636860.7217,
             "clp": 3.740792339965093e+15,
             "cny": 27888598682562.59,
             "czk": 91091068797070.38,
             "dkk": 27076525406205.562,
             "eur": 3628931835421.6475,
             "gbp": 3010605356618.898,
             "gel": 10894133702663.951,
             "hkd": 29842829814542.22,
             "huf": 1502143763131933.5,
             "idr": 6.08585051852779e+16,
             "ils": 13742623609092.01,
             "inr": 324796321264697.5,
             "jpy": 575336846265511.6,
             "krw": 5.467205654831619e+15,
             "kwd": 1177866831199.3982,
             "lkr": 1114897909830085.2,
             "mmk": 8.047849474714425e+15,
             "mxn": 77458825010969.25,
             "myr": 16953036584127.938,
             "ngn": 6.164827122685331e+15,
             "nok": 42794765638612.53,
             "nzd": 6578568402931.341,
             "php": 222109920150768.72,
             "pkr": 1067774479079558.9,
             "pln": 15483137922370.865,
             "rub": 385420794373496.4,
             "sar": 14411895506805.002,
             "sek": 41950086680398.945,
             "sgd": 5147478174508.719,
             "thb": 130645078996707.5,
             "try": 133261347400990.55,
             "twd": 124321628956509.67,
             "uah": 159028029683729.06,
             "vef": 384094932270.3316,
             "vnd": 9.73841980273375e+16,
             "zar": 69158185602802.17,
             "xdr": 2920997270951.9155,
             "xag": 123870596477.36908,
             "xau": 1456860224.9770222,
             "bits": 38538168803347.52,
             "sats": 3.853816880334752e+15
         },
         "total_volume": {
             "btc": 2077643.7018517463,
             "eth": 52064121.51227703,
             "ltc": 1571510196.5126235,
             "bch": 338435979.95810705,
             "bnb": 277506795.876195,
             "eos": 157672654837.1443,
             "xrp": 81352759312.5586,
             "xlm": 426927215157.8786,
             "link": 8254414702.537424,
             "dot": 19893179858.694565,
             "yfi": 15319562.78551089,
             "usd": 206801820750.60086,
             "aed": 759583087616.9568,
             "ars": 209567059302261.88,
             "aud": 323532349284.20197,
             "bdt": 24740736445903.582,
             "bhd": 77906381913.16635,
             "bmd": 206801820750.60086,
             "brl": 1259381728007.009,
             "cad": 292862398455.9634,
             "chf": 181952100365.56714,
             "clp": 201671067577778.47,
             "cny": 1503511277403.0935,
             "czk": 4910840116636.218,
             "dkk": 1459731331950.1912,
             "eur": 195640519682.87018,
             "gbp": 162305720592.4393,
             "gel": 587317170931.7062,
             "hkd": 1608866464984.4868,
             "huf": 80982558996831.53,
             "idr": 3.280962586663469e+15,
             "ils": 740883032975.5836,
             "inr": 17510199685502.426,
             "jpy": 31017171085278.863,
             "krw": 294744295024793.75,
             "kwd": 63500360277.85874,
             "lkr": 60105622360680.195,
             "mmk": 433870219934760.4,
             "mxn": 4175907806052.7324,
             "myr": 913960646807.2804,
             "ngn": 332353991955617.75,
             "nok": 2307122472657.8525,
             "nzd": 354659332136.29944,
             "php": 11974239852308.574,
             "pkr": 57565135821009.08,
             "pln": 834716463915.6786,
             "rub": 20778545293081.883,
             "sar": 776964367047.4033,
             "sek": 2261584711728.571,
             "sgd": 277507363265.2313,
             "thb": 7043249173060.236,
             "try": 7184295666479.514,
             "twd": 6702343609616.599,
             "uah": 8573411621508.923,
             "vef": 20707066311.75766,
             "vnd": 5.250111045073998e+15,
             "zar": 3728409346130.5073,
             "xdr": 157474830059.70526,
             "xag": 6678027851.532742,
             "xau": 78541263.5028707,
             "bits": 2077643701851.7463,
             "sats": 207764370185174.62
         },
         "market_cap_percentage": {
             "btc": 51.35316133204788,
             "eth": 12.476572799851679,
             "xrp": 3.7926262896918623,
             "usdt": 3.596404539007709,
             "sol": 2.945587296023544,
             "bnb": 2.83630301546485,
             "doge": 1.790298083960694,
             "ada": 1.1076348662868527,
             "usdc": 1.0744350901883999,
             "steth": 1.0184252454865015
         },
         "market_cap_change_percentage_24h_usd": -1.2739704253506692,
         "updated_at": 1733638139
     }
 }
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

// MARK: - DataClass
struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }){
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volumn: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }){
            return "$\(item.value.formattedWithAbbreviations())"
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }){
            return item.value.asPercentageString()
        }
        return ""
    }
}
