#Initilization
set val(chan)          Channel/WirelessChannel      ;# channel type
set val(prop)          Propagation/TwoRayGround     ;# radio-propagation model
set val(netif)         Phy/WirelessPhy/802_15_4     ;# network interface type
set val(mac)           Mac/802_15_4                 ;# MAC type
set val(ifq)           Queue/DropTail/PriQueue      ;# interface queue type
set val(ll)            LL                           ;# link layer type
set val(ant)           Antenna/OmniAntenna          ;# antenna model
set val(ifqlen)        100	         	    ;# max packet in ifq
set val(rp)            AODV			    ;# protocol tye
set val(stop)          50			    ;# simulation period 
set val(energymodel)   EnergyModel		    ;# Energy Model
set val(initialenergy) 100			    ;# value

set MESSAGE_PORT 42
set BROADCAST_ADDR -1

set val(nn) 50
set val(x) 1000
set val(y) 1000

set ns [new Simulator]

set f [open jcra.tr w]
$ns trace-all $f
set nf [open jcra.nam w]
$ns namtrace-all-wireless $nf $val(x) $val(y)

# set up topography object
set topo       [new Topography]
$topo load_flatgrid $val(x) $val(y)

# Create God
create-god $val(nn)

set chan_1_ [new $val(chan)]

$ns node-config -adhocRouting $val(rp) \
            -llType $val(ll) \
             -macType $val(mac) \
             -ifqType $val(ifq) \
             -ifqLen $val(ifqlen) \
             -antType $val(ant) \
             -propType $val(prop) \
             -phyType $val(netif) \
             -channel [new $val(chan)] \
             -topoInstance $topo \
             -agentTrace ON \
             -routerTrace ON \
             -macTrace  OFF \
             -movementTrace OFF \
             -energyModel $val(energymodel) \
             -initialEnergy $val(initialenergy) \
             -rxPower 35.28e-3 \
             -txPower 31.32e-3 \
	     -idlePower 712e-6 \
	     -sleepPower 144e-9 

set f1 [open oint_.tr w]
set f2 [open nwcap.tr w]
set f3 [open delay.tr w]
set f4 [open cost.tr w]
set f5 [open nlost.tr w]



source node.tcl
source design.tcl
source dataschema.tcl


set holdtime 0
set holdseq 0
set holdrate 0
set a 1
set b 1
set num 100

proc record {} {
  global sink f1 f2 f3 f4 f5 f7 f8 f9 holdtime holdseq holdrate a b num
  
  set ns [Simulator instance]
  
  #Set Sampling Time to 0.05 Sec
  
  set time 0.05
  
  set af1 [$sink set npkts_]
  set af2 [$sink set nlost_]
  set af3 [$sink set expected_]
  set af4 [$sink set lastPktTime_]
  set af5 [$sink set bytes_]
  
  set now [$ns now]
  
  

  puts $f1 "$now [expr $af1*1000]"


 puts $f4 "$now [expr (($af5+$holdrate)*8)/(2*$time*1000000)]"
    
  #Record Data Rate in Trace Files
  puts $f2 "$now [expr (($af5+$holdrate)*8)/(2*$time*1000000)]"
   
   # Radio Resource Cost
   
  puts $f4 "$now [expr ($a*$af3)+($b*(($af5+$holdrate)*8)/(2*$time*1000000))]"
  
  
  #Record Packet Loss Rate in File
  puts $f5 "$now [expr $af2]"
  
  
   #Record Packet Delay in File
  if { $af1 > $holdseq } {
  	puts $f3 "$now [expr ($af4 - $holdtime)/($af1 - $holdseq)]"
  } else {
  	puts $f3 "$now [expr ($af1 - $holdseq)]"
  }
  
  
  $ns at [expr $now+$time] "record"
}

set sink [new Agent/LossMonitor]
$ns attach-agent $n(9) $sink

set server [new Agent/LossMonitor]
$ns attach-agent $n(48) $server

set udp [new Agent/UDP]
$ns attach-agent $n(20) $udp
$ns connect $udp $sink
set cbr [new Application/Traffic/CBR]
$cbr set packetSize_ 512
$cbr set burst_time_ 2s
$cbr set idle_time_ 1s
$cbr set rate_ 100k
$cbr attach-agent $udp

set udp1 [new Agent/UDP]
$ns attach-agent $n(32) $udp1
$ns connect $udp1 $sink
set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 512
$cbr1 set burst_time_ 2s
$cbr1 set idle_time_ 1s
$cbr1 set rate_ 100k
$cbr1 attach-agent $udp1

set udp2 [new Agent/UDP]
$ns attach-agent $n(10) $udp2
$ns connect $udp2 $sink
set cbr2 [new Application/Traffic/CBR]
$cbr2 set packetSize_ 512
$cbr2 set burst_time_ 2s
$cbr2 set idle_time_ 1s
$cbr2 set rate_ 100k
$cbr2 attach-agent $udp2

set udp3 [new Agent/UDP]
$ns attach-agent $n(35) $udp3
$ns connect $udp3 $sink
set cbr3 [new Application/Traffic/CBR]
$cbr3 set packetSize_ 512
$cbr3 set burst_time_ 2s
$cbr3 set idle_time_ 1s
$cbr3 set rate_ 100k
$cbr3 attach-agent $udp3

set udp4 [new Agent/UDP]
$ns attach-agent $n(13) $udp4
$ns connect $udp4 $sink
set cbr4 [new Application/Traffic/CBR]
$cbr4 set packetSize_ 512
$cbr4 set burst_time_ 2s
$cbr4 set idle_time_ 1s
$cbr4 set rate_ 100k
$cbr4 attach-agent $udp4

set udp5 [new Agent/UDP]
$ns attach-agent $n(25) $udp5
$ns connect $udp5 $sink
set cbr5 [new Application/Traffic/CBR]
$cbr5 set packetSize_ 512
$cbr5 set burst_time_ 2s
$cbr5 set idle_time_ 1s
$cbr5 set rate_ 100k
$cbr5 attach-agent $udp5

set udp6 [new Agent/UDP]
$ns attach-agent $n(35) $udp6
$ns connect $udp6 $server
set cbr6 [new Application/Traffic/CBR]
$cbr6 set packetSize_ 512
$cbr6 set burst_time_ 2s
$cbr6 set idle_time_ 1s
$cbr6 set rate_ 100k
$cbr6 attach-agent $udp6

$ns at 0.0 "record"
$ns at 1.0 "$cbr start"
$ns at 3.0 "$cbr stop"

$ns at 3.0 "$cbr1 start"
$ns at 5.0 "$cbr1 stop"

$ns at 5.0 "$cbr2 start"
$ns at 7.0 "$cbr2 stop"

$ns at 7.0 "$cbr3 start"
$ns at 9.0 "$cbr3 stop"

$ns at 9.0 "$cbr4 start"
$ns at 11.0 "$cbr4 stop"

$ns at 11.0 "$cbr5 start"
$ns at 13.0 "$cbr5 stop"

$ns at 14.0 "$cbr6 start"
$ns at 18.0 "$cbr6 stop"



$ns at 0.0 "$ns trace-annotate \"Clustering Method For WSn\""
$ns at $val(stop) "finish"

proc finish {} {
	global ns f1 f2 f3 f4 f5 
	$ns flush-trace
        close $f1
	close $f2
        close $f3
	close $f4
        close $f5

        puts "running..."
        exec nam jcra.nam &
        exit 0
}

$ns run