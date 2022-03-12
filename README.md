# SHLO-Knapsack-Test
Short Test Code of the SHLO algorithm knapsack problem

This code is based on the paper: "A Simple Human Learning Optimization Algorithm" (SHLO). 

They have made public some example code of this at https://www.mathworks.com/matlabcentral/fileexchange/65577-human-learning-optimization-hlo-algorithm

I incorporated the described variables for run replications, num items, max weight, etc. 

The data collection code then wrote the results to the csv file. The code has a nested loop and will take a bit of time to run. The last 2 columns allow for making sure that your
data set is the same as the one in the code.
To verify, make your dataset and sum all the weights/profits and verify that they are the same as in the csv

The datacollection file will generate the data and run a nested loop to run through all the different set ups. A 'set up' is represented as one row in the csv file, with the first
4 columns describing parameters of the set up, and the rest of the columns reflecting a statistic/quantity of the set up runs. For each setup, it runs the SHLO on the dataset for
runtime times (currently set to 30, thus it runs SHLO 30 times on each dataset). Then when it calls SHLO, that function calls the evaluation function (eF) to evaluate the profit 
and weight of a given solution. 

The SHLO code is taken from their provided sample code and modified for the particular knapsack problem (no need for B2R transform, and bit is always 1, thus no need for m= bit* 
dim since then m=dim).

Code for a greedy solution (gS) is also given, which gives surprisingly great results given that it utilized such a low function evaluation count, the function does a single pass
of the items sorted by efficiency, and does not check if it can fix another item in. For example, for the first dataset the SHLO gets a solution generally of about 6704 up to
6709, (other better algothims with meta-heuristics generate 6710+) whereas the initial greedy solution is 6990 with weight of 992 (mas is 1000) so it can reasonably fit another
item as well.
