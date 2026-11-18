using Revise

includet("preprocess.jl")
using .Preprocess

data = read_file("data/pageRank-gr0.epa.txt")
