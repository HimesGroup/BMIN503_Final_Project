table_1 %>%    # build gtsummary table
  as_gt() %>%             # convert to gt table
  gt::gtsave(             # save table as image
    filename = "Y:\\Downloads\\bmin-table-1.png"
  )


as_tibble(dt_randomForest$importance, rownames = "var_name") %>%
  arrange(desc(MeanDecreaseAccuracy)) %>%
  select(var_name, starts_with("Mean")) %>%
  filter(row_number() <= 10) %>%
  left_join(ha_var_labels, by = "var_name") %>%
  select(`Variable Name` = var_mean, starts_with("Mean")) %>%
  mutate(`Variable Name` = paste0("**",`Variable Name` ),
         `Variable Name` = str_replace(`Variable Name`, "[\\s]{1,2}\\(", "** (" ),
         `Variable Name` = str_replace(`Variable Name`, "PT", "Physical therapy" ),
         `Variable Name` = gsub("=(\\w)(\\w*)","=\\U\\1\\L\\2",`Variable Name`,perl=TRUE)) %>%
  gt() %>%
  fmt_markdown(columns = TRUE) %>%
  fmt_scientific(
    columns = vars( MeanDecreaseAccuracy),
    decimals = 1
  ) %>%
  fmt_number(
    columns = vars(MeanDecreaseGini),
    decimals = 2
  ) %>%
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_column_labels(everything())
  ) %>% gtsave(             # save table as image
    filename = "Y:\\Downloads\\bmin-table-2.png"
  )


as_tibble(dt_randomForest$importance, rownames = "var_name") %>%
  select(var_name, starts_with("Mean")) %>%
  mutate(MeanDecreaseAccuracy_Rank = row_number(desc(MeanDecreaseAccuracy)),
         MeanDecreaseGini_Rank = row_number(desc(MeanDecreaseGini))) %>%
  filter(MeanDecreaseAccuracy_Rank <= 10 |
           MeanDecreaseGini_Rank <= 10) %>%
  left_join(ha_var_labels, by = "var_name") %>%
  mutate(`Variable Name` = case_when(
    !is.na(var_mean) ~ var_mean,
    TRUE ~ str_to_sentence(var_name)
  )) %>%
  select(`Variable Name`, Accuracy = MeanDecreaseAccuracy_Rank, 
         `Gini index` = MeanDecreaseGini_Rank) %>%
  mutate(`Variable Name` = str_replace(`Variable Name`, "PT", "Physical therapy" ),
         `Variable Name` = str_replace(`Variable Name`, "Ng-", "NG-" ),
         `Variable Name` = gsub("=(\\w)(\\w*)","=\\U\\1\\L\\2",`Variable Name`,perl=TRUE)) %>%
  pivot_longer(cols = -`Variable Name`, names_to = "measure", values_to = "Rank") %>%
  pivot_wider(id_cols = Rank, names_from = measure, values_from = `Variable Name`) %>%
  slice_min(Rank, n = 10) %>%
  gt() %>%
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_column_labels(everything())
  ) %>% 
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_body(columns = vars(Rank))
  ) %>% 
  gtsave( filename = "Y:\\Downloads\\bmin-table-2.png")

ggsave("Y:\\Downloads\\bmin-graph-3.png", cutoff_plot, dpi = 320, width = 10, height = 6)


prettyLearner_randomForest %>%
  mutate(
       `Variable Name` = gsub("=(\\w)(\\w*)","=\\U\\1\\L\\2",`Variable Name`,perl=TRUE)) %>%
  gt() %>%
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_column_labels(everything())
  ) %>%
  tab_style(
    style = cell_fill(color = "indianred1", alpha = 0.5),
    locations = cells_body(
      columns = vars(Value),
      rows = Value == "No")
  ) %>%
  tab_style(
    style = cell_fill(color = "darkolivegreen2", alpha = 0.5),
    locations = cells_body(
      columns = vars(Value),
      rows = Value == "Yes")
  ) %>%
  tab_style(
    style = cell_text(align = "center"),
    locations = list(cells_body(
      columns = vars(Value, Predict)),
      cells_column_labels(
        columns = vars(Value, Predict)))
  )  %>% 
  gtsave( filename = "Y:\\Downloads\\bmin-table-4.png")

  