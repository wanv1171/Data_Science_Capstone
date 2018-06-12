import string

blogs = "en_US.blogs.txt"
news = "en_US.news.txt"
twitter = "en_US.twitter.txt"

fileList = [blogs, news, twitter]

for file in fileList:
	readFile = open(file, mode="r")
	writeFile = open("new_" + file,mode="w+")
	for line in readFile:
		newLine = ""
		line = line.strip()
		for character in line:
			if character in string.printable:
				newLine += character
				
		writeFile.write(newLine + "\n")
	
	readFile.close()
	writeFile.close()