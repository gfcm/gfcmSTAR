gfcmSTAR
========

gfcmSTAR provides tools that support the Stock Assessment Results
([STAR](https://github.com/gfcm/star)) framework of the [General Fisheries
Commission for the Mediterranean](http://www.fao.org/gfcm/en/).

Installation
------------

*Personal installation (e.g. laptop)*

gfcmSTAR can be installed from GitHub using the `install_github` command:

```R
library(remotes)
install_github("gfcm/gfcmSTAR", build_vignettes=TRUE)
```

*Site installation (e.g. GFCM RStudio Server)*

General users on the GFCM RStudio Server do not need to install the package,
since the administrator has already installed the newest version in the site
library.

To install the gfcmSTAR package in the site library, the system administrator
specifies the 2nd library path:

```R
install_github("gfcm/gfcmSTAR", build_vignettes=TRUE, lib=.libPaths()[2])
```

Usage
-----

For a summary of the package:

```R
library(gfcmSTAR)
?gfcmSTAR
```

References
----------

GFCM Stock Assessment Results: https://github.com/gfcm/star

Development
-----------

gfcmSTAR is developed openly on [GitHub](https://github.com/gfcm/gfcmSTAR).

Feel free to open an [issue](https://github.com/gfcm/gfcmSTAR/issues) there if
you encounter problems or have suggestions for future versions.
