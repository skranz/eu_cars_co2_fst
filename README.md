This repositorium contains the EU data sets on all newly registered cars (including their emmission data) in format usable by the R package [fst](https://www.fstpackage.org/).

The original data sets are provided here:

[https://www.eea.europa.eu/data-and-maps/data/co2-cars-emission-16](https://www.eea.europa.eu/data-and-maps/data/co2-cars-emission-16)

I provided this version of the data in fst format because handling the large CSV files that are partially UTF-16 encoded may be daunting on some computers. The file `download_and_convert.R` provides the download and conversion code.

The files for 2018 are split in 5 roughly equal parts because Github imposes a maximum file size of 100 MB.

For 2018 we have the provisional data for earlier years the final data.
