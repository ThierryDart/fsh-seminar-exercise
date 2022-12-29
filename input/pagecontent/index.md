# FSHSeminarExercise

Original seminar is located at : https://fshschool.org/courses/fsh-seminar/ 

### Step 1: Define problem & participants

**Hypothetical problem:**

> The Obstructive Sleep Apnea Association (OSAA - a fictitious clinical organization based in the U.S.) is looking to evaluate the impact of obesity as a risk > for Obstructive Sleep Apnea (OSA). OSAA needs a way to ensure the relevant clinical data are collected in a standard, interoperable format from participating member sites.

**Participants:**

* OSAA
* Participating study sites

For the purposes of this course, we will assume the content of this IG is limited to Domain of Knowledge (i.e., the API for data exchange is out of scope).

### Step 2: Define use case(s)

The use case for this work is as follows:

> OSAA has setup a small registry to collect EHR clinical data from healthcare organizations participating in this evaluation.
> 
> OSAA sites will submit the following **required** data to the central OSAA registry:
> 
> * Patient name, age, birth place
> * Patient’s managing practitioner name, and the practitioner(s) NPI identifier(s)
> * A diagnosis of OSA, identified by one of the following ICD-10-CM codes:
>     1.  `G47.33` Obstructive sleep apnea (adult) (pediatric)
>     2.  `G47.30` Sleep apnea, unspecified
> * Patient’s body mass index (BMI)
>     * BMI calculated value
>     * Date when calculated
>     * The provider who performed the BMI calculation
> 
> Additionally, all participating sites may **optionally** submit:
> 
> * Date of OSA diagnosis
> * Patient age at time of OSA diagnosis


Typically a use case like this would be developed with the involvement of stakeholders and subject matter experts. In this case, OSAA and providers from study sites would likely be involved alongside the technical experts authoring the specification.

### Step 3: Workflow/Data Elements/Terminology

#### Workflow

Out of scope because this is a Domain of Knowledge IG.

#### Data elements

Based on the use case, the essential data elements are:

* Patient name
* Patient birth date
* Patient birth place
* Managing practitioner name
* Managing practitioner NPI identifier
* Diagnosis of obstructive sleep apnea (OSA)
    * Diagnosis identified by one of the following ICD-10-CM codes:
        1.  _G47.33 Obstructive sleep apnea (adult) (pediatric)_
        2.  _G47.30 Sleep apnea, unspecified_
* _Optional:_ Diagnosis date
* _Optional:_ Patient age at diagnosis
* Diagnosing provider
* Body mass index (BMI) measurement
    * BMI calculated value
    * Date when calculated
    * The provider who performed the BMI calculation

#### Terminology

Domain expertise may be required to identify the relevant [terminology](https://www.hl7.org/fhir/terminologies.html). The [Terminology stream on chat.fhir.org](https://chat.fhir.org/#narrow/stream/179202-terminology) may be a good resource to identify experts who can point you to the best code systems for your use case.

In this case, [ICD-10-CM](https://www.hl7.org/fhir/icd.html) was identified in the use case as the code system to use for identifying diagnoses.

### Step 4: Profiling decisions

#### High-level information model

A good way to map a set of data elements onto FHIR resources is to identify any relationships among the identified data elements. We accomplish this by creating a high level concept or logical information model.

According to [David Hay](https://fhirblog.com/creating-an-information-model/):

> an “Information Model” describes the actual data items that are intended to be included when sharing clinical data. It is intended to allow a clinician (or a Business Analyst) to document these requirements without thinking about how it will be represented in ‘real’ FHIR resources. _Very little FHIR knowledge is required._

Here is an information model for our use case:

OSA Patientnamebirth datebirth placeOSA BMIBMI valueresult dateperformerOSA Conditiondiagnosis codediagnosis datediagnosing providerOSA Practitioneridentifier (NPI)name

High-level information models like this (i.e., not FHIR-specific) are helpful for a number of reasons:

* FHIR is an evolving standard, and the [maturity level](https://confluence.hl7.org/display/FHIR/FHIR+Maturity+Model) of FHIR resources may vary. Lower-maturity resources may not be as fully-developed, and while they may superficially seem like a good choice for a given use case, on closer inspection they may not be mature enough. Having a high-level information model provides a benchmark to compare against when considering the suitability of a FHIR resource.
* A use case’s conformant data elements might be applied or evaluated against other common data models (CDM) within a given domain. This is facilitated by the high-level information model.
    * For example, clinical data for observational studies could be based on FHIR resource models or the OMOP CDM.

#### Mapping high-level information model to FHIR resources

We will need to pick a version of FHIR to base the IG off of. As of May 2022 [FHIR 4.0.1](http://hl7.org/fhir/R4/) is the stable release, which is usually the correct choice. However, you can [see all release here](http://hl7.org/fhir/directory.html), and if an upcoming release is close to being ready you may want to use that instead. Currently both R4B and R5 are in progress.

IG authors should take care to align with existing specifications in the relevant jurisdiction. In our case, we will align with [FHIR U.S. Core 3.2](http://hl7.org/fhir/us/core/2021Jan/) profiles where possible.[3](#fn:USCore)

The [IG creation stream on chat.fhir.org](https://chat.fhir.org/#narrow/stream/179252-IG-creation) is a good place to ask for advice on alignment with existing specifications for a given use case.

We will now create a **Resources Model**, which [David Hay](https://fhirblog.com/creating-an-information-model/) defines as follows:

> A “Resources Model” takes the Information Model and “divides it up” into the actual FHIR resources (including extensions) that will be required to represent the data in the Information Model. This needs a good understanding of FHIR, but the resultant model should be understandable by the clinician. Most of the time a Resources Model will represent multiple resources – though it is possible to create one for a single resource only.

Determining which FHIR resources are the best fit for mapping with the information model may be quite challenging due to the number of FHIR resources and conventions about which resources to use when. Some good places to start when trying to figure this out:

* Look at the [FHIR resource list](https://www.hl7.org/fhir/resourcelist.html) and read the “Scope and Usage” section on each resource that seems potentially applicable.
* Look at existing established IGs. For example, [US Core](http://hl7.org/fhir/us/core/2021Jan/) has a [number of profiles](http://hl7.org/fhir/us/core/2021Jan/profiles-and-extensions.html), so looking through these to see if any elements of your information model map cleanly onto one may be helpful.
* Ask for help on [chat.fhir.org](https://chat.fhir.org/#narrow/stream/179252-IG-creation).

A structural mapping of our information elements to FHIR resource elements is shown in the table below. In this table, each row represents a data element, which are grouped into profiles of FHIR resources based on the “Profile Name” column. You can see which FHIR resource is being used for a given data element by looking at the first part of the “FHIR element name / Path” column (i.e., the patient’s name is represented by `Patient.name`, indicating that the [Patient](https://www.hl7.org/fhir/R4/patient.html) resource is used).

| Profile Name | FHIR element name / Path | Use Case Data Element | Comments |
| --- | --- | --- | --- |
| `OSAPatient` | `Patient.name` | Patient name |     |
| `OSAPatient` | `Patient.birthDate` | Patient birth date |     |
| `OSAPatient` | `Patient.generalPractitioner` | Patient’s primary care provider |     |
| `OSAPatient` | `Patient.extension.patient-birthPlace` | Patient’s birth place | Found FHIR standard extension, [patient-birthPlace](http://hl7.org/fhir/extension-patient-birthplace.html) |
| `OSAPractitioner` | | Practitioner name |     |
| `OSAPractitioner` | | Practitioner NPI |     |
| `OSACondition` |  | OSA diagnosis code |     |
| `OSACondition` |  | OSA onset date |     |
| `OSACondition` |  | Managing provider who diagnosed OSA |     |
| `OSABodyMassIndex` | `Observation.code` | Body Mass Index (BMI) | Base on existing [US Core BMI profile](http://hl7.org/fhir/us/core/2021Jan/StructureDefinition-us-core-bmi.html) |
| `OSABodyMassIndex` | `Observation.effectiveDateTime` | Body Mass Index (BMI) |     |
| `OSABodyMassIndex` | `Observation.valueQuantity` | BMI measurement |     |

When creating structural mappings to FHIR data elements, consider the following:

* Does an appropriate element exist in the FHIR resource?
* Is there a [FHIR standard extension](http://hl7.org/fhir/extensibility-registry.html) that can be used?
* Could this be addressed through a FHIR query or operation instead of using an extension?
* Could the data element be derived by the receiving application, rather than generating it in the sending application?

#### Semantic mappings

At this point you should have already identified target terminology, and now need to connect this to the relevant data elements from your Resources Model.

The two most common terminology-related conformance resources are:

1.  [CodeSystem](https://www.hl7.org/fhir/codesystem.html) – “declares the existence of and describes a code system or code system supplement and its key properties, and optionally defines a part or all of its content. Also known as Ontology, Terminology, or Enumeration”
2.  [ValueSet](https://www.hl7.org/fhir/R4/valueset.html) – “specifies a set of codes drawn from one or more code systems, intended for use in a particular context. Value sets link between CodeSystem definitions and their use in coded elements”

You should **avoid creating a new CodeSystem if possible**. Instead, use one of the existing HL7 or external code systems [defined here](https://terminology.hl7.org/). More information on code systems may also be found at the [HL7 Health Terminology Authority (HTA) Confluence site](https://confluence.hl7.org/display/TA/External+Terminologies+-+Information). Creating a new CodeSystem will likely increase implementer burden and harms interoperability across Implementation Guides.

CodeSystems in FHIR are identified by a canonical URL or [OID](https://en.wikipedia.org/wiki/Object_identifier). You will need to identify this to reference an existing CodeSystem in a ValueSet.

The ValueSet (not the CodeSystem) is [bound](https://www.hl7.org/fhir/R4/profiling.html#binding) to a FHIR element. When considering ValueSet bindings, keep the following in mind:

* Is there an existing value set that can be used (e.g., from [VSAC](https://vsac.nlm.nih.gov/))? If not, should you create a new ValueSet resource in your IG, or create it externally to your IG? (The [Terminology stream on chat.fhir.org](https://chat.fhir.org/#narrow/stream/179202-terminology) may be a good place to ask questions about the specifics of your use case.)
* Are there value set constraints assigned to the FHIR resource element already? If so, what is the [binding strength](https://www.hl7.org/fhir/R4/profiling.html#binding) (example, preferred, extensible, required)?
* What is the best binding strength for your use case? (Note that profiles can only _increase_ the strength of a binding, not decrease it.)


