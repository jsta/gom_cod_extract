library(pdftools)

download.file("http://www.nefsc.noaa.gov/saw/cod/pdfs/GoM_cod_2014_update_20140822.pdf", "gom_cod_2014.pdf")

get_cod_table <- function(pdf, page, nr){
  pdf_subset_name <- paste0("gom_cod_2014_p", page)
  system(paste0("pdftk ", pdf, " cat ", page ," output ", pdf_subset_name, ".pdf"))

  res <- pdftools::pdf_text(pdf_subset_name)
  res <- unlist(strsplit(res, "\n"))
  res <- lapply(res, function(x) strsplit(trimws(paste0(x, collapse = " ")), " "))
  res <- unlist(res, recursive = FALSE)[2:nr]
  res <- lapply(res, function(x) x[nchar(x) > 0])
  
  res_names <- unlist(res[1])
  res <- res[2:length(res)]
  nr <- length(res[[2]])
  res <- data.frame(t(matrix(unlist(res), nrow = nr)))
  names(res) <- res_names
  res
}

get_cod_table("gom_cod_2014.pdf", 33, 35)
get_cod_table("gom_cod_2014.pdf", 23, 34)

tesseract_cod_table <- function(pdf, page, nr){
  # See https://gist.github.com/benmarwick/11333467 for dependency list

  pdf_subset_name <- paste0("gom_cod_2014_p", page)
  # system(paste0("pdftk ", pdf, " cat ", page ," output ", pdf_subset_name, ".pdf"))
  # 
  # system(paste0("pdftoppm ", pdf_subset_name, ".pdf", " -r 600 ocrbook"))
  # system(paste0("convert *.ppm ", pdf_subset_name, ".tif"))
  # system(paste0("tesseract ", pdf_subset_name, ".tif ", pdf_subset_name, " -l eng"))
  browser()
  
  res <- readLines(paste0(pdf_subset_name, ".txt"))
  res_title <- res[1]
  res <- res[3:length(res)]
  res <- strsplit(" ", res)
  res[is.na(as.numeric(res))]
  
    read.table(paste0(pdf_subset_name, ".txt"), skip = 3, nrows = nr, header = FALSE)
  read.table(paste0(pdf_subset_name, ".txt"), skip = 3 + nr, nrows = nr, header = FALSE)
  
}

tesseract_cod_table("gom_cod_2014.pdf", 23, 32)
