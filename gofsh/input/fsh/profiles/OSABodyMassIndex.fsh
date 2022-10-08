Profile: OSABodyMassIndex
Parent: USCoreBMIProfile
Id: OSABodyMassIndex
Description: "Body mass index, or BMI, is a measure of body size. It combines a person's weight with their height."
* ^version = "0.1.0"
* effective[x] only dateTime
* effective[x] ^type.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-type-must-support"
* effective[x] ^type.extension.valueBoolean = true
* performer 1..1 MS