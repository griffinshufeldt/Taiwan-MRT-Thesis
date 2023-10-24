*gen DiD
gen treated_post = treatment * time

*Insert outcome
regress *INSERT OUTCOME* treatment time post_treatment *CONTROLS*
