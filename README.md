# BMIN503/EPID600 Final Project

Overview. My final project investigates the possibility of predicting amyloid protein formation using readily available, quantitative protein characteristics. The approach I chose utilizes an n-gram solution that attempts to incorporate the "context" of the potential amyloid forming sequences and features alongside the n-gram-level (sub-sequence) features.

## Introduction
Many lives are touched each year by the harmful effects of degenerative neurological disorders. Alzheimers, Chronic Traumatic Encephalopathy (CTE), Parkinson's and Huntington's are some of the chief disorders that many of us have heard of. The primary molecular culprits of these diseases are amyloid proteins. These microscopic brain destroyers are formed from otherwise normally functioning proteins. When made, they tend to accumulate into plaques, which are nigh untreatable. There exists a vested interest in understanding how and why these proteins form, including from which proteins they arise. A number have been identified and are query-able on a number of public datasets, but it is hard to say if the scientific community have discovered all of the polypeptidic culprits of amyloid-formation.

### Meeting with experts
To better understand the problem I was looking at, I engaged with Dr. Moore, Dr. Dunbrack and Dr. Gonzalez. My idea was the least developed when I engaged Dr. Dunbrack - an experienced protein biochemist at the Penn Cancer Institute in North Philly. His experience in the field helped me hone my question and focus on amyloid protein formation prediction. He taught me about protein disorder - which is a characteristic of some proteins that resulted from the need to develop higher functions while avoiding the extreme cost of evolutionary precision. In short, a disordered stretch of protein is a less complex section of poly-peptide that is used to interact with other proteins, resulting in some sort of function. Some think they may play a role in amyloid formation.

Meeting with Dr. Moore was an attempt to better grasp the machine learning strategy I would employ. His suggestion given the broad dataset I was operating with was to utilize a neural net.

Dr. Graciela is a natural language processing expert here at the University of Pennsylvania. She warmed to my project idea quickly, recognizing its similarity to her research group's efforts at classifying obscene language in tweets. You see, human language - especially English - is highly nuanced in its use. In today's culture our language is predicated partly from the past and partly from the quickly evolving communities on the internet. The meaning behind certain turns-of-phrase or slang is hard to keep pace with. What Graciela's group had learned is that quantifying context is extremely difficult in language. To say any phrase is offensive is to say you perfectly understand and can quantify what every preceding and following utterance really means. Luckily for my problem, quantifying the context is less murky. The "words" in my sentences are amino acids - they exist in physical space, follow physical laws and have been very incisively defined in a great deal of physio-chemical detail. I can interrogate my protein by applying any number of quantifying biochemical calculations on any number of arbitrarily sliced sections of polypeptide sequence. There are plenty of engines, predictors and tools out there to aid me in this and I made it a goal to incorporate as many as time and computational limits allowed.
