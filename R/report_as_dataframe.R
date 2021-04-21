#'report_as_dataframe
#'
#'Function to transform a list of NCBI Virus Report metadata into a table.
#'
#'@usage report_as_dataframe(report, records = c(1:length(report)))
#'
#'@param report a list derived a vaccine report from NCBI Datasets.
#'
#'@param records a vector of indices to pull from the report.
#'
#'@returns A large dataframe with 23 variables containig metadata from NCBI Virus
#'  report.
#'
#'@export report_as_dataframe

#Function to create a vector of elements from the report
#   'records' takes a vector of indices to parse from report
report_as_dataframe <- function(report, records = c(1:length(report))) {
  #Read in .jsonl of data report
  #filepath <- "../covid19_data/data_report.jsonl"
  #report <- readLines(filepath)
  #report <- lapply(report, rjson::fromJSON)
  #records = c(1:length(report))

  #get selected records
  selected_records <- report[records]

  #Empty data frame for holding selected records
  report_df <- data.frame()

  #Variables to keep track of progress
  counter <- 1
  report_length <- length(report)

  cat("There are", report_length, "records in given report.\n")
  cat(length(selected_records), "records have been selected.\n")
  cat("\nConverting report from list to data frame...\n")

  for(record in selected_records) {
    #Progress report for very large data sets
    prcnt_prgrs <- (counter / length(selected_records)) * 100
    cat(sprintf("Progress: %.2f%% \r", prcnt_prgrs))

    # Create vector of values ##################################################
    #Description of the schema can be found here:
    # https://www.ncbi.nlm.nih.gov/datasets/docs/reference-docs/data-reports/virus/#ncbi-datasets-v1alpha1-reports-VirusAssembly
    accession <- pass_value(record$accession)
    completeness <- pass_value(record$completeness)
    geneCount <- pass_value(record$geneCount)
    isAnnotated <- pass_value(record$isAnnotated)
    isolate_collectionDate <- pass_value(record$isolate$collectionDate)
    isolate_name <- pass_value(record$isolate$name)
    isolate_source <- pass_value(record$isolate$source)
    length <- pass_value(record$length)
    bioProjects <- pass_value(record$bioprojects)
    geo_Location <- pass_value(record$location$geographicLocation)
    geo_Region <- pass_value(record$location$geographicRegion)
    maturePeptideCount <- pass_value(record$maturePeptideCount)
    molType <- pass_value(record$molType)
    nucleotide_accessionVersion <- pass_value(record$nucleotide$accessionVersion)
    nucleotide_seqID <- pass_value(record$nucleotide$seqId)
    nucleotide_sequenceHash <- pass_value(record$nucleotide$sequenceHash)
    nucleotide_title <- pass_value(record$nucleotide$title)
    nucleotideCompleteness <- pass_value(record$nucleotideCompleteness)
    proteinCount <- pass_value(record$proteinCount)
    releaseDate <- pass_value(record$releaseDate)
    sourceDatabase <- pass_value(record$sourceDatabase)
    updateDate <- pass_value(record$updateDate)
    virus_sciName <- pass_value(record$virus$sciName)
    virus_taxID <- pass_value(record$virus$taxId)

    record_v <- c(accession, completeness, geneCount, isAnnotated, isolate_collectionDate,
                  isolate_name, isolate_source, length, geo_Location, geo_Region,
                  maturePeptideCount, molType, nucleotide_accessionVersion, nucleotide_seqID,
                  nucleotide_sequenceHash, nucleotide_title, nucleotideCompleteness,
                  proteinCount, releaseDate, sourceDatabase, updateDate, virus_sciName,
                  virus_taxID)

    # Combine into Data Frame ##################################################
    report_df <- rbind(report_df, record_v)

    #Handle increments
    counter <- counter + 1
  }

  #Set names of columns for access
  colnames(report_df) <- c("accession", "completeness", "geneCount", "isAnnotated",
                           "isolate_collectionDate", "isolate_name", "isolate_source",
                           "length", "geo_Location", "geo_Region", "maturePeptideCount",
                           "molType", "nucleotide_accessionVersion", "nucleotide_seqID",
                           "nucleotide_sequenceHash", "nucleotide_title", "nucleotideCompleteness",
                           "proteinCount", "releaseDate", "sourceDatabase", "updateDate",
                           "virus_sciName", "virus_taxID")

  #Convert specified columns from char to usable data type
  report_df$completeness <- as.factor(report_df$completeness)
  report_df$geneCount <- as.numeric(report_df$geneCount)
  report_df$isolate_collectionDate <- as.Date(report_df$isolate_collectionDate,
                                              format = "%Y-%m-%d")
  report_df$isolate_source <- as.factor(report_df$isolate_source)
  report_df$length <- as.numeric(report_df$length)
  report_df$maturePeptideCount <- as.numeric(report_df$maturePeptideCount)
  report_df$nucleotideCompleteness <- as.factor(report_df$nucleotideCompleteness)
  report_df$releaseDate <- as.Date(report_df$releaseDate, format = "%Y-%m-%d")
  report_df$updateDate <- as.Date(report_df$updateDate, format = "%Y-%m-%d")

  #Finish message
  cat("\nFinished converting report from list to data frame\n")

  return(report_df)
}
#END of report_as_dataframe()

#Helper function, forces NA values to be passed into Dataframe for missing values
pass_value <- function(x) {
  if(is.null(x)) {
    return(NA)
  } else {
    return(x)
  }
}
#END of pass_value
