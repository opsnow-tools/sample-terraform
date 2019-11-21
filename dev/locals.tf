# locals.tf

## locals
locals {
  // Name
  city       = "seoul"
  stage      = "felix"
  name       = "${local.stage}-sample-tf"
  upper_name = upper(local.name)
  lower_name = lower(local.name)
  full_name  = "${local.city}-${local.name}"
  upper_full_name = upper(local.full_name)
}
