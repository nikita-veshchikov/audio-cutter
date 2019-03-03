#!python3

import sys

if __name__ == "__main__":
	filename = sys.argv[1]
	# 30 minutes by default
	distance = int(sys.argv[2]) if len(sys.argv) == 3 else 1800
	
	file = open(filename)
	points = file.readlines()
	file.close()
	
	points = [int(elem) for elem in points]
	
	cuts = []
	
	lastCut = 0
	i = 1
	while i< len(points):
		 while i< len(points) and (points[i] - lastCut) < distance :
		 	i+=1
		 
		 if i<len(points):
		 	distBefore = points[i-1] - lastCut
		 	distAfter = points[i] - lastCut
		 	
		 	if distAfter < distBefore: # cut after point (closer to "distance")
		 		i+=1
		 	
		 	lastCut = points[i]
		 	cuts.append(lastCut)
		 else:
		 	i+=1
	
	#write found cut-points to file
	
	file = open("cuts.txt", "w")
	file.write("{0}".format(cuts[0]))
	cuts = cuts[1:]
	for cut in cuts:
		file.write(",{0}".format(cut))
	file.close()
	
