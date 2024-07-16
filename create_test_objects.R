source(here::here("config.R"))

cause_list <- c(
  "INFLU_A",
  "INFLU_B",
  "PARA_1",
  "PARA_2",
  "PARA_3",
  "RSV",
  "HUMET",
  "ENTRHI",
  "ADENO",
  "CORONA",
  "BOCA",
  "S_PNEU",
  "M_PNEU",
  "CHLAM",
  "LEGI",
  "HAEM",
  "STAPH",
  "S_PYOG",
  "KLEB",
  "PERT"
)

BrS_test_object <- make_meas_object(
  patho = c(
    "INFLU_A",
    "INFLU_B",
    "PARA_1",
    "PARA_2",
    "PARA_3",
    "RSV",
    "HUMET",
    "ENTRHI",
    "ADENO",
    "CORONA",
    "BOCA",
    "S_PNEU",
    "M_PNEU",
    "CHLAM",
    "LEGI",
    "HAEM",
    "STAPH",
    "S_PYOG",
    "KLEB",
    "PERT"
  ),
  specimen = "PCR",
  test = "1",
  quality = "BrS",
  cause_list = cause_list
)

SS_test_object <- make_meas_object(
  patho = c(
    "S_PNEU",
    "M_PNEU",
    "CHLAM",
    "LEGI",
    "HAEM",
    "STAPH",
    "S_PYOG",
    "KLEB",
    "PERT"
  ),
  specimen = "CX",
  test = "1",
  quality = "SS",
  cause_list = cause_list
)

tests_clean <- list(BrS_objects = list(BrS_test_object),
                    SS_objects = list(SS_test_object))

BrS_test_object

