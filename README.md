# flutter_hk_write

A small plugin for writing nutrition values into HealthKit

## Supported Types

- dietaryEnergyConsumed
- dietaryFatTotal
- dietaryFatSaturated
- dietaryCholesterol
- dietaryCarbohydrates
- dietaryFiber
- dietarySugar
- dietaryProtein
- dietaryCalcium
- dietaryIron
- dietaryPotassium
- dietarySodium
- dietaryVitaminA
- dietaryVitaminC
- dietaryVitaminD

## Argument format

Pass a list of maps:

    FlutterHkWrite.writeQuantityEntries([
                                            {
                                            "value": model.protein,
                                            "from": DateTime.now()
                                                .millisecondsSinceEpoch ~/
                                                1000,
                                            "to": DateTime.now()
                                                .millisecondsSinceEpoch ~/
                                                1000,
                                            "type": "Protein",
                                            "unit": "gram"
                                            },]


## Units

- liter
- G
- KCAL
- MG (Milligramm)
- UG (Microgramm)

## Datatype Keys

nutrient_id	nutrient_name	count	unit_name	original_name
1051	Water	99.73055295220243	G	Water
1008	Energy	99.67197750702906	KCAL	Energy (KCAL)
1092	Potassium, K	99.36738519212746	MG	Potassium, K
1093	Sodium, Na	98.81677600749765	MG	Sodium, Na
1095	Zinc, Zn	98.7933458294283	MG	Zinc, Zn
1091	Phosphorus, P	98.46532333645736	MG	Phosphorus, P
1098	Copper, Cu	98.40674789128397	MG	Copper, Cu
1090	Magnesium, Mg	98.39503280224929	MG	Magnesium, Mg
1087	Calcium, Ca	98.33645735707591	MG	Calcium, Ca
1089	Iron, Fe	98.27788191190253	MG	Iron, Fe
1167	Niacin (Vitamin B3)	97.77413308341143	MG	Niacin
1166	Riboflavin (Vitamin B2)	97.69212746016869	MG	Riboflavin
1180	Choline	97.61012183692596	MG	Choline, total
1003	Protein	97.51640112464854	G	Protein
1165	Thiamin (Vitamin B1)	97.08294283036551	MG	Thiamin
1004	Fat	96.8369259606373	G	Total lipid (fat)
1103	Selenium, Se	96.70805998125586	UG	Selenium, Se
1175	Vitamin B6	96.69634489222118	MG	Vitamin B-6
1293	Polyunsaturated fat	96.19259606373008	G	Fatty acids, total polyunsaturated
1269	Linoleic acid (Polyunsaturated Omega-6 fatty acid)	96.11059044048734	G	18:2
1258	Saturated fat	95.8294283036551	G	Fatty acids, total saturated
1265	Palmitic acid (Saturated fatty acid)	95.78256794751641	G	16:0
1292	Monounsaturated fat	95.77085285848173	G	Fatty acids, total monounsaturated
1109	Vitamin E	95.3842549203374	MG	Vitamin E (alpha-tocopherol)
1268	Oleic acid (Monounsaturated Omega-9 fatty acid)	95.26710402999062	G	18:1
1190	Folate (DFE)	94.86879100281162	UG	Folate, DFE
1177	Folate	94.85707591377694	UG	Folate, total
1266	Stearic acid (Saturated fatty acid)	94.11902530459231	G	18:0
1005	Carbohydrate	94.01358950328023	G	Carbohydrate, by difference
1270	Linolenic acid (Polyunsaturated Omega-3 fatty acid)	93.48641049671977	G	18:3
1187	Folate (food)	91.62371134020619	UG	Folate, food
1185	Phylloquinone (Vitamin K)	90.3116213683224	UG	Vitamin K (phylloquinone)
2000	Sugar	90.28819119025304	G	Sugars, total including NLEA
1275	Palmitoleic acid (Monounsaturated Omega-7 fatty acid)	86.87910028116214	G	16:1
1264	Myristic acid (Saturated fatty acid)	84.32521087160264	G	14:0
1106	Vitamin A	81.7244611059044	UG	Vitamin A, RAE
1079	Fiber	77.89362699156513	G	Fiber, total dietary
1162	Vitamin C	71.05201499531397	MG	Vitamin C, total ascorbic acid
1277	Paullinic acid (Unsaturated Omega-7 fatty acid)	70.84114339268979	G	20:1
1263	Lauric acid (Saturated fatty acid)	70.8294283036551	G	12:0
1107	Carotene (beta)	69.93908153701967	UG	Carotene, beta
1123	Lutein and zeaxanthin	69.1776007497657	UG	Lutein + zeaxanthin
1262	Capric acid (Saturated fatty acid)	62.34770384254921	G	10:0
1253	Cholesterol	61.57450796626054	MG	Cholesterol
1105	Retinol (Vitamin A1)	61.53936269915652	UG	Retinol
1178	Vitamin B12	60.953608247422686	UG	Vitamin B-12
1114	Vitamin D	47.211808809746955	UG	Vitamin D (D2 + D3)
1261	Caprylic acid (Saturated fatty acid)	47.15323336457357	G	8:0
1271	Eicosatetraenoic acid (Polyunsaturated Omega-3 fatty acid)	45.80599812558576	G	20:4
1259	Butyric acid (Saturated fatty acid)	41.04967197750703	G	4:0
1260	Caproic acid (Saturated fatty acid)	38.964386129334585	G	6:0
1186	Folic acid	35.49671977507029	UG	Folic acid
1280	Docosapentaenoic acid (Polyunsaturated Omega-3 fatty acid)	30.37722586691659	G	22:5 n-3 (DPA)
1120	Cryptoxanthin (beta)	29.73289597000937	UG	Cryptoxanthin, beta
1272	Docosahexaenoic acid (Polyunsaturated Omega-3 fatty acid)	29.018275538894095	G	22:6 n-3 (DHA)
1108	Carotene (alpha)	28.877694470477977	UG	Carotene, alpha
1278	Eicosapentaenoic acid (Polyunsaturated Omega-3 fatty acid)	25.468603561387066	G	20:5 n-3 (EPA)
1279	Erucic acid (Unsaturated Omega-9 fatty acid)	19.365042174320525	G	22:1
1122	Lycopene	13.156044985941891	UG	Lycopene
1276	Stearidonic acid (Polyunsaturated Omega-3 fatty acid)	10.379568884723524	G	18:4
1246	Vitamin B12 (added)	6.291002811621368	UG	Vitamin B-12, added
1057	Caffeine	6.2441424554826614	MG	Caffeine
1058	Theobromine (xantheose)	4.896907216494846	MG	Theobromine
1242	Vitamin E (added)	4.498594189315839	MG	Vitamin E, added
1018	Alcohol	1.1949390815370198	G	Alcohol, ethyl