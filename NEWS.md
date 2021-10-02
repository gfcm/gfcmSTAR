# gfcmSTAR 2.2.0 (2021-09-05)

* Added function diff.stars() and identical.stars() to compare STAR
  templates/objects.

* Added function append.id() to modify the Assessment_ID of an existing STAR
  object.

* Added functions qc.colnames() and qc.numbers() to check if time series column
  names are intact and that time series are numbers and not strings.

* Added arguments 'short', 'qc', and 'quiet' to import.many.templates().

* Added argument 'short' to qc.exists(), qc.star(), qc.vpa(), and qc.xlsx().

* Improved import.many.templates() to show current filename while processing a
  directory.

* Improved peek() to handle files and directories, in addition to STAR objects
  and clusters. The default value of 'field' is now "Assessment_ID".

* Improved read.template() to support edge cases where Excel STAR templates
  contain time series as text instead of numbers.

---

# gfcmSTAR 2.1.0 (2021-07-26)

* Added support to read STAR templates version 2.1.

* Improved read.template() to support edge cases where Excel STAR templates
  contain metadata table objects that have expanded beyond their original size.

---

# gfcmSTAR 2.0.1 (2021-06-09)

* Improved qc() so it can handle a single Excel STAR template file or a
  directory containing Excel STAR templates.

* Added a generic import_export.R template inside the 'scripts' folder, to
  semi-automate the STAR import and export procedure to generate CSV files for
  the STAR database.

---

# gfcmSTAR 2.0.0 (2021-05-08)

* Added function export.many.csv() to export many STAR objects to CSV files.

* Added function peek() to examine a metadata field of STAR objects.

* Improved read.template() to support older versions of R.

* Removed Metadata field Assessment in read.template() and set.classes().

* Changed Metadata field Assessment_ID from UUID to a combination of reference
  year, species, GSA, and an optional suffix in read.template().

* Removed 'uuid' package dependency.

---

# gfcmSTAR 1.1.0 (2021-05-05)

* Added function import.many.csv() to import many CSV files from a directory
  tree.

* Added function read.star.csv() to read a pair of CSV files into a STAR object.

* Added function set.classes() to convert Metadata and TimeSeries data types.

* Renamed import.dir() to import.many.templates().

* Renamed write.star() to write.star.csv().

* Renamed Metadata field Rec_Unit to Recruitment_Unit in read.template().

* Converted TimeSeries column names to Start_Case in read.template().

* Changed write.star.csv() so it returns TRUE or FALSE.

* Removed TimeSeries columns containing Effort in read.template(). In the STAR
  database, Effort is handled as a special case of Fishing where
  Exploitation_Unit = Effort.

---

# gfcmSTAR 1.0.1 (2021-05-04)

* Added argument 'pattern' in import.many.templates().

* Added argument 'prop' in read.template().

* Added argument 'force' in write.star().

* Added Metadata fields SharePoint_Folder, Person_Modified, Time_Modified, and
  Time_Imported in read.template().

* Added export.Rmd vignette on exporting a list of STAR objects to CSV files.

---

# gfcmSTAR 1.0.0 (2021-04-30)

* Initial release, with functions to import STAR template version 1.0 and a
  vignette import.Rmd.
