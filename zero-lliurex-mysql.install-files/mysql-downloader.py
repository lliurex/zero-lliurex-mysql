#!/usr/bin/python3
import sys,os
import time
import tempfile
import requests

if __name__ == "__main__":
	output=sys.argv[1]
	url=sys.argv[2]
	print("Connecting to {}".format(os.path.dirname(url)))
	if len(url)>0:
		content=requests.get(url,stream=True)
		progressA="Downloading "
		progress=["|","/","-","\\"]
		cont=0
		otime=time.time()
		with open(output,"wb") as f:
			for fchunk in content.iter_content(chunk_size=9082):
				if fchunk!=None:
					f.write(fchunk)
					if time.time()-otime>=0.2:
						out=progressA+progress[int(cont)]
						print(out,end="\r")
						cont+=1
						if cont>=len(progress):
							cont=0
						otime=time.time()
