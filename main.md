---
title: The eICU Collaborative Research Database, a freely available database for critical care research
author:
        - Name Name^1^
        - Name Name^1^
        - Name Name^1^
        - Name Name^2^
        - Name Name^2^
date: April 24, 2017
company: ^1^ Massachusetts Institute of Technology, Cambridge, USA; ^2^ Philips Healthcare, Baltimore, MD, USA.
keywords: critical care, telemedicine, ICU, reproducibility
---

<!--
Figure/Table list
Table 1. Demographics
Table 2. Top 10 Diagnoses
Table 3. Data completion by patientunitstayid
Table 4. Planned/excluded tables

Figure 1. Funnel plot of hospitals
Figure 2. Example patient

-->

# Abstract{.unnumbered}

- Introduce the eICU Collaborative Research Database.
- Valuable dataset for research and education.

# Background \& Summary

<!-- ICUs are expensive
[@Halpern2014]
- $1,699 per patient per bed day in 2005
- 32.7% increase in per day per bed patient cost from 2000 to 2005
- 5.82% increase compounded per year in the US
- ICUs represented 13.4% of hospital costs
- 0.66% GDP
[@NHS2010] - 2010 UK
- 1,219 pounds (level 2 ICU bed) per patient-bed-day
- 1,638 pounds (level 3 ICU bed) per patient-bed-day
- 5.01% of hospital costs
- 0.58% of the GDP
 -->

Intensive care units (ICUs) provide care for severely ill patients who require life-saving treatment. Critical care as a subspecialty of medicine began during a polio epidemic in which large number of patients required artificial ventilation for many weeks [@kelly2014intensive]. Since then, the field of critical care as grown, and continues to grow as demographics shift toward older populations [@adhikari2010critical].
Patients in ICUs are monitored heavily to detect physiologic deviation associated with deteriorating illness and change their treatment regimen as appropriate.
Monitoring of ICU patients is facilitated by bedside monitors which continuously stream huge quantities of data, and a relatively small portion of this data is archived for later analysis [@Celi].

A telehealth ICU, or teleICU, is a centralized model of care where remote providers monitor ICU patients continuously, providing both structured consultations and reactive alerts [@lilly2014critical]. TeleICUs allow caregivers from remote locations to monitor treatments for patients, alert local providers to sudden deterioration, and supplement care plans.
Philips Healthcare, a major vendor of ICU equipment and services, provide a teleICU service known as the eICU program [@eICUProgram].
Care providers primarily access and document data in an information management system called eCareManager and additionally have access to the other information systems present in the hospital.
During routine use of the eICU program, large amounts of data are collected and transferred to remote locations. This data is archived by Philips and transformed into a research database by the eICU Research Institute (eRI).
The laboratory of computational physiology (LCP) partnered with eRI to produce the eICU Collaborative Research Database (eICU-CRD), a publicly available database sourced from the eICU telehealth program.

# Methods

## Database structure and development

eICU-CRD is a relational database comprising of 17 tables.
All tables were de-identified to meet the safe harbor provision of HIPAA [@HIPAA]. These provisions include the removal of all personally identifiable patient identifiers, ages over 89, and other personal information. Large portions of all tables were manually reviewed by at least three personnel to verify all data had been de-identified.
Patient identifiers are generated randomly, and as a result the identifiers in eICU-CRD cannot be linked back to the original, identifiable data.

## Patient identifiers

Each patient stay in a unit, where the primary unit of care is the ICU, is identified by a single integer: the `patientunitstayid`. Each unique hospitalization is also assigned a unique integer, known as the `patienthealthsystemstayid`. Finally, patients are identified by a `uniquepid`. Each `patienthealthsystemstayid` has at least one or more `patientunitstayid`, and each `uniquepid` can have multiple hospital and/or unit stays.
Figure \ref{fig:patient_organization} visualizes this hierarchy.
All tables use `patientunitstayid` to identify an individual unit stay, and the patient table can be used to determine unit stays linked to the same patient and/or hospitalization.

![Organization of patient data demonstrating how a single patient can have multiple hospital stays, and each hospital stay can have multiple unit stays. \label{fig:patient_organization}](img/PatientOrganization.png){ width=70% }

## Sample selection

A non-random sample of patients was selected from the eRI research data repository. The selection was done as follows: first, all hospital discharges between 2014 and 2015 were identified, and a single index stay for each unique patient was extracted.
The proportion of index stays in each hospital from the eRI data repository was used to perform a stratified sample of patient index stays based upon hospital. If a patient index stay was selected, then all stays for that patient were included in the dataset, regardless of hospital.
A small proportion of patients only had stays in step down units or low acuity units, and these stays were removed.

1. Select stays which were discharged from the hospital in 2014 or 2015 using the hospital discharge year.
2. For each patient with an eligible stay, identify the index stay in the 2014-15 period, designate the
hospital where this occurred as the ‘home hospital’ for this patient.
3. Calculate the ‘home hospital’ distribution across all patients with an eligible stay. Denote these
proportions as pi (the proportion of patients with home hospital i).
4. Designate N as the target number of stays (in our case, N ≈ 200,000), and n as the number of unique
patients required to select about N stays. Approximate how large n should be based on the average
number of stays and the loss of ineligible stays (e.g., from SDUs) to achieve around N stays.
5. It was found that selecting about 29% of the eligible patients corresponded with approximately 200k
stays in the final dataset, and this corresponded with about n = 188k patients.
6. For patients with home hospital i, select ni = n × pi patients, and repeat this across all hospitals.
7. From these select n patients, collect all stays with a discharge in 2014-15, regardless if they occurred at
the home hospital or a different hospital.
8. Remove stays occurring in an SDU or acute unit. Remove stays which occurred at hospitals with
incomplete vital signs or other information.

## Code availability

<!--
Philips ETL code is proprietary and unavailable.
LCP code is available (?): eicu-building
-->

# Data records

eICU-CRD comprises 200,859 patient unit encounters for 139,367 unique patients admitted between 2014 and 2015.
Patients were admitted to one of 335 units at 208 hospitals located throughout the US.
Table 1 provides demographics of the dataset, including hospital level characteristics.

| Data                             | Number (%)          | Miss  |
|:---------------------------------|:--------------------|:------|
| n                                | 200859              |       |
| age_numeric (median [IQR])       | 65.00 [53.00,76.00] | 95    |
| unit_los (median [IQR])          | 1.57 [0.82,2.97]    | 0     |
| hospital_los (median [IQR])      | 5.49 [2.90,10.04]   | 0     |
| diedinhospital (mean (std))      | 0.09 (0.29)         | 29682 |
| admissionheight (mean (std))     | 169.25 (13.69)      | 4215  |
| admissionweight (mean (std))     | 83.93 (27.09)       | 16718 |
| gender_grouped (n (%))           |                     | 0     |
|                                  | 134 (0.07)          |       |
| Female                           | 92303 (45.95)       |       |
| Male                             | 108379 (53.96)      |       |
| Other or Unknown                 | 43 (0.02)           |       |
| ethnicity (n (%))                |                     | 0     |
|                                  | 2290 (1.14)         |       |
| African American                 | 21308 (10.61)       |       |
| Asian                            | 3270 (1.63)         |       |
| Caucasian                        | 155285 (77.31)      |       |
| Hispanic                         | 7464 (3.72)         |       |
| Native American                  | 1700 (0.85)         |       |
| Other/Unknown                    | 9542 (4.75)         |       |
| hospital_size (n (%))            |                     | 25279 |
| <100                             | 12593 (7.17)        |       |
| 100 - 249                        | 41966 (23.90)       |       |
| 250 - 499                        | 45716 (26.04)       |       |
| >= 500                           | 75305 (42.89)       |       |
| hospital_teaching_status (n (%)) |                     | 0     |
| False                            | 149181 (74.27)      |       |
| True                             | 51678 (25.73)       |       |
| hospital_region (n (%))          |                     | 13838 |
| Midwest                          | 65950 (35.26)       |       |
| Northeast                        | 14429 (7.72)        |       |
| South                            | 60294 (32.24)       |       |
| West                             | 46348 (24.78)       |       |
| hospitaldischargeyear (n (%))    |                     | 0     |
| 2014                             | 95513 (47.55)       |       |
| 2015                             | 105346 (52.45)      |       |
| unittype (n (%))                 |                     | 0     |
| CCU-CTICU                        | 15290 (7.61)        |       |
| CSICU                            | 9625 (4.79)         |       |
| CTICU                            | 6158 (3.07)         |       |
| Cardiac ICU                      | 12467 (6.21)        |       |
| MICU                             | 17465 (8.70)        |       |
| Med-Surg ICU                     | 113222 (56.37)      |       |
| Neuro ICU                        | 14451 (7.19)        |       |
| SICU                             | 12181 (6.06)        |       |
| unitdischargestatus (n (%))      |                     | 0     |
|                                  | 34 (0.02)           |       |
| Alive                            | 189918 (94.55)      |       |
| Expired                          | 10907 (5.43)        |       |
| hospitaldischargestatus (n (%))  |                     | 0     |
|                                  | 1751 (0.87)         |       |
| Alive                            | 181104 (90.16)      |       |
| Expired                          | 18004 (8.96)        |       |
Table 1: Demographics of the cohort.

Table 2 highlights the top 10 most frequent admission diagnoses in the dataset as coded by the APACHE IV diagnosis system [@Zimmerman2008].

| Diagnosis | Number | Percent |
|-----|-----|-----|
| No diagnosis available | 22996 | 11.45 |
| Sepsis, pulmonary | 8862 | 4.41 |
| Infarction, acute myocardial (MI) | 7228 | 3.60 |
| CVA, cerebrovascular accident/stroke | 6647 | 3.31 |
| CHF, congestive heart failure | 6617 | 3.29 |
| Sepsis, renal/UTI (including bladder) | 5273 | 2.62 |
| Rhythm disturbance (atrial, supraventricular) | 4827 | 2.40 |
| Diabetic ketoacidosis | 4825 | 2.40 |
| Cardiac arrest (with or without respiratory arrest; for respiratory arrest see Respiratory System) | 4580 | 2.28 |
| CABG alone, coronary artery bypass grafting | 4543 | 2.26 |
Table 2: Most frequent admission diagnoses as coded using the APACHE-IV diagnosis system.

## Classes of data

Data includes vital signs, laboratory measurements, medications, APACHE components, care plan information, admission diagnosis, patient history, time-stamped diagnoses from a structured problem list, and similarly chosen treatments. Data is organized into tables which broadly correspond to the type of data contained within the table. Table 3 gives an overview of tables on the database.

| Group | Table name | Type of data |
|-------|------------|--------------|
| Administrative information | hospital | Hospital level survey information: bed size, teaching status, and US region |
| Administrative information | patient | Demographic and administrative information regarding the patient and their unit/hospital stay |
| APACHE | admissiondx | APACHE Admission diagnoses and other APACHE information |
| APACHE | apacheapsvar | Acute Physiology Score (APS)-III components for APACHE predictions |
| APACHE | apachepredvar | Components for the APACHE predictions |
| APACHE | apachepatientresult | Predictions made from the APACHE IV system (versions IV and IVa) |
| Care plan | careplancareprovider | Information regarding the current care providers for the patient |
| Care plan | careplaneol | End of life care planning |
| Care plan | careplangeneral | Care plan for the patient, including end of life care |
| Care plan | careplangoal | Stated goals of care for the patient |
| Care plan | careplaninfectiousdisease | Precautions for patient related to infectious disease |
<!-- AdmissionDrug -->
| Care documentation | diagnosis | Structured list detailing ongoing problems/diagnoses |
| Care documentation | treatment | Structured list detailing active treatments provided to the patient |
| Care documentation | pasthistory | Structured list detailing patient's health status prior to presentation in the unit |
| Care documentation | lab | Laboratory measurements |
| Care documentation | medication | Prescribed medications |
| Monitor data | vitalaperiodic | Aperiodic vital sign measurements (unevenly sampled) |
| Monitor data | vitalperiodic | Periodic vital sign measurements (5 minute interval) |

### Administrative data

### APACHE data

The Acute Physiology and Chronic Health Evaluation (APACHE)-IV system [@Zimmerman2008] is a tool used for hospital benchmarking and risk-adjustment. The APACHE-IV system, among other predictions, provides estimates of the probability that a patient dies given data from the first 24 hours. These predictions, on aggregate across many patients, can be used to benchmark hospitals and subsequently identify policies from hospitals which are beneficial for patient outcomes. In order to make these predictions, care providers must collect a set of parameters regarding the patient: physiologic measurements, comorbid burden, treatments given, and admission diagnosis. These parameters are used in a logistic regression to predict mortality. eICU-CRD contains all parameters used in the APACHE-IV equations: physiologic parameters are primarily stored in `apacheapsvar`, and other parameters are stored in `apachepredvar`. The result of the predictions for both the APACHE-IV and the updated APACHE-IVa equation are available in `apachepatientresult`. This data provides an excellent estimate of patient severity of illness on admission to the ICU, though it should be noted that these predictions are not available for every patient, in particular: those who stay less than 4 hours, burns patients, certain transplant patients, and in-hospital readmissions. See the original publication for more detail [@Zimmerman2008].

### Care plan

The care plan is a section of eCareManager which is primarily used for intraprofessional communication. The data is documented using structured multiple choice lists and is used to communicate care provider type and specialty, code status, prognosis, healthcare proxies, facilitate end-of-life discussion,

### Administrative data

### Care documentation

Treatments and diagnoses are selected by the care giver from a drop down list of options. There are ???? unique treatments and ???? unique diagnoses in the database. Both treatment and body system use a hierarchical coding system allowing for specification of terms corresponding to overarching groups such as body system. Care plans are similarly structured but do not have the same hierarchical grouping as treatments and diagnoses.

### Monitor data

Periodic vital signs are recorded every 5 minutes and include heart rate, respiratory rate, oxygen saturation, temperature, invasive arterial blood pressure, pulmonary artery pressure, ST levels, and intracranial pressure (ICP). Periodic vital signs are not validated by care staff and not available for all patients. The most frequently available periodic vital sign is heart rate (??%), and the least available periodic vital sign is ICP (??%). Aperiodic vital signs are collected at various times and include non-invasive blood pressure, PAOP, cardiac output, cardiac input, SVR, SVRi, PVR, and PVRi. The most frequent aperiodic vital sign is mean blood pressure (??%), and the least frequent is PVRi (??%).

Laboratory values are collected within the hospital and are stored with the unit of measurement and last time the value was revised.

# Technical validation

- Changes were kept to a minimum
- Issue tracking used to keep track of issues
- Compared distribution of X to MIMIC. Figure shows...

# Usage notes

## Data access

Data can be accessed via a PhysioNetWorks repository [@data-doi]. Usage of the data requires proof of completion for a course on using human subjects in research. Usage of the data also requires signing of a data use agreement stipulating, among other items; that the user will not share the data, will not attempt to re-identify any patients or institutions, and will release code associated with any publication using the data.

<!--
Documentation is continuously updated and available online http://eicu-crd.mit.edu
- Previously shared MIMIC-III under these terms [@MIMIC2016]
-->


## Collaborative code

As the aim of the eICU-CRD is to foster collaboration in secondary analysis of electronic health records, we have created an openly available repository for sharing code [@eicu-code].
<!-- https://github.com/mit-eicu/eicu-code -->
Code used to extract concepts from the data is under continuous development.


## Example usage

<!-- Can use SQL/PostgreSQL to access. We provide code from above repo to facilitate building it -->

Figure 2 provides a visualization of data available for a single patient.

<!-- TODO figure 1 -->

- Examples of usage include...

# Conclusion

- Shared a unique resource
- Move towards end-to-end reproducible research

# Acknowledgments{.unnumbered}

The authors would like to thank...

# Funding{.unnumbered}

This work has been supported by grants NIH-R01-EB017205, NIH-R01-EB001659, and NIH-R01-GW104987 from the National Institutes of Health.

# Author contributions{.unnumbered}

XXXX

# Competing interests{.unnumbered}

The MIT Laboratory for Computational Physiology received funding from Philips Healthcare to undertake work on the database described in this paper. XXX are employees of Philips Healthcare. The authors have no additional competing interests to declare.

# References{.unnumbered}
