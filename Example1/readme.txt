This code is part of the publication “Real-time proxy-control of re-parameterized peripheral signals using close-loop interface” 
at JOVE (link:…). Specifically, it is the python interface described in example 1, section “The real-time analyses of data and 
monitoring of the human system”.


To execute this code, you should employ a wearable device that collects electrocardiography (ECG) signal and allows real-time 
streaming. In our example, we use the Enobio 32 EEG system with the heartrate extension. Stream the data to the labstreaminglayer
(LSL) (for instruction see here: https://github.com/sccn/labstreaminglayer, the Enobio 32 EEG system is included in the applications
of the LSL system so no extra development is required). Once the data, are streamed to LSL then you will be able to load the data
to this interface and extract features of the heart activity. To do this, adapt lines 40-43 of the code to the data structure you
are loading.
