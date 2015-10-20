get_user <- function(user, ...) {
    if (!missing(user)) {
        appveyorHTTP("GET", "/users", ...)
    } else {
        appveyorHTTP("GET", paste0("/users/", user), ...)
    }
}

add_user <- function(body, ...) {
    appveyorHTTP("POST", "/users", body = body, encode = "json", ...)
}

update_user <- function(body, ...) {
    appveyorHTTP("PUT", "/users", body = body, encode = "json", ...)
}

delete_user <- function(user, ...) {
    appveyorHTTP("DELETE", paste0("/users/", user), ...)
}


get_collaborator <- function(user, ...) {
    if (!missing(user)) {
        appveyorHTTP("GET", "/collaborators", ...)
    } else {
        appveyorHTTP("GET", paste0("/collaborators/", user), ...)
    }
}

add_collaborator <- function(body, ...) {
    appveyorHTTP("POST", "/collaborators", body = body, encode = "json", ...)
}

update_collaborator <- function(body, ...) {
    appveyorHTTP("PUT", "/collaborators", body = body, encode = "json", ...)
}

delete_collaborator <- function(user, ...) {
    appveyorHTTP("DELETE", paste0("/collaborators/", user), ...)
}




get_role <- function(role, ...) {
    if (missing(role)) {
        appveyorHTTP("GET", "/roles", ...)
    } else {
        appveyorHTTP("GET", paste0("/roles/", role), ...)
    }
}

add_role <- function(name, ...) {
    appveyorHTTP("POST", "/roles", body = list(name = name), encode = "json", ...)
}

update_role <- function(body, ...) {
    appveyorHTTP("PUT", "/roles", body = body, encode = "json", ...)
}

delete_role <- function(role, ...) {
    appveyorHTTP("DELETE", paste0("/roles/", role), ...)
}

