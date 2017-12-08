### Author: Adam Dziorny
### Date: 9/21/2017
### Description: Script to set up two functions to connect to RODBC / CDW
### Requirements:
###    - R: RODBC package, TCL/TK

library(RODBC)
library(tcltk)

# Returns the password specified by the KEY, decoded from
# base64 encoding and stored in the specified file
getPassword <- function(key, file = '.passwd')
{
  pairs <- read.csv(file, header = TRUE, sep = ',', stringsAsFactors = FALSE)

  return(rawToChar(base64enc::base64decode(pairs[pairs$KEY == key, 2])))
}

# Function to make ODBC connection using generic Windows ODBC Driver
makeConn <- function(user, pwd, server, db) {
  odbcDriverConnect(
    paste0(
      "Driver=NetezzaSQL",
      ";Database=", db,
      ";Servername=", server,
      ";UID=", user,
      ";PWD=", pwd,
      ";SchemaName=",
      ";Port=5480",
      ";ReadOnly=0",
      ";SQLBitOneZero=0",
      ";LegacySQLTables=0",
      ";NumericAsChar=0",
      ";ShowSystemTables=0",
      ";LoginTimeout=0",
      ";QueryTimeout=0",
      ";DateFormat=1",
      ";SecurityLevel=preferredUnSecured",
      ";CaCertFile="
    ),
    believeNRows = F
  )
}

# Creates a TCL window to capture user and password, to make the
# ODBC connection. Accepts optional server / database parameters,
# which are already specified.
makeConnTCL <- function (server="binbiaclv2.chop.edu",database="CDWPRD") {
  require(tcltk)
  
  user <- tclVar()
  pwd <- tclVar()
  tt <- tktoplevel()
  tkpack(tklabel(tt,text='Username'),
         ttkentry(tt,textvariable=user),
         tklabel(tt,text='Password'),
         ttkentry(tt,textvariable=pwd,show='*'),
         ttkbutton(tt,text='Connect',command=function() tkdestroy(tt)))
  tkwait.window(tt)
  
  if (user=='' | pwd=='') {
    stop()
  } else {
    return(makeConn(tclvalue(user),tclvalue(pwd),server,database))
  }
}

# Loads an SQL File as a text element, and applies appropriate concatenation
# with the newline character.  
getDataFromFile <- function (srcFile, conn) {
  sqlFile <- readLines(srcFile)
  
  sqlCmd <- paste(sqlFile, sep="\n", collapse="\n")
  
  sqlData <- sqlQuery(conn,sqlCmd)
  
  return(sqlData)
}

# Make the connection by calling the function above
# conn <- myNZConn()