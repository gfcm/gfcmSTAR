## This script imports all Excel STAR templates from a specific stock assessment
## event (stock assessment working group, benchmark workshop, or the like) and
## year.
##
## For example, if event is "WGSAD_Western_Mediterranean" and year is 2021, then
## this script will look for
## Excel STAR templates inside
##   ~/StockAssessmentResults/uploads/2021/WGSAD_Western_Mediterranean
## and Excel file with SharePoint properties
##   ~/StockAssessmentResults/uploads/2021/properties/WGSAD_Western_Mediterranean.xlsx
##
## The stock assessment results are then exported to CSV files inside
##   /mnt/star-templates/2021/WGSAD_Western_Mediterranean
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

event <- "WGSAD_Western_Mediterranean"
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
cbind(sapply(cluster, class))

## Exclude STAR templates that have errors

cluster.ok <- cluster[sapply(cluster, class) != "try-error"]
cbind(sapply(cluster.ok, class))

## Check that the Assessment_ID fields are unique

id <- peek(cluster.ok, "Assessment_ID")
cbind(id)
any(duplicated(id))

## Export into subdirectories inside the /mnt/star-templates area

topdir <- file.path("/mnt/star-templates", year, event)
export.many.csv(cluster.ok, topdir=topdir, force=TRUE)
