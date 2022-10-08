Profile: OSAPatient
Parent: USCorePatientProfile
Id: OSAPatient
Description: "An example Patient profile"
* ^version = "0.1.0"
* extension contains $patient-birthPlace named birthPlace 0..1 MS
* birthDate 1..
* generalPractitioner only Reference(OSAPractitioner)