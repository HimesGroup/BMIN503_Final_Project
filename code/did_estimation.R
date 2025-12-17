### Diff-in-diff estimation
estimate_diff <- function(
  buffer_size,
  range = 4,
  count = 4,
  level = "all",
  outcome = "violent_count",
  df,
  control = "notyettreated"
) {
  buffer_size <- set_units(buffer_size, m)
  df <- df %>%
    as.data.frame() %>%
    filter(buffer == buffer_size & count >= count)
  df$outcome <- df[[outcome]]

  if (tail(str_split_1(outcome, "_"), n = 1) == "count") {
    # AKA if we are calculating a density (count per area)
    df$outcome_density <- df$outcome / df$area
    df$outcome <- df$outcome_density
  }

  if (level == "all") {
    cluster = c("group", "city")
  } else if (level == "city") {
    cluster = c("group")
  }

  # Creates one version of the model with clustered standard errors at the clinic level...
  attgt_crimes <- att_gt(
    yname = outcome,
    tname = "year",
    idname = "group",
    allow_unbalanced_panel = TRUE,
    #panel = FALSE,
    clustervars = cluster,
    gname = "change",
    xformla = ~1,
    data = df,
    control_group = control
  )
  if (!all(is.na(attgt_crimes$att))) {
    # Checks to see if the model converged-- if it did not, return empty values
    group_effects <- aggte(
      attgt_crimes,
      type = "dynamic",
      na.rm = TRUE,
      clustervars = cluster,
      min_e = -1 * range,
      max_e = range
    )

    estimate <- data.frame(
      estimate = group_effects$overall.att,
      se = group_effects$overall.se,
      ci_low = group_effects$overall.att - 1.96 * group_effects$overall.se,
      ci_high = group_effects$overall.att + 1.96 * group_effects$overall.se
    )

    units(estimate$estimate) <- units(df$outcome)
    units(estimate$se) <- units(df$outcome)
    units(estimate$ci_low) <- units(df$outcome)
    units(estimate$ci_high) <- units(df$outcome)

    estimate <- estimate %>%
      reframe(
        city = ifelse(
          level == "all",
          "All Cities",
          unique(df$city)
        ),
        direction = ifelse(
          df$change[1] == df$first_open[1],
          "Opening",
          "Closure"
        ),
        crime_type = str_to_title(str_split_i(outcome, "_", 1)),
        buffer = buffer_size,
        estimate = estimate,
        se = se,
        ci_low = ci_low,
        ci_high = ci_high,
        outcome = outcome,
        range = range,
        count = count,
        cluster = paste(cluster, collapse = ", "),
        score_inc_min = min(df$Score, na.rm = T)
      ) %>%
      arrange(range, count, direction, crime_type, buffer)

    return(estimate)
  } else {
    return()
  }
}
