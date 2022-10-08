Instance: osa-bmi-example
InstanceOf: OSABodyMassIndex
Title: "osa-bmi-example"
Description: "Example of OSA BMI value"
Usage: #example
* code = $loinc#39156-5
* category = $observation-category#vital-signs
* valueQuantity = 32.5 'kg/m2' "kg/m2"
* subject.reference = "Patient/osa-patient-jane-doe"
* status = #final
* effectiveDateTime = "2021-09-28"
* performer.reference = "Practitioner/osa-practitioner-kyle-anydoc"