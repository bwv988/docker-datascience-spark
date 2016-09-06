# Install frequently used R packages.
# FIXME: All packages that require Rcpp are currently broken because Rcpp won't compile.

# Note: Have to put in this temp. workaround for R 3.1 because libcurl will fail.
options(download.file.method = "curl")

# Set the CRAN mirror.
options(repos=structure(c(CRAN="http://ftp.heanet.ie/mirrors/cran.r-project.org/")))

# First we'll install devtools.
install.packages("devtools")
require(devtools);

# Install SparkR
## FIXME: Need to turn off SSL...I don't like this.
install.packages("RCurl")
library(RCurl)
library(httr)
set_config( config( ssl_verifypeer = 0L ) )
install_github('apache/spark@v2.0.0', subdir='R/pkg')

install.packages("knitr")
install.packages("glmnet")
install.packages("data.table")

#install.packages("ggplot2")
#install.packages("caret")
#install.packages("sqldf")
#install.packages("wordcloud")
#install.packages(c('mplot', 'googleVis'));
#install_github('ramnathv/rCharts')
