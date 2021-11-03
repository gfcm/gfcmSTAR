## This script imports all Excel STAR templates from a specific stock assessment
## event (stock assessment working group, benchmark workshop, or the like) and
## year.
##
## For example, if event is "WGSASP_General" and year is 2021, then this script
## will look for Excel STAR templates inside
##   ~/StockAssessmentResults/uploads/2021/WGSASP_General
## and Excel file with SharePoint properties
##   ~/StockAssessmentResults/uploads/2021/properties/WGSASP_General.xlsx
##
## The stock assessment results are then exported to CSV files inside
##   /mnt/star-templates/2021/WGSASP_General
##
## The purpose of this script is to semi-automate the STAR import and export
## procedure to generate CSV files for the STAR database. Two steps require a
## human review and possible intervention:
##
## 1. If any errors were raised while reading in Excel STAR templates, these may
##    require intervention to manually edit and correct Excel templates,
##    possibly by contacting the stock assessor. See cbind(sapply(cluster,
##    class)) below, and the qc(directory) functionality can be helpful to
##    examine errors.
##
## 2. If any duplicated Assessment_ID are encountered, then two or more Excel
##    STAR templates have results for the same stock (year, species, gsa). If
##    the results from both Excel STAR templates should be imported into the
##    database, then these should be imported using read.template(...,
##    suffix="this") and read.template(..., suffix="that") functionality. See
##    any(duplicated(id)) below, and the help page for read.template.

event <- "WGSASP_General"
year <- 2021

## Load package and specify directories

library(gfcmSTAR)
uploads <- file.path("~/StockAssessmentResults/uploads", year)
star.dir <- file.path(uploads, event)
prop.file <- file.path(uploads, "properties", paste0(event, ".xlsx"))

## Read SharePoint properties

prop <- read.properties(prop.file)

## Import STAR templates

cluster <- import.many.templates(star.dir, prop=prop)
cluster <- import.many.templates(star.dir, prop=prop, qc=TRUE)
cbind(sapply(cluster, class))
errors <- sapply(cluster, class)
cbind(errors[errors=="try-error"])
qc.vector <- qc(star.dir, quiet=TRUE)

## Exclude STAR templates that have errors

cluster.ok <- cluster[sapply(cluster, class) != "try-error"]
cbind(sapply(cluster.ok, class))

## Check that the Assessment_ID fields are unique

id <- peek(cluster.ok)
cbind(id)
if(any(duplicated(id)))
  id[duplicated(id)]

################################################################################
## Actions specific to this script

## Remove star_template, draft version of STAR_PIL_17_18

cluster.ok$"star_template.xlsx" <- NULL

## Remove STAR_PIL_17_18.xlsx, strings prevent calculation of stock status

cluster.ok$"STAR_PIL_17_18.xlsx" <- NULL

## Give two analyses of STAR_2019_ANE_6 distinct names

s1 <- cluster.ok$"star_ANE_GSA06 ref2019_model1.xlsx"
s2 <- cluster.ok$"star_ANE_GSA06 ref2019_model2.xlsx"
diff.stars(s1, s2)
cluster.ok$"star_ANE_GSA06 ref2019_model1.xlsx" <- append.id(s1, "a4a_spict")
cluster.ok$"star_ANE_GSA06 ref2019_model2.xlsx" <- append.id(s2, "a4a")

################################################################################

## Overall summary

report(cluster, cluster.ok, qc.vector)

## Export into subdirectories inside /mnt/star-templates

topdir <- file.path("/mnt/star-templates", year, event)
export.many.csv(cluster.ok, topdir=topdir, force=TRUE)
