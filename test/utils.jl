using DataFrames, FixedEffectModels, Base.Test
df = DataFrame(v1 = @data([1, NA, 2, 1]), v2 = @data([1, 3, 2, 1]), v3 = @data([NA, 1, 1, NA]))

@test group(df, skipna = false).pool == [1, 2, 3]
@test group(df, skipna = false).refs == [1, 2, 3, 1]
@test group(df).pool == [1]
@test group(df).refs == [0, 0, 1, 0]

# test that type of refs of last column is promoted
df = DataFrame(v1 = pool(1:1000), v2 = pool(fill(1, 1000)))
@test group(df, [:v1, :v2]) == [1:1000;]