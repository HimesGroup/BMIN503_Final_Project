# Read the proteomic dataset
df = read.csv('Protein Demographic.csv',skip = 6)

head(df)

df= df[-321,]

# Let's extract the columns that include proteine expression only
protein = df[9:1313]

# Let's first normaliz the dataset using log10 transformation
protein.log = log10(protein)

# Let's first do some quality control analysis to identify potential outliers

protein.log = protein.log[-321,]

dat.pca <- prcomp(protein.log,cor=F)

protein.log$Site = df$Site

library(ggfortify)
options(repr.plot.width=7, repr.plot.height= 5)
library(ggplot2)
autoplot(dat.pca, data = protein.log,colour = 'Site',label = TRUE)

protein.log = protein.log[-309,]
df = df[-309,]

protein.log$GUID = df$GUID
protein.log$Group = df$Group
protein.log$Site = df$Site
protein.log$Age = df$Age
protein.log$LDOPA = df$LDOPADoseTm
protein.log$UPDRS = df$UPDRS

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("GEOquery")

for (pkg in c("GEOquery", "oligo", "limma", "hgu133plus2.db", "pd.hg.u133.plus.2", "viridis", "fgsea")) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    BiocManager::install(pkg)
  }
}

library(GEOquery)
library(oligo)
library(limma)
library(viridis)
library(GEOquery)

design <- model.matrix(~ -1 + factor(protein.log$Group))

colnames(design) <- levels(factor(protein.log$Group))

fit <- lmFit(t(protein.log[,1:1305]), design)

fit.contrast <- makeContrasts(diff = Control - PD, 
                                  levels = design)

fit2 <- contrasts.fit(fit, fit.contrast)

fit2 <- eBayes(fit2)

DE_results <- topTable(fit2, coef = "diff", adjust = "BH", num = Inf)

head(exposure_results)

library(ggplot2)
library("ggrepel")
# Assign (in)significant genes
exposure_results$sig <- rep("insignificant", nrow(exposure_results))
exposure_results$sig[which(exposure_results$adj.P.Val<0.05)] <- "significant"
v1 = ggplot(exposure_results, aes(x = logFC, y = -log10(adj.P.Val), color = sig)) + 
  geom_point() +
  theme_bw() +
  ggtitle("Volcano plot") +
  xlab("LogFC")+
  ylab("-Log10(q-value)") +
  scale_color_manual(values = c("black", "red")) +
  theme(legend.position = "none")

v1+geom_text_repel(data=head(exposure_results, 40), aes(label=rownames(exposure_results)[1:40]))

dict = read.csv('Protein Demographic.csv',skip = 1)

dict1 = t(dict[4:5,])[-1:-8,]
rownames(dict1) = NULL
colnames(dict1) = c('SYMBOL','Protein.Name')
exposure_results$Protein.Name = rownames(exposure_results)
protein_gene = merge(exposure_results,dict1,by = 'Protein.Name')

DE_res = protein_gene

write.table(exposure_results, "./Protein_DE_results.txt", row.names = F, 
            col.names = T, quote = F, sep = "\t")

df_boxplot1 = data.frame(
  expression = protein.log[,'BSP'],
  status = protein.log$Group)

ggplot(df_boxplot1, aes(x = status, y = expression)) +
  geom_boxplot(outlier.colour = NA, color = "grey18", fill = "lightblue") +
  stat_boxplot(geom = "errorbar", color = "grey18") +
  geom_jitter(size = 1, position = position_jitter(width = 0.3)) +
  ggtitle("BSP Expression Level between PD and Control") +
  xlab(" ") +
  ylab("BSP Expression Level (RFU)") +
  theme_bw() +
  theme(legend.position = "none")

df_boxplot2 = data.frame(
  expression = protein.log[,'OMD'],
  status = protein.log$Group)

ggplot(df_boxplot2, aes(x = status, y = expression)) +
  geom_boxplot(outlier.colour = NA, color = "grey18", fill = "lightblue") +
  stat_boxplot(geom = "errorbar", color = "grey18") +
  geom_jitter(size = 1, position = position_jitter(width = 0.3)) +
  ggtitle("OMD Expression Level between PD and Control") +
  xlab(" ") +
  ylab("OMD Expression Level (RFU)") +
  theme_bw() +
  theme(legend.position = "none")

df_boxplot3 = data.frame(
  expression = protein.log[,'ApoM'],
  status = protein.log$Group)

ggplot(df_boxplot3, aes(x = status, y = expression)) +
  geom_boxplot(outlier.colour = NA, color = "grey18", fill = "lightblue") +
  stat_boxplot(geom = "errorbar", color = "grey18") +
  geom_jitter(size = 1, position = position_jitter(width = 0.3)) +
  ggtitle("ApoM Expression Level between PD and Control") +
  xlab(" ") +
  ylab("ApoM Expression Level (RFU)") +
  theme_bw() +
  theme(legend.position = "none")

options(repr.plot.width=14, repr.plot.height= 15)
library(gplots)
# keep top 200 genes
top_results <- subset(exposure_results,sig =='significant')
top.eset <- protein.log[colnames(protein.log) %in% row.names(top_results)]
status.colors <- unlist(lapply(protein.log$Group, 
                               function (x) {if (x == "PD") "red"  
                                 else "navy"}))
heatmap.2(t(top.eset), col = viridis(256, option = "B"),
          trace = "none", keysize = 1.5, key.title = NA,
          ColSideColors = status.colors)
legend("topright", legend = c("PD","Control"), fill = c("red", "navy")) 

library(fgsea)
kegg <- gmtPathways("./c2.cp.kegg.v7.4.symbols.gmt")
reactome <- gmtPathways("./c2.cp.reactome.v7.4.symbols.gmt")
pathways <- c(kegg, reactome)
head(DE_res)

library(dplyr)
DE_res <- DE_res %>%
  filter(!is.na(SYMBOL)) %>%
  group_by(SYMBOL) %>%
  arrange(P.Value) %>%
  filter(row_number() == 1) %>%
  data.frame()


gene_list <- DE_res$t
names(gene_list) <- DE_res$SYMBOL
gene_list <- sort(gene_list, decreasing = T)
head(gene_list, 5)


options(warn=-1)
fgseaRes <- fgsea(pathways = pathways, stats = gene_list, minSize = 15, 
                 maxSize = 500, nperm = 10000, gseaParam = 1)
fgseaRes <- fgseaRes[order(fgseaRes$pval), ]

collapsedPathways <- collapsePathways(fgseaRes = fgseaRes[padj < 0.05], 
                                      pathways = pathways, stats = gene_list)
mainPathways <- fgseaRes[pathway %in% collapsedPathways$mainPathways] # keep results of independent pathways

top_pathway <- mainPathways %>%
  filter(padj < 0.05 & abs(NES) > 1) %>%
  arrange(NES)

options(repr.plot.width=5, repr.plot.height= 5)
# convert pathways to factors where the levels are the same as pathway order


options(repr.plot.width=15, repr.plot.height= 5)
top_pathway$pathway <- factor(top_pathway$pathway, levels = top_pathway$pathway)
ggplot(top_pathway, aes(y = NES, x = pathway)) +
  geom_bar(width = 0.8, position = position_dodge(width = 0.8), stat = "identity", fill = "blue") + 
  coord_flip() +
  theme_bw() +
  theme(
    axis.title.y = element_blank()
  )

plotEnrichment(pathway = pathways[["KEGG_CHEMOKINE_SIGNALING_PATHWAY"]], stats = gene_list) + 
  labs(title="KEGG_CHEMOKINE_SIGNALING_PATHWAY")

top_pathway %>% 
  filter(pathway=="KEGG_CHEMOKINE_SIGNALING_PATHWAY") %>% 
  dplyr::select(leadingEdge) %>% 
  unlist() %>% 
  unname()
         

library(caret)
library(e1071)
library(precrec)
library(ROCit)

install.packages('ROCit', dependencies = TRUE)

### Let's train the model using 4 proteins that passed the p value threshold of 0.05 on both cohorts
train_control <- trainControl(method = "repeatedcv", number = 5, repeats = 50)
model <- train(as.factor(Group) ~
                        Age+
                        ApoM+
                        BSP+
                        OMD,
                        method = "glm",
                        data = protein.log,
                        na.action=na.omit,
                        family = binomial)

# Let's take a look at the final model
summary(model)


# Plot ROC curve with AUC score
options(repr.plot.width=8, repr.plot.height=8)
predict_train1 <- predict(model, newdata = protein.log, type= "prob")
precrec_obj <- rocit(class = protein.log$Group, score = predict_train1$PD)
plot(precrec_obj)

summary(precrec_obj)


