#' @title Appveyor API HTTP Requests
#' @description This is the workhorse function for executing API requests for Appveyor.
#' @details This is mostly an internal function for executing API requests. In almost all cases, users do not need to access this directly.
#' @param verb A character string containing an HTTP verb, defaulting to \dQuote{GET}.
#' @param path A character string with the API endpoint (should begin with a slash).
#' @param query A list specifying any query string arguments to pass to the API.
#' @param body A character string of request body data.
#' @param base A character string specifying the base URL for the API.
#' @param token A character string containing a Travis-CI API token. If missing, defaults to value stored in environment variable \dQuote{APPVEYOR_TOKEN}.
#' @param ... Additional arguments passed to an HTTP request function, such as \code{\link[httr]{GET}}.
#' @return A list.
#' @export
appveyorHTTP <- 
function(verb = "GET",
         path = "", 
         query = list(),
         body = "",
         token = Sys.getenv("APPVEYOR_TOKEN"),
         ...) {
    url <- paste0("https://ci.appveyor.com/api", path)
    h <- httr::add_headers("Authorization" = paste("Bearer", token))
    if (!length(query)) query <- NULL
    if (verb == "GET") {
      r <- httr::GET(url, query = query, h, ...)
    } else if (verb == "DELETE") {
      r <- httr::DELETE(url, query = query, h, ...)
      s <- httr::http_status(r)
      if (s$category == "success") {
          return(TRUE)
      } else {
          message(s$message)
          return(FALSE)
      }
    } else if (verb == "POST") {
      if(body == "") {
        r <- httr::PUT(url, query = query, h, ...)
      } else {
        r <- httr::PUT(url, body = body, query = query, h, ...)
      }
    }
    return(httr::content(r, "parsed"))
}
