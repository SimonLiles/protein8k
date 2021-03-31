#'read.pdb
#'
#'@description Read in a Protein Data Bank file
#'
#'@usage read.pdb(fileName, createAsS4 = TRUE)
#'
#'@param fileName character string for location and name of file to be read.
#'
#'@param createAsS4 Logical indicating whether to create the new protein object
#'  as S4 or not. Defaults to TRUE if not specified. This argument is optional.
#'
#'@details Reads a Protein Data Bank file (PDB) from the given location. The
#'  function then parses the file and creates a new object of the Protein class.
#'  This object can be either defined as an S3 or S4 object if different
#'  capabilities are required.
#'
#'@returns A new protein object as either an S3 or S4 object.
#'
#'@returns In general terms, the new object will be a list of two, a data frame
#'  containing the atomic record, and a list of header elements.
#'
#'@export read.pdb
#'@import methods

# Read a raw pdb file into a protein class representation
#TODO: Add more fault checking.
read.pdb <- function(fileName, createAsS4 = TRUE) {
  #Read file, seperate by line
  #fileName = "1aieH" #Only for development purposes
  file <- scan(file = fileName, what = "character", sep = "\n")

  #TODO: Ensure read file matches PDB format, if not throw error

  # Cleaning the PDB file
  # What data do we want to grab?
  #   Header contains unstructured meta data
  #   Body of data contains atom type and position data

  # Seperate the header and body ###############################################
  # Find first index of each tag in file body
  #bodyTagFirstIndices <- c(which(startsWith(file, "ATOM"))[1],
  #                         which(startsWith(file, "TER"))[1],
  #                         which(startsWith(file, "HETATM"))[1])

  #Find the first index among all tags
  #beginBodyIndex <- min(bodyTagFirstIndices)

  #Find END tag
  #endTag <- which(startsWith(file, "END"))

  #Grab each section of the file for individual parsing
  #File Body
  #coord_sec <- file[beginBodyIndex:(endTag - 1)] #Commented out to test below

  #Pull just records for the Title Section
  title_sec <- file[c(which(startsWith(file, "HEADER")),
                      which(startsWith(file, "OBSLTE")),
                      which(startsWith(file, "TITLE ")),
                      which(startsWith(file, "SPLIT")),
                      which(startsWith(file, "CAVEAT")),
                      which(startsWith(file, "COMPND")),
                      which(startsWith(file, "SOURCE")),
                      which(startsWith(file, "KEYWDS")),
                      which(startsWith(file, "EXPDTA")),
                      which(startsWith(file, "NUMMDL")),
                      which(startsWith(file, "MDLTYP")),
                      which(startsWith(file, "AUTHOR")),
                      which(startsWith(file, "REVDAT")),
                      which(startsWith(file, "SPRSDE")),
                      which(startsWith(file, "REMARK")))]

  #Pull just those records that contain Coordinate Section records
  coord_sec <- file[c(which(startsWith(file, "ATOM  ")),
                      which(startsWith(file, "HETATM")),
                      which(startsWith(file, "ANISOU")),
                      which(startsWith(file, "TER   ")))]

  # Parse each part of the file ################################################
  # Parse File Header
  pdb_header <- pdb.parseHeader(title_sec)

  # Parse file body
  protein_structure <- pdb.parseCoordinates(coord_sec)

  # Return all associated pieces as single new protein object

  if(createAsS4 == TRUE) {
    #S4 object creation
    protein <- new("Protein", header = pdb_header,
                   structure = protein_structure)
  } else {
    #S3 object creation
    protein <- Protein(pdb_header, protein_structure)
  }

  return(protein)
}

#Parsing functions #############################################################

# Creates a new data frame representing molecule sequence, position, and names,
#   along with other necessary data.
# TODO: Add documentation regarding columns and return data
pdb.parseCoordinates <- function(fileBody) {
  # This block works for ATOM, HETATM, and TER. TER does not break the code, but
  #   does introduce NA's in most columns since it does not fill all fields
  #Subset for each column, convert to correct type if necessary
  record_type <- substr(fileBody, 1, 6)

  #Parse ATOM and HETATM Records like so
  if(record_type == "ATOM  " || record_type == "HETATM") {
    serial_num <- as.integer(substr(fileBody, 7, 11))
    atom_name <- substr(fileBody, 13, 16)
    alt_location_id <- substr(fileBody, 17, 17)
    residue_name <- substr(fileBody, 18, 20)
    chain_id <- substr(fileBody, 22, 22)
    residue_seq_num <- as.integer(substr(fileBody, 23, 26))
    insert_residue_code <- substr(fileBody, 27, 27)
    x_ortho_coord <- as.numeric(substr(fileBody, 31, 38))
    y_ortho_coord <- as.numeric(substr(fileBody, 39, 46))
    z_ortho_coord <- as.numeric(substr(fileBody, 47, 54))
    occupancy <- as.numeric(substr(fileBody, 55, 60))
    temp_factor <- as.numeric(substr(fileBody, 61, 66))
    segment_id <- substr(fileBody, 73, 76)
    element_symbol <- substr(fileBody, 77, 78)
    charge <- as.factor(substr(fileBody, 79, 80))

    protein_structure <- data.frame(record_type, serial_num, atom_name, residue_name,
                                    alt_location_id, chain_id, residue_seq_num,
                                    insert_residue_code, x_ortho_coord, y_ortho_coord,
                                    z_ortho_coord, occupancy, temp_factor, segment_id,
                                    element_symbol)
  }

  #Parse ANISOU records separately
  if(record_type == "ANISOU") {
    serial_num <- as.integer(substr(fileBody, 7, 11))
    atom_name <- substr(fileBody, 13, 16)
    alt_location_id <- substr(fileBody, 17, 17)
    residue_name <- substr(fileBody, 18, 20)
    chain_id <- substr(fileBody, 22, 22)
    residue_seq_num <- as.integer(substr(fileBody, 23, 26))
    insert_residue_code <- substr(fileBody, 27, 27)
    U1_1 <- as.numeric(substr(fileBody, 29, 35))
    U2_2 <- as.numeric(substr(fileBody, 36, 42))
    U3_3 <- as.numeric(substr(fileBody, 43, 49))
    U1_2 <- as.numeric(substr(fileBody, 50, 56))
    U1_3 <- as.numeric(substr(fileBody, 57, 63))
    U2_3 <- as.numeric(substr(fileBody, 64, 70))
    element_symbol <- substr(fileBody, 77, 78)
    charge <- as.factor(substr(fileBody, 79, 80))

    anisou_temp_factors <- data.frame(record_type, serial_num, atom_name,
                                      alt_location_id, residue_name, chain_id,
                                      residue_seq_num, insert_residue_code, U1_1,
                                      U2_2, U3_3, U1_2, U1_3, U2_3, element_symbol,
                                      charge)

    #Join the coordinate data with ANISOU Records
    dplyr::left_join(protein_structure, anisou_temp_factors, by = serial_num)
  }

  attr(protein_structure, "Protein_Structure")

  return(protein_structure)
}

# TODO: Fill with code
# Separate file header into parts and store as list maybe?
pdb.parseHeader <- function(fileHeader) {
  #Header Line #################################################################
  header_line_raw <- fileHeader[which(startsWith(fileHeader, "HEADER"))]
  #Separate header line components
  #   classification field
  classification_hdr <- substr(header_line_raw, 11, 50)
  #   Deposition date
  date_hdr_string <- substr(header_line_raw, 51, 59)
  date_hdr <- as.Date(date_hdr_string, "%d-%b-%y") #Format is dd-MMM-yy
  #   ID Code
  id_code <- substr(header_line_raw, 63, 66)
  # Combine header line as list
  header_line <- list(classification_hdr, date_hdr, id_code)
  names(header_line) <- c("classification", "depDate", "idCode")

  #OBSLTE RECORDS ##############################################################
  # TODO: Need to complete
  #TITLE Records ###############################################################
  title <- substr(fileHeader[which(startsWith(fileHeader, "TITLE"))], 11, 80)
  title <- gsub("\n", "", title)

  #SPLIT Records ###############################################################
  #TODO: Need to complete

  #CAVEAT Records ##############################################################
  #TODO: Need to complete

  #COMPND Records ##############################################################
  #TODO: Need to complete

  #SOURCE Records ##############################################################
  #TODO: Need to complete

  #KEYWDS Records ##############################################################
  #TODO: Need to complete

  #EXPDTA Records ##############################################################
  #TODO: Need to complete

  #NUMMDL Records ##############################################################
  #TODO: Need to complete

  #MDLTYP Records ##############################################################
  #TODO: Need to complete

  #AUTHOR Records ##############################################################
  #TODO: Need to complete

  #REVDAT Records ##############################################################
  #TODO: Need to complete

  #SPRSDE Records ##############################################################
  #TODO: Need to complete

  #JRNL Records ################################################################
  #TODO: Need to complete

  #REMARK Records ##############################################################
  #TODO: Need to complete


  #Create the list of header components ########################################
  header <- list(header_line, title)
  names(header) <- c("header_line", "title")

  return(header)
}
