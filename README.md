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
The full list is available in parseType method.