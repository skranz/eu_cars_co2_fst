# Code used to copy and possible split the large fst files
# to Github repository

dest.dir = "../eu_cars_co2_fst"
files = list.files(".", glob2rx("cars20*.fst"))
mb = file.size(files) / 1000000

i = 7
for (i in seq_along(files)) {
  num.chunks = floor(mb[i]/95)+1
  file = files[i]
  if (num.chunks == 1) {
    dest.file = paste0(dest.dir,"/", file)
    if (file.exists(dest.file)) next
    cat("\ncopy ", file, "to",dest.file)
    file.copy(file, dest.file)
  } else {
    dest.files = sapply(1:num.chunks, function(part) {
      paste0(dest.dir,"/", gsub(".",paste0("_",part,"."),file, fixed=TRUE))
    })

    if (all(file.exists(dest.files))) next
    
    
    dat = fst::read_fst(file)
    n = nrow(dat)
    chunk.size = round(n / num.chunks)
    inds = c(1,rep(chunk.size,times=num.chunks))
    inds = cumsum(inds)
    inds[length(inds)] = n
    diff(inds)
    
    for (part in 1:num.chunks) {
      rows = inds[part]:inds[part+1]
      d = dat[rows,]
      fst::write_fst(d, dest.files[part],compress = 100)
    }
  }
    
}
