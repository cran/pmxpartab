## ----echo=FALSE, message=FALSE, warning=FALSE, results='hide'-----------------
library(pmxpartab, quietly=TRUE)

## -----------------------------------------------------------------------------
library(yaml)

outputs <- yaml.load("
est:
  CL:   0.482334
  VC:   0.0592686
  nCL:  0.315414
  nVC:  0.536025
  ERRP: 0.0508497
se:
  CL:   0.0138646
  VC:   0.0055512
  nCL:  0.0188891
  nVC:  0.0900352
  ERRP: 0.0018285
fixed:
  CL:   no
  VC:   no
  nCL:  no
  nVC:  no
  ERRP: no
shrinkage:
  nCL:  9.54556
  nVC:  47.8771
")

## -----------------------------------------------------------------------------
meta <- yaml.load("
parameters:
- name:  CL
  label: 'Clearance'
  units: 'L/h'
  type:  Structural

- name:  VC
  label: 'Volume'
  units: 'L'
  type:  Structural
  trans: 'exp'
  
- name:  nCL
  label: 'On Clearance'
  type:  IIV
  trans: 'SD (CV%)'
  
- name:  nVC
  label: 'On Volume'
  type:  IIV
  trans: 'SD (CV%)'
  
- name:  ERRP
  label: 'Proportional Error'
  units: '%'
  type:  RUV
  trans: '%'
")

## -----------------------------------------------------------------------------
parframe <- pmxparframe(outputs, meta)
parframe

## -----------------------------------------------------------------------------
pmxpartab(parframe)

## -----------------------------------------------------------------------------
footnote <- c(
    "CI=confidence interval; RSE=relative standard error.",
    "Source: run001")

pmxpartab(pmxparframe(outputs, meta), footnote=footnote)

## -----------------------------------------------------------------------------
outputs |> pmxparframe(meta) |> pmxpartab(footnote=footnote)

## -----------------------------------------------------------------------------
outputs <- yaml.load("
est:
  nCL:     3.95926E-01
  nVC:     1.42749E+00 
  nCL_nVC: 8.45393E-02
se:
  nCL:     9.57069E-03
  nVC:     4.62152E-02 
  nCL_nVC: 4.26648E-02
")

meta <- yaml.load("
parameters:
- name:  'nCL'
  label: 'On CL'
  type:  IIV

- name:  'nVC'
  label: 'On Vc'
  type:  IIV

- name:  'nCL_nVC'
  label: 'Correlation CL-Vc'
  type:  IIV
")

outputs |> pmxparframe(meta) |> pmxpartab()

## -----------------------------------------------------------------------------

outputs <- list(
    est = list(
        om     = c(nCL=3.95926E-01, nVC=1.42749E+00),
        om_cov = matrix(c(1.56758E-01, 4.77799E-02, 4.77799E-02, 2.03772E+00), 2, 2),
        om_cor = matrix(c(3.95926E-01, 8.45393E-02, 8.45393E-02, 1.42749E+00), 2, 2)),
    se = list(
        om     = c(nCL=9.57069E-03, nVC=4.62152E-02),
        om_cov = matrix(c(7.57858E-03, 2.47183E-02, 2.47183E-02, 1.31943E-01), 2, 2),
        om_cor = matrix(c(9.57069E-03, 4.26648E-02, 4.26648E-02, 4.62152E-02), 2, 2)))

meta <- yaml.load("
parameters:
- name:  'om_cov(nCL,nCL)'
  label: 'Variance log(CL)'
  type:  IIV

- name:  'om_cov(nVC,nVC)'
  label: 'Variance log(Vc)'
  type:  IIV

- name:  'om_cor(nCL,nCL)'
  label: 'SD log(CL)'
  type:  IIV

- name:  'om_cor(nVC,nVC)'
  label: 'SD log(Vc)'
  type:  IIV

- name:  'om_cov(nCL,nVC)'
  label: 'Covariance log(CL)-log(Vc)'
  type:  IIV

- name:  'om_cor(nCL,nVC)'
  label: 'Correlation log(CL)-log(Vc)'
  type:  IIV
")

outputs |> pmxparframe(meta) |> pmxpartab()

