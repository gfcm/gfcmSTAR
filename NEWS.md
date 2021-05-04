# gfcmSTAR 1.0.1 (2021-05-04)

* Added function set.classes().

* Renamed import.dir() to import.many.templates().

* Added argument 'pattern' in import.many.templates().

* Added argument 'prop' in read.template().

* Added argument 'force' in write.star().

* Renamed metadata field Rec_Unit to Recruitment_Unit in read.template().

* Added metadata fields in read.template(): SharePoint_Folder, Person_Modified,
  Time_Modified, Time_Imported.

* Changed write.star() so it returns TRUE or FALSE.

* Added export.Rmd vignette on exporting a list of STAR objects to CSV files.

---

# gfcmSTAR 1.0.0 (2021-04-30)

* Initial release, with functions to import STAR template version 1.0 and a
  vignette import.Rmd.
