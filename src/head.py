N = 100
with open("C:/Users/Martin/Documents/School/2-Semester/I-FP/Project/archive/collection.jl", "r") as readFile:
    head = [next(readFile) for x in range(N)]


with open("C:/Users/Martin/Documents/School/2-Semester/I-FP/Project/archive/collectionFirst" + str(N) + ".jl", "w") as writeFile:
    for index, line in enumerate(head):
        writeFile.write(line)
