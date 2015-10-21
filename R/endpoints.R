#' @title Appveyor API Client
#' @description This package provides functionality for interacting with the Appveyor API. Appveyor is a continuous integration service that allows for automated testing of software each time that software is publicly committed to a repository on GitHub. Unlike most CIs, it is specifically aimed at a Windows development environment. Setting up Appveyor is quite simple, requiring only a GitHub account, some public (or private) repository hosted on GitHub, and logging into to Appveyor to link it to that repository. Kiril Mueller provides \href{https://github.com/krlmlr/r-appveyor}{straightforward documentation} for configuring your repository to interact with Appveyor via an \samp{appveyor.yml} file added to your repository.
#'
#' Once you have your Appveyor account configured online, you can use this package to interact with and perform all operations on your Appveyor builds that you would normally perform via the Appveyor website. This includes monitoring builds, modifying build environment settings and environment variables, and cancelling or restarting builds.
#'
#' Use of this package requires your Appveyor API token, which can be found \href{https://ci.appveyor.com/api-token}{on the Appveyor website}. This should be stored as an environment variable using either \code{Sys.setenv("APPVEYOR_TOKEN" = "exampletoken")} or by storing the API token in your .Renviron file
#'
#' @examples
#' \dontrun{
#' # authenticate using a stored environment variables
#' Sys.setenv("APPVEYOR_TOKEN" = "appveyorapitoken")
#' 
#' # check to see if you've authenticated correctly
#' get_user()
#' }
#'
#' @docType package
#' @name appveyor
NULL


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


