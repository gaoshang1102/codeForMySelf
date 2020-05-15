dat <- import(con = "Downloads/GSM3325412_12_P4_Sox17_s7.bigWig", format = "bigWig")
head(dat)

df <- data.frame(chr = as.character(seqnames(dat)),
                 start = start(dat),
                 end = end(dat),
                 strand = as.character(strand(dat)), 
                 score = score(dat),
                 stringsAsFactors = F)

startSite <- 8394823
endSite <- 8397823
chrome <- "chr1"

startSeg <- which(df$chr == chrome & df$start <= startSite & df$end >= startSite)
endSeg <- which(df$chr == chrome & df$start <= endSite & df$end >= endSite)
subbigwig <- df[startSeg:endSeg, ]
flattenBigWig <- rep(0, subbigwig$end[length(subbigwig$end)] - subbigwig$start[1] + 1)
names(flattenBigWig) <- c(subbigwig$start[1] : subbigwig$end[length(subbigwig$end)])
for(i in 1:nrow(subbigwig)){
  flattenBigWig[as.character(c(subbigwig$start[i]:subbigwig$end[i]))] <- subbigwig$score[i]
}

chipseqSignal <- flattenBigWig[as.character(c(startSite:endSite))]



