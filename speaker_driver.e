speaker_driver      cp   0x80000042   		sample
                    cp   0x80000040   		speakerone                   
speakerwait1        cp   speakerresponse   	0x80000041
                    be   speakerwait1  		speakerresponse 	speakerzero
                    cp   0x80000040  		speakerzero
speakerwait2        cp   speakerresponse  	0x80000041
                    be   speakerwait2  		speakerresponse 	speakerone
                    ret  return               


speakerresponse    	0
sample      		0
speakerone         	1
speakerzero        	0
return      		0
