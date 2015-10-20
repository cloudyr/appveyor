get_env <- function(...) {
    appveyorHTTP("GET", "/environments", ...)
}


get_env_settings <- function(env, ...) {
    appveyorHTTP("GET", paste0("/environments/", env, "/settings"), ...)
}

get_env_deployments <- function(env, ...) {
    appveyorHTTP("GET", paste0("/environments/", env, "/deployments"), ...)
}


add_env <- function(body, ...) {
    appveyorHTTP("POST", paste0("/environments/"), body = body, encode = "json", ...)
}

update_env <- function(body, ...) {
    appveyorHTTP("PUT", paste0("/environments/"), body = body, encode = "json", ...)
}

delete_env <- function(env, ...) {
    appveyorHTTP("DELETE", paste0("/environments/", env), ...)
}


get_deployment <- function(deployment, ...) {
    appveyorHTTP("GET", paste0("/deployments/", deployment), ...)
}

start_deployment <- function(body, ...) {
    appveyorHTTP("POST", paste0("/deployments/"), body = body, encode = "json", ...)
}

cancel_deployment <- function(deployment, ...) {
    appveyorHTTP("DELETE", paste0("/deployments/stop"), body = body, encode = "json", ...)
}
