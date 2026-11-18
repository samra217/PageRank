module Preprocess

export read_file

using LinearAlgebra


function read_file(filename::String)
    number_of_nodes = 0;
    open(filename, "r") do file
        readline(file) # Skip the first line (header)
        while !eof(file)
            line = readline(file)
            if (startswith(line, "n"))
                number_of_nodes += 1 
            else
               break 
            end
        end
        data = zeros(Float64, number_of_nodes, number_of_nodes)
        while !eof(file)
            line = readline(file)
            parts = split(line)
            if length(parts) == 3
                i = parse(Int, parts[2]) +1
                j = parse(Int, parts[3]) +1
                data[i, j]::Float64 = 1.0
            end
        end
        data_normalized = normalize_data!(data)
        return data_normalized
    end
end


function normalize_data!(data::Matrix{Float64})
    for j in 1:size(data, 2)
        col_norm = sum(data[:, j])
        if col_norm != 0
            data[:, j] ./= col_norm
        end
    end
    return data
end


end
