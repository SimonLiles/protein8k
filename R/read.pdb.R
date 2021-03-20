#'read.pdb

# Read a raw pdb file into a protein class representation
#TODO: Add more fault checking.
read.pdb <- function(fileName, createAsS4 = FALSE) {
  #Read file, seperate by line
  fileName = "1aieH" #Only for development purposes
  file <- scan(file = fileName, what = "character", sep = "\n")

  #TODO: Ensure read file matches PDB format, if not throw error

  # Cleaning the PDB file
  # What data do we want to grab?
  #   Header contains unstructured meta data
  #   Body of data contains atom type and position data

  # Seperate the header and body ###############################################
  # Find first index of each tag in file body
  bodyTagFirstIndices <- c(which(startsWith(file, "ATOM"))[1],
                           which(startsWith(file, "TER"))[1],
                           which(startsWith(file, "HETATM"))[1])

  #Find the first index among all tags
  beginBodyIndex <- min(bodyTagFirstIndices)

  #Find END tag
  endTag <- which(startsWith(file, "END"))

  #Grab each section of the file for individual parsing
  #File Body
  fileBody <- file[beginBodyIndex:(endTag - 1)]

  #File Header
  fileHeader <- file[1:(beginBodyIndex - 1)]


  # Parse each part of the file ################################################
  # Parse file body
  protein_structure <- pdb.parseBody(fileBody)

  # Parse File Header
  protein_header <- pdb.parseHeader(fileHeader)

  # Return all associated pieces as single new protein object

  if(createAsS4 == TRUE) {
    #S4 object creation
    protein <- new("Protein", structure = protein_structure,
                   header = protein_header)
  } else {
    #S3 object creation
    protein <- Protein(protein_structure, protein_header)
  }

  return(protein)
}

#Parsing functions #############################################################

# Creates a new data frame representing molecule sequence, position, and names,
#   along with other necessary data.
# TODO: Add documentation regarding columns and return data
pdb.parseBody <- function(fileBody) {
  # This block works for ATOM, HETATM, and TER. TER does not break the code, but
  #   does introduce NA's in most columns since it does not fill all fields
  #Subset for each column, convert to correct type if necessary
  record_type <- substr(fileBody, 1, 6)
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

  #Store in dataframe
  protein_structure <- data.frame(record_type, serial_num, atom_name, residue_name,
                                  alt_location_id, chain_id, residue_seq_num,
                                  insert_residue_code, x_ortho_coord, y_ortho_coord,
                                  z_ortho_coord, occupancy, temp_factor, segment_id,
                                  element_symbol)

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
