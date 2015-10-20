add_message <- function(message, category, details, ...) {
    b <- list(message = message, category = category, details = details)
    appveyorHTTP("POST", "/build/messages", body = b, encode = "json", ...)
}

add_compliation_message <- function(body, ...) {
    appveyorHTTP("POST", "/build/compilationMessages", body = body, encode = "json", ...)
}

set_envvar <- function(name, value, ...) {
    # secure vars: http://www.appveyor.com/docs/build-configuration#secure-variables
    appveyorHTTP("POST", "/build/variables", 
                 body = list(name = name, value = value), 
                 encode = "json", ...)
}

add_test <- function(test, batch, ...) {
    if (!missing(test)) {
        appveyorHTTP("POST", "/tests", body = test, encode = "json", ...)
    } else if (!missing(batch)) {
        appveyorHTTP("POST", "/tests/batch", body = batch, encode = "json", ...)
    }
}

update_test <- function(test, batch, ...) {
    if (!missing(test)) {
        appveyorHTTP("PUT", "/tests", body = test, encode = "json", ...)
    } else if (!missing(batch)) {
        appveyorHTTP("PUT", "/tests/batch", body = batch, encode = "json", ...)
    }
}

push_artifact <- function(path, filename, name, type, ...) {
    b <- list(path = path, fileName = filename, name = name, type = type)
    appveyorHTTP("PUT", "/artifacts", body = b, encode = "json", ...)
}

update_build <- function(body, ...) {
    appveyorHTTP("PUT", "/artifacts", body = body, encode = "json", ...)
}
