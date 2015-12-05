#' @title Market matching and causal impact inference
#'
#' @details  
#' The MarketMatching package can be used to perform the following analyses:
#' - For a given market, find the best control market using time series matching
#' - tem Given a test market and a matching control market, analyze the causal impact of an intervention
#' 
#' The package utilizes the dtw package in CRAN to do the time series matching, and the CausalImpact package created by 
#' Kay Brodersen at Google to do the inference.
#' For more information about the CausualImpact package, see the following reference:  
#' 
#' "CausalImpact r 1.0.3, Brodersen et al., Annals of Applied Statistics (2015). http://google.github.io/CausalImpact/
#' 
#' The MarketMatching has two separate functions to perform the tasks described above:
#' - best_matches(): This function is used to find a matching control market for all markets in the input dataset.
#' - inference(): Given an object from best_matches(), analyze the causal impact of an intervention (defined by a time window).
#' @author Kim Larsen (kblarsen4 at gmail.com)
#' @keywords time warping, time series matching, causal impact
#' @docType package
#' @description 
#' For a given test market find the best matching control market using time series matching and analyze the impact of an intervention.
#' The intervention could be be a marketing event or some other local business tactic that is being tested. 
#' The package utilizes dynamic time warping to do the matching and the CausalImpact package to analyze the causal impact. 
#' In fact, this package can be considered a wrapper for those two packages.
#'
#'
#' @name MarketMatching
#' @examples 
#' ##-----------------------------------------------------------------------
#' ## Find best matches for each airport time series
#' ##-----------------------------------------------------------------------
#' library(MarketMatching)
#' data(weather, package="MarketMatching")
#' mm <- best_matches(data=weather, id="Area", 
#'                    date_variable="Date", 
#'                    matching_variable="Mean_TemperatureF", 
#'                    parallel=FALSE, 
#'                    start_match_period="2014-01-01",
#'                    end_match_period="2014-10-01")
#' head(mm$Distances)
#' subset(mm$Distances, Area=="CPH")
#' 
#' ##-----------------------------------------------------------------------
#' ## Analyze causal impact of a made-up weather intervention in Copenhagen
#' ## Since this is weather data this is a meaningless example and we should 
#' ## expect no causal impact. This is just to demo the function.
#' ##-----------------------------------------------------------------------
#' results <- MarketMatching::inference(matched_markets = mm, test_market = "CPH", end_post_period = "2015-10-01")
#' 
#' ## Plot the impact
#' results$PlotAbsoluteEffect
#' 
#' ## Plot actual observations for test market (CPH) versus the expectation (based on the control)
#' results$PlotActualVersusFitted

NULL