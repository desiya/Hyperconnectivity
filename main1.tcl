# explicitly setup our main window

wm geometry  . 800x400+10+10
wm title  .   "Handover Elimination to Improve the QoS - Wireless Access Networks"

# setup the frame stuff

destroy .myArea
set f [frame .myArea -borderwidth 5 -background tan]
pack $f -side top -expand true -fill both

# create a menubar

destroy .menubar
menu .menubar
. config -menu .menubar

#  create a pull down menu with a label 

#pack .m -expand true -ipadx 600 -ipady 400

set File [menu .menubar.mFile]
.menubar add cascade -label "Proposed Topology"  -menu  .menubar.mFile





set comparison1 [menu .menubar.mcomparison1]
.menubar add cascade -label "Comparision Analysis"  -menu  .menubar.mcomparison1

set close [menu .menubar.sFile]
.menubar add cascade -label Quit  -menu  .menubar.sFile


$File add command -label Run_Proposed_Topo -command {exec ns nrml.tcl &}
$File add command -label Simulation_Output -command {exec nam unr.nam &}






$comparison1 add command -label "Energy Efficiency" -command {exec gnuplot.exe energy3.plot &}
$comparison1 add command -label "Delivery Ratio" -command {exec gnuplot.exe data3.plot &}
$comparison1 add command -label "Latency" -command {exec gnuplot.exe latency3.plot &}
$comparison1 add command -label "Number of Live nodes" -command {exec gnuplot.exe nodes3.plot &}


$close add command -label Quit -command exit