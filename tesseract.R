args <- commandArgs(trailingOnly = TRUE)

tesseract_cod_table <- function(pdf, page, nr, nc, na.value){
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
  res[is.na(as.numeric(res))]
  #####
  
  res <- read.table(paste0(pdf_subset_name, ".txt"), skip = 3, nrows = nr, header = FALSE, stringsAsFactors = FALSE)
  column_begin <- nr + 3 + 1
  
  for(i in 1:nc){
    current_res <- rep(NA, nr)
    current_col <- read.table(paste0(pdf_subset_name, ".txt"), skip = column_begin, nrows = nr, header = FALSE, stringsAsFactors = FALSE)[,1]
    current_col <- gsub(",", "", current_col)
    current_col <- gsub("O", "0", current_col)
    char_index <- suppressWarnings(which(is.na(as.numeric(current_col))))
    
    for(j in char_index){
      browser()
      current_col <- current_col[(char_index[1]):(char_index[2] - 1)]
      na_index <- sapply(current_col, function(x) which(all(strsplit(x,
                    NULL)[[1]] == 0)))
      na_index <- which(all(
        lapply(strsplit(current_col, NULL), function(x) print(x))
      lapply(na_index, function(x) x == TRUE)
      
      #column_begin_sub <- 
      
    }
    
    
  current_col[char_index]
   
   
     res <- cbind(res, current_col)
     
   column_begin <- 1
   }
  
  
  
}

# tesseract_cod_table("gom_cod_2014.pdf", 23, 33, 18)
# tesseract_cod_table("gom_cod_2014.pdf", 33, 33, 18, 0)
