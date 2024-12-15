sd_card_driver  cp  0x80000082  sdzero                    
                cp  0x80000083  sd_address              
                cp  0x80000080  sdone                     
sdwait1           cp  response    0x80000081               
                be  sdwait1       response    sdzero        
                cp  sd_data     0x80000085              
                cp  0x80000080  sdzero                   
sdwait2           cp  response    0x80000081              
                be  sdwait2       response    sdone
                ret return
sdone         1
sdzero        0
response    0
sd_data     0
sd_return	0
