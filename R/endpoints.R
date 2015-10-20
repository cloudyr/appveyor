get_projects <- function(...) {
    appveyorHTTP("GET", "/projects", ...)
}

get_last_build <- function(project, branch, build, ...) {
    if (!missing(branch)) {
        appveyorHTTP("GET", paste0("/projects/", project, "/branch/", branch), ...)
    } else if (!missing(build)) {
        appveyorHTTP("GET", paste0("/projects/", project, "/build/", build), ...)
    } else {
        appveyorHTTP("GET", paste0("/projects/", project), ...)
    }
}

get_history <- function(project, ...) {
    # add pagination parameters as query args
    appveyorHTTP("GET", paste0("/projects/", project, "/history"), ...)
}

get_deployments <- function(project, ...) {
    appveyorHTTP("GET", paste0("/projects/", project, "/deployments"), ...)
}

get_settings <- function(project, yaml = FALSE, ...) {
    if (yaml) {
        appveyorHTTP("GET", paste0("/projects/", project, "/settings/yaml"), ...)
    } else {
        appveyorHTTP("GET", paste0("/projects/", project, "/settings"), ...)
    }
}



add_project <- function(project, provider = "github", ...) {
    b <- list(repositoryProvider = provider, repositoryName = project)
    appveyorHTTP("POST", "/projects", body = b, encode = "json", ...)
}

update_project <- function(project, provider = "github", body, ...) {
    appveyorHTTP("PUT", "/projects", body = body, encode = "json", ...)
}

update_settings <- function(project, body, ...) { # yaml
    appveyorHTTP("GET", paste0("/projects/", project, "/settings/yaml"), body = body, ...)
}


delete_project <- function(project, ...) {
    appveyorHTTP("DELETE", paste0("/projects/", project), ...)
}

delete_cache <- function(project, ...) {
    appveyorHTTP("DELETE", paste0("/projects/", project, "/buildcache"), ...)
}


# start build

cancel_build <- function(project, build, ...) {
    appveyorHTTP("DELETE", paste0("/projects/", project, "/", build), ...)
}


