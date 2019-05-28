#----------------------------------------------------------------------------
# zFactorNew
#
# Package logger setup
#----------------------------------------------------------------------------

.logger_name <- "zFactorNew"
.pkg_logger <- logging::getLogger(.logger_name)
.pkg_logger$setLevel("FINEST")

pkg_loginfo <- function(msg, ...) tryCatch(logging::loginfo(msg, ..., logger = .pkg_logger),
                                           error = function(e) warning(e))
pkg_logdebug <- function(msg, ...) tryCatch(logging::logdebug(msg, ..., logger = .pkg_logger),
                                            error = function(e) warning(e))
pkg_logerror <- function(msg, ...) tryCatch(logging::logerror(msg, ..., logger = .pkg_logger),
                                            error = function(e) warning(e))
pkg_logwarn <- function(msg, ...) tryCatch(logging::logwarn(msg, ..., logger = .pkg_logger),
                                           error = function(e) warning(e))
pkg_logfinest <- function(msg, ...) tryCatch(logging::logfinest(msg, ..., logger = .pkg_logger),
                                             error = function(e) warning(e))

#'
#' Retrieves zFactorNew logger.
#' 
#' @return logger object
#' 
#' @export
#' 
zFactorNew_getLogger <- function() {
  .pkg_logger
}
