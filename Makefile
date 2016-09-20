.PHONY: help
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z0-9\./\_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

GoM_cod_2014_update_20140822.pdf:
	wget http://www.nefsc.noaa.gov/saw/cod/pdfs/GoM_cod_2014_update_20140822.pdf

pdftools: GoM_cod_2014_update_20140822.pdf ## pdftools
	Rscript pdftools.R $(PAGE)
	@echo 'data extracted!'
	
tesseract: GoM_cod_2014_update_20140822.pdf ## tesseract
	Rscript tesseract.R $(PAGE)
	@echo 'data extracted!'

test: 
	Rscript test.R $(PAGE)
