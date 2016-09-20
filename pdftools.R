args <- commandArgs(trailingOnly = TRUE)
library(pdftools)

get_cod_table <- function(pdf, page, nr){
  pdf_subset_name <- paste0("gom_cod_2014_p", page)
  system(paste0("pdftk ", pdf, " cat ", page ," output ", pdf_subset_name, ".pdf"))
  
  res <- pdftools::pdf_text(paste0(pdf_subset_name, ".pdf"))
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

get_cod_table("gom_cod_2014.pdf", args[1], 35)
