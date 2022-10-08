Instance: osa-patient-jane-doe
InstanceOf: OSAPatient
Title: "osa-patient-jane-doe"
Description: "Example OSA Patient."
Usage: #example
* extension.url = "http://hl7.org/fhir/StructureDefinition/patient-birthPlace"
* extension.valueAddress.state = "MA"
* name.family = "Doe"
* name.given = "Jane"
* identifier.use = #usual
* identifier.type = $v2-0203#MR "Medical Record Number"
* identifier.system = "http://hospital.example.org"
* identifier.value = "1234"
* gender = #female
* birthDate = "1950-01-22"