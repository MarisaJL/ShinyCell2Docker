# ARG 

FROM bioconductor/bioconductor_docker:RELEASE_3_19

ENV SHINY_INPUT_DIR="/shiny_input"
ENV SHINY_OUTPUT_DIR="/shiny_output"

# install Bioc
RUN Rscript -e "options(repos = c(CRAN = 'https://cran.r-project.org')); install.packages('BiocManager')" && \
    Rscript -e "BiocManager::install(ask=FALSE)" && \
    # install required packages
    Rscript -e "install.packages('data.table')" && \
    Rscript -e "install.packages('Matrix')" && \
    Rscript -e "install.packages('hdf5r')" && \
    Rscript -e "install.packages('reticulate')" && \
    Rscript -e "install.packages('R.utils')" && \
    Rscript -e "install.packages('ggplot2')" && \
    Rscript -e "install.packages('gridExtra')" && \
    Rscript -e "install.packages('glue')" && \
    Rscript -e "install.packages('readr')" && \
    Rscript -e "install.packages('future')" && \
    Rscript -e "install.packages('RColorBrewer')" && \
    Rscript -e "install.packages('Seurat')" && \
    Rscript -e "install.packages('Signac')" && \
    Rscript -e "devtools::install_github("GreenleafLab/ArchR")" && \
    Rscript -e "reticulate::py_install('anndata')" && \
    # install the package itself
    Rscript -e "devtools::install_github('the-ouyang-lab/ShinyCell2')"

USER root

RUN mkdir -p /shiny_input /shiny_output
RUN chown rstudio:rstudio /shiny_input /shiny_output
USER rstudio

ADD app_setup.R /app_setup.R

EXPOSE 3838
CMD Rscript /app_setup.R
