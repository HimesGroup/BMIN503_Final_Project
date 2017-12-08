library(RCurl)
library(XML)

# ACD Profile is E7582503
pageMe <- function (profileID = NULL, lookupName = NULL, msg = NULL,
                    baseURL = 'http://directory.chop.edu/XtendDataService/XtendDataService.asmx/',
                    displayResult = FALSE) {
  
  # If we don't have a profile ID, look one up
  if (is.null(profileID)) {
    
    # If we aren't given a name, ask!
    if (is.null(lookupName)) {
      lookupName <- readline('Enter a search name: ')
    }
    
    resultsXML <- getURL(url=paste0(baseURL, 'LookupByName'), 
                         post=1, 
                         postfields=paste0('Name=',lookupName,'&MaxItems=999'))
    
    resultsList <- xmlToList(resultsXML)
    
    for (i in 1 : resultsList$NumberOfItems) {
      cat(sprintf("(%d) Name: %s %s\tProfileID: %s\n", i,
                  resultsList$pia[i]$PageInfoPlus$FirstName,
                  resultsList$pia[i]$PageInfoPlus$Name,
                  resultsList$pia[i]$PageInfoPlus$ProfileId))
    }
    
    lineNum <- readline('Enter line number to page (-1 to Quit): ')
    
    if (as.numeric(lineNum) == -1) return();
    
    profileID <- resultsList$pia[as.numeric(lineNum)]$PageInfoPlus$ProfileId    
  }
  
  # If we don't get a message, ask!
  if (is.null(msg)) {
    msg <- readline('Enter message: ')
  }

  resultsXML <- getURL(url=paste0(baseURL, 'RequestSinglePage'), 
                       post=1, 
                       postfields=paste0('ProfileId=',profileID,
                                         '&Message=',URLencode(msg),
                                         '&ProfileIdTomessage=',profileID,
                                         '&SenderLocation=','10.10.10.10',
                                         '&MessagePriority='))
  
  resultsList <- xmlToList(resultsXML)
  
  # Display the results if we are asked
  if (displayResult) {
    cat(sprintf('FunctionStatus: %s\n',resultsList$FunctionStatus))
  }
  
  return(resultsList$FunctionStatus)
}
