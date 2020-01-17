# #########################################################

# Copyright Vilelmini Kalampratsidou, 2018.
# All rights reserved. This program and the accompanying material
# presented at JOVE video journal are available at
# https://github.com/VilelminiKala/CloseLoopInterfaceJOVE.git

# #########################################################


import scipy.io as spio
import matplotlib.pyplot as plt
import argparse
import time
import scipy.signal as signal 
import numpy as np
import peakutils
import os

from pythonosc import osc_message_builder
from pythonosc import udp_client
from pylsl import StreamInlet, resolve_stream
from pylab import *


# prepare OSC
if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument("--ip", default="127.0.0.1",
      help="The ip of the OSC server")
  parser.add_argument("--port", type=int, default=7771,
      help="The port the OSC server is listening on")
  args = parser.parse_args()

  client = udp_client.SimpleUDPClient(args.ip, args.port)


#prepare LSL
# first resolve an EEG stream on the lab network
print("looking for a PhaseSpace stream...")
streams = resolve_stream('type','EEG')  
# create a new inlet to read from the stream
inlet = StreamInlet(streams[0])


#create directory
subj='SubjectNane'  #set subjects name ------Do this for every recording !!!------
if not os.path.exists('MAT/{0}'.format(unicode(subj)) ):
    os.makedirs('MAT/{0}'.format(unicode(subj)))


#set constant values and initialize
rec_time=2*60*500 #2min, you can abjust this based on your needs
win=2000		  #a window of size 2000 was enought for to detect the peaks
total_frames=0  
indexes_all=[]
peak_Values_all=[]
hr_all=np.zeros( (1,rec_time) )


#set your filter
b,a = signal.iirfilter(2,[(5)/(500/2),(30)/(500/2)],btype='bandpass', ftype='butter')


#stream out
while total_frames<rec_time-1: 

   chunk, timestamps = inlet.pull_chunk() #get a new chunk of data. NOTE that every chunk of data might have more than 1 frame
   
   if timestamps:
       for frame in range(len(chunk)):
           
           if total_frames==1: #if it is the first frame start OSC         
               client.send_message("/HR_startstop", 1)  

           if total_frames<rec_time-1:  #if the total number of frames is smaller than the rec_time

               hr_all[0][total_frames]=chunk[frame][6]  #save the new datum

               if total_frames>=win:    #if you have enough data to get a window size data              
                    
                    x=hr_all[0][total_frames-win:total_frames] #update the window of data
                    y=signal.filtfilt(b, a, x) #apply filter
                    indexes = peakutils.indexes(y, thres=0.7, min_dist=110); #get peaks indexes
        
                    if indexes[len(indexes)-1]==win-10: 
                        msg=1;            # set 1 the message sent to OSC (peak detected)
						
                        indexes_all.append(total_frames)
                        peak_Values_all.append(y[indexes[len(indexes)-1]]);
                        print(total_frames)
             
                    else:
                        msg=0;     # set 0 the message sent to OSC (no peak detected)
               
                    # sent values to OSC
                    client.send_message("/HR_AmpR", msg)
                    client.send_message("/HR_index", total_frames)
					
           #stop OSC
           else:
           client.send_message("/HR_startstop", 0)
                
           total_frames=total_frames+1
              
#save the recrded data at the end of the recording
spio.savemat('MAT/{0}/hr_all.mat'.format(unicode(subj)), {'hr_all':hr_all}) #save the recorded heart activity
spio.savemat('MAT/{0}/indexes_all.mat'.format(unicode(subj)), {'indexes_all':indexes_all}) #save the indexes of the peaks
spio.savemat('MAT/{0}/peak_Values_all.mat'.format(unicode(subj)), {'peak_Values_all':peak_Values_all}) #save the peak values 






