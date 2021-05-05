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
