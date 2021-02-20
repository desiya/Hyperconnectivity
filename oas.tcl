set ns [new Simulator]
set namfile [open oas.nam w]
#$ns namtrace-all $namfile

set wireless_tracefile [open oas.tr w]
set topography [new Topography]
$ns trace-all $wireless_tracefile
$ns namtrace-all-wireless $namfile 1000 1000
$topography load_flatgrid 1000 1000
set god_ [create-god 100]
#global node setting
$ns node-config -adhocRouting AODV \
                 -llType LL \
                 -macType Mac/802_16 \
                 -ifqType Queue/DropTail/PriQueue \
                 -ifqLen 50 \
                 -antType Antenna/OmniAntenna \
                 -propType Propagation/TwoRayGround \
                 -phyType Phy/WirelessPhy/802_15_4 \
                -channel [new Channel/WirelessChannel] \
                 -topoInstance $topography \
                 -agentTrace ON \
                 -routerTrace OFF \
                 -macTrace ON \
		 -energyModel EnergyModel \
		 -rxPower 0.275 \
		 -txPower 0.275 \
		 -sensePower 0.00000275 \
		 -idlePower 0.1 \
		 -initialEnergy 1.0               


#OAS - Analyzing MAC in 802_16 networks (for a WIMAX)
Channel set delay_ 4us

Classifier/Mac set bcast_ 0

#bandwidth setting done during mac initialisation (c++)
Mac set bandwidth_ 2Mb
Mac set delay_ 0us

# IEEE 802.15.14 MAC settings
if [TclObject is-class Mac/Mcns] {
	Mac/Mcns set bandwidth_ 10Mb
	Mac/Mcns set hlen_ 6
	Mac/Mcns set bssId_ -1
	Mac/Mcns set slotTime_ 10us
}

# Multihop wireless MAC modeled after Metricom's Ricochet
if [TclObject is-class Mac/Multihop] {
	Mac/Multihop set bandwidth_ 100Kb
	Mac/Multihop set delay_ 10ms
	Mac/Multihop set tx_rx_ 11.125ms
	Mac/Multihop set rx_tx_ 13.25ms
	Mac/Multihop set rx_rx_ 10.5625
	Mac/Multihop set backoffBase_ 20ms
	Mac/Multihop set hlen_ 16
}

# The MAC classifier (to demux incoming calls to the correct LL object)
Mac instproc classify-macs {peerinfo} {
	set peerlabel [lindex $peerinfo 0]
	set peerll [lindex $peerinfo 1]
	$self instvar mclass_
	set mclass_ [new Classifier/Mac]
	$mclass_ install $peerlabel $peerll
	$self target $mclass_
}

 if [TclObject is-class Mac/802_16e] {
  OAS Mac/802_16 set delay_ 64us
  OAS Mac/802_16 set ifs_ 16us
  OAS Mac/802_16 set slotTime_ 16us
  OAS Mac/802_16 set cwmin_ 16
  OAS Mac/802_16 set cwmax_ 1024
  OAS Mac/802_16 set rtxLimit_ 16
  OAS Mac/802_16 set bssId_ -1
  OAS Mac/802_16 set sifs_ 8us
  OAS Mac/802_16 set pifs_ 12us
  OAS Mac/802_16 set difs_ 16us
  OAS Mac/802_16 set rtxAckLimit_ 1
  OAS Mac/802_16 set rtxRtsLimit_ 3
  OAS Mac/802_16 set basicRate_ 1Mb  ;# set this to 0 if want to use bandwidth_ for 
  OAS Mac/802_16 set dataRate_ 1Mb   ;# both control and data pkts
  OAS Mac/802_16e set cfb_ 0 ; # enables CFB
}


# Create wireless nodes.
set node(1) [$ns node]
## node(1) at 485.525299,12.719421
$node(1) set X_ 485.525299
$node(1) set Y_ 12.719421
$node(1) set Z_ 0.0
$node(1) color "black"
$ns initial_node_pos $node(1) 10.000000
set node(2) [$ns node]
## node(2) at 522.218201,0.000000
$node(2) set X_ 522.218201
$node(2) set Y_ 0.000000
$node(2) set Z_ 0.0
$node(2) color "black"
$ns initial_node_pos $node(2) 10.000000
set node(3) [$ns node]
## node(3) at 562.020630,-5.657467
$node(3) set X_ 562.020630
$node(3) set Y_ -5.657467
$node(3) set Z_ 0.0
$node(3) color "black"
$ns initial_node_pos $node(3) 10.000000
set node(4) [$ns node]
## node(4) at 599.343628,-1.983274
$node(4) set X_ 599.343628
$node(4) set Y_ -1.983274
$node(4) set Z_ 0.0
$node(4) color "black"
$ns initial_node_pos $node(4) 10.000000
set node(5) [$ns node]
## node(5) at 639.531189,-1.473893
$node(5) set X_ 639.531189
$node(5) set Y_ -1.473893
$node(5) set Z_ 0.0
$node(5) color "black"
$ns initial_node_pos $node(5) 10.000000
set node(6) [$ns node]
## node(6) at 679.705383,13.536233
$node(6) set X_ 679.705383
$node(6) set Y_ 13.536233
$node(6) set Z_ 0.0
$node(6) color "black"
$ns initial_node_pos $node(6) 10.000000
set node(7) [$ns node]
## node(7) at 578.092773,300.216064
$node(7) set X_ 578.092773
$node(7) set Y_ 300.216064
$node(7) set Z_ 0.0
$node(7) color "black"
$ns initial_node_pos $node(7) 10.000000
set node(8) [$ns node]
## node(8) at 500.092773,400.731674
$node(8) set X_ 500.092773
$node(8) set Y_ 400.731674
$node(8) set Z_ 0.0
$node(8) color "black"
$ns initial_node_pos $node(8) 10.000000
set node(9) [$ns node]
## node(9) at 485.215576,140.731674
$node(9) set X_ 485.215576
$node(9) set Y_ 140.731674
$node(9) set Z_ 0.0
$node(9) color "black"
$ns initial_node_pos $node(9) 10.000000
set node(10) [$ns node]
## node(10) at 650.215576,140.731674
$node(10) set X_ 650.215576
$node(10) set Y_ 140.731674
$node(10) set Z_ 0.0
$node(10) color "black"
$ns initial_node_pos $node(10) 10.000000

####
set node(11) [$ns node]
$node(11) set X_ 685.215576
$node(11) set Y_ 140.731674
$node(11) set Z_ 0.0
$node(11) color "black"
$ns initial_node_pos $node(11) 10.000000

set node(12) [$ns node]
$node(12) set X_ 750.215576
$node(12) set Y_ 140.731674
$node(12) set Z_ 0.0
$node(12) color "black"
$ns initial_node_pos $node(12) 10.000000

set node(13) [$ns node]
$node(13) set X_ 850.215576
$node(13) set Y_ 140.731674
$node(13) set Z_ 0.0
$node(13) color "black"
$ns initial_node_pos $node(13) 10.000000

set node(14) [$ns node]
$node(14) set X_ 350.215576
$node(14) set Y_ 140.731674
$node(14) set Z_ 0.0
$node(14) color "black"
$ns initial_node_pos $node(14) 10.000000

set node(15) [$ns node]
$node(15) set X_ 450.215576
$node(15) set Y_ 140.731674
$node(15) set Z_ 0.0
$node(15) color "black"
$ns initial_node_pos $node(15) 10.000000

set node(16) [$ns node]
$node(16) set X_ 550.215576
$node(16) set Y_ 140.731674
$node(16) set Z_ 0.0
$node(16) color "black"
$ns initial_node_pos $node(16) 10.000000

set node(17) [$ns node]
$node(17) set X_ 600.215576
$node(17) set Y_ 140.731674
$node(17) set Z_ 0.0
$node(17) color "black"
$ns initial_node_pos $node(17) 10.000000

set node(18) [$ns node]
$node(18) set X_ 578.092773
$node(18) set Y_ 140.731674
$node(18) set Z_ 0.0
$node(18) color "black"
$ns initial_node_pos $node(18) 10.000000

set node(19) [$ns node]
$node(19) set X_ 578.092773
$node(19) set Y_ 740.731674
$node(19) set Z_ 0.0
$node(19) color "black"
$ns initial_node_pos $node(19) 10.000000

set node(20) [$ns node]
$node(20) set X_ 300.215576
$node(20) set Y_ 140.731674
$node(20) set Z_ 0.0
$node(20) color "black"
$ns initial_node_pos $node(20) 10.000000

set node(21) [$ns node]
$node(21) set X_ 578.092773
$node(21) set Y_ 640.731674
$node(21) set Z_ 0.0
$node(21) color "black"
$ns initial_node_pos $node(21) 10.000000

####
set node(22) [$ns node]
$node(22) set X_ 678.092773
$node(22) set Y_ 300.216064
$node(22) set Z_ 0.0
$node(22) color "black"
$ns initial_node_pos $node(22) 10.000000

set node(23) [$ns node]
$node(23) set X_ 100
$node(23) set Y_ 300.216064
$node(23) set Z_ 0.0
$node(23) color "black"
$ns initial_node_pos $node(23) 10.000000

set node(24) [$ns node]
$node(24) set X_ 200
$node(24) set Y_ 300.216064
$node(24) set Z_ 0.0
$node(24) color "black"
$ns initial_node_pos $node(24) 10.000000

set node(25) [$ns node]
$node(25) set X_ 300
$node(25) set Y_ 300.216064
$node(25) set Z_ 0.0
$node(25) color "black"
$ns initial_node_pos $node(25) 10.000000

set node(26) [$ns node]
$node(26) set X_ 400
$node(26) set Y_ 300.216064
$node(26) set Z_ 0.0
$node(26) color "black"
$ns initial_node_pos $node(26) 10.000000

set node(27) [$ns node]
$node(27) set X_ 500
$node(27) set Y_ 300.216064
$node(27) set Z_ 0.0
$node(27) color "black"
$ns initial_node_pos $node(27) 10.000000

set node(28) [$ns node]
$node(28) set X_ 1000
$node(28) set Y_ 300.216064
$node(28) set Z_ 0.0
$node(28) color "black"
$ns initial_node_pos $node(28) 10.000000

set node(29) [$ns node]
$node(29) set X_ 800
$node(29) set Y_ 300.216064
$node(29) set Z_ 0.0
$node(29) color "black"
$ns initial_node_pos $node(29) 10.000000

set node(30) [$ns node]
$node(30) set X_ 900
$node(30) set Y_ 300.216064
$node(30) set Z_ 0.0
$node(30) color "black"
$ns initial_node_pos $node(30) 10.000000

set node(31) [$ns node]
$node(31) set X_ 618.092773
$node(31) set Y_ 740.731674
$node(31) set Z_ 0.0
$node(31) color "black"
$ns initial_node_pos $node(31) 10.000000

set node(32) [$ns node]
$node(32) set X_ 538.092773
$node(32) set Y_ 740.731674
$node(32) set Z_ 0.0
$node(32) color "black"
$ns initial_node_pos $node(32) 10.000000

set node(33) [$ns node]
$node(33) set X_ 578.092773
$node(33) set Y_ 700.731674
$node(33) set Z_ 0.0
$node(33) color "black"
$ns initial_node_pos $node(33) 10.000000

set node(34) [$ns node]
$node(34) set X_ 618.092773
$node(34) set Y_ 700.731674
$node(34) set Z_ 0.0
$node(34) color "black"
$ns initial_node_pos $node(34) 10.000000

set node(35) [$ns node]
$node(35) set X_ 538.092773
$node(35) set Y_ 700.731674
$node(35) set Z_ 0.0
$node(35) color "black"
$ns initial_node_pos $node(35) 10.000000

####
set node(36) [$ns node]
$node(36) set X_ 100
$node(36) set Y_ 200.216064
$node(36) set Z_ 0.0
$node(36) color "black"
$ns initial_node_pos $node(36) 10.000000

set node(37) [$ns node]
$node(37) set X_ 200
$node(37) set Y_ 200.216064
$node(37) set Z_ 0.0
$node(37) color "black"
$ns initial_node_pos $node(37) 10.000000

set node(38) [$ns node]
$node(38) set X_ 300
$node(38) set Y_ 200.216064
$node(38) set Z_ 0.0
$node(38) color "black"
$ns initial_node_pos $node(38) 10.000000

set node(39) [$ns node]
$node(39) set X_ 400
$node(39) set Y_ 200.216064
$node(39) set Z_ 0.0
$node(39) color "black"
$ns initial_node_pos $node(39) 10.000000

set node(40) [$ns node]
$node(40) set X_ 500
$node(40) set Y_ 200.216064
$node(40) set Z_ 0.0
$node(40) color "black"
$ns initial_node_pos $node(40) 10.000000

set node(41) [$ns node]
$node(41) set X_ 1000
$node(41) set Y_ 200.216064
$node(41) set Z_ 0.0
$node(41) color "black"
$ns initial_node_pos $node(41) 10.000000

set node(42) [$ns node]
$node(42) set X_ 800
$node(42) set Y_ 200.216064
$node(42) set Z_ 0.0
$node(42) color "black"
$ns initial_node_pos $node(42) 10.000000

set node(43) [$ns node]
$node(43) set X_ 900
$node(43) set Y_ 200.216064
$node(43) set Z_ 0.0
$node(43) color "black"
$ns initial_node_pos $node(43) 10.000000

set node(44) [$ns node]
$node(44) set X_ 600
$node(44) set Y_ 200.216064
$node(44) set Z_ 0.0
$node(44) color "black"
$ns initial_node_pos $node(44) 10.000000

set node(45) [$ns node]
$node(45) set X_ 700
$node(45) set Y_ 200.216064
$node(45) set Z_ 0.0
$node(45) color "black"
$ns initial_node_pos $node(45) 10.000000

set node(46) [$ns node]
$node(46) set X_ 928.092773
$node(46) set Y_ 400.731674
$node(46) set Z_ 0.0
$node(46) color "black"
$ns initial_node_pos $node(46) 10.000000

set node(47) [$ns node]
$node(47) set X_ 300
$node(47) set Y_ 400.731674
$node(47) set Z_ 0.0
$node(47) color "black"
$ns initial_node_pos $node(47) 10.000000

set node(48) [$ns node]
$node(48) set X_ 700
$node(48) set Y_ 400.731674
$node(48) set Z_ 0.0
$node(48) color "black"
$ns initial_node_pos $node(48) 10.000000

set node(49) [$ns node]
$node(49) set X_ 350
$node(49) set Y_ 500.731674
$node(49) set Z_ 0.0
$node(49) color "black"
$ns initial_node_pos $node(49) 10.000000

set node(50) [$ns node]
$node(50) set X_ 800
$node(50) set Y_ 500.731674
$node(50) set Z_ 0.0
$node(50) color "black"
$ns initial_node_pos $node(50) 10.000000



$ns at 1.0 "$node(9) setdest 650.0 120.0 30.0"
$ns at 1.0 "$node(10) setdest 485.0 120.0 30.0"

$ns at 0.0 "$node(1) label Mobile_Node"
$ns at 0.0 "$node(1) color RED"
$ns at 0.0 "$node(2) label Mobile_Node"
$ns at 0.0 "$node(2) color RED"
$ns at 0.0 "$node(3) label Mobile_Node"
$ns at 0.0 "$node(3) color RED"
$ns at 0.0 "$node(4) label Mobile_Node"
$ns at 0.0 "$node(4) color RED"
$ns at 0.0 "$node(5) label Mobile_Node"
$ns at 0.0 "$node(5) color RED"
$ns at 0.0 "$node(6) label Mobile_Node"
$ns at 0.0 "$node(6) color RED"
$ns at 0.0 "$node(7) label Clusterhead"
$ns at 0.0 "$node(7) color pink"
#$ns at 0.0 "$node(8) label Base_Station"
$ns at 0.0 "$node(8) color blue"
$ns at 0.0 "$node(9) label Node"
$ns at 0.0 "$node(9) color gold"
$ns at 0.0 "$node(10) label Node"
$ns at 0.0 "$node(10) color gold"

##
#$ns at 0.0 "$node(11) label Mobile_Node"
$ns at 0.0 "$node(11) color RED"
#$ns at 0.0 "$node(12) label Mobile_Node"
$ns at 0.0 "$node(12) color RED"
#$ns at 0.0 "$node(13) label Mobile_Node"
$ns at 0.0 "$node(13) color RED"
#$ns at 0.0 "$node(14) label Mobile_Node"
$ns at 0.0 "$node(14) color RED"
#$ns at 0.0 "$node(15) label Mobile_Node"
$ns at 0.0 "$node(15) color RED"
#$ns at 0.0 "$node(16) label Mobile_Node"
$ns at 0.0 "$node(16) color RED"
#$ns at 0.0 "$node(17) label Clusterhead"
$ns at 0.0 "$node(17) color pink"
#$ns at 0.0 "$node(18) label Base_Station"
$ns at 0.0 "$node(18) color blue"
#$ns at 0.0 "$node(19) label Node"
$ns at 0.0 "$node(19) color gold"
#$ns at 0.0 "$node(20) label Node"
$ns at 0.0 "$node(20) color gold"
$ns at 0.0 "$node(47) label Access_Service_Network"
$ns at 0.0 "$node(8) label Access_Service_Network"
$ns at 0.0 "$node(48) label Access_Service_Network"
$ns at 0.0 "$node(46) label Access_Service_Network"

#$ns at 0.0 "$node(31) label Mobile_Node"
$ns at 0.0 "$node(31) color RED"
#$ns at 0.0 "$node(32) label Mobile_Node"
$ns at 0.0 "$node(32) color RED"
#$ns at 0.0 "$node(13) label Mobile_Node"
$ns at 0.0 "$node(33) color RED"
#$ns at 0.0 "$node(44) label Mobile_Node"
$ns at 0.0 "$node(44) color RED"
#$ns at 0.0 "$node(15) label Mobile_Node"
$ns at 0.0 "$node(45) color RED"
#$ns at 0.0 "$node(16) label Mobile_Node"
$ns at 0.0 "$node(46) color RED"
#$ns at 0.0 "$node(17) label Clusterhead"
$ns at 0.0 "$node(47) color pink"
#$ns at 0.0 "$node(18) label Base_Station"
$ns at 0.0 "$node(48) color blue"
#$ns at 0.0 "$node(19) label Node"
$ns at 0.0 "$node(39) color gold"
#$ns at 0.0 "$node(20) label Node"
$ns at 0.0 "$node(30) color gold"

##


$ns at 1.0 "$node(1) color green"
$ns at 3.0 "$node(1) color RED"
$ns at 2.0 "$node(2) color green"
$ns at 4.0 "$node(2) color RED"
$ns at 2.0 "$node(3) color green"
$ns at 5.0 "$node(3) color RED"
$ns at 1.5 "$node(4) color green"
$ns at 2.0 "$node(4) color RED"
$ns at 2.5 "$node(5) color green"
$ns at 3.0 "$node(5) color RED"
$ns at 4.0 "$node(6) color green"
$ns at 5.0 "$node(6) color RED"

$ns at 5.0 "$node(1) color green"
$ns at 9.0 "$node(1) color RED"
$ns at 8.0 "$node(2) color green"
$ns at 12.0 "$node(2) color RED"
$ns at 7.0 "$node(3) color green"
$ns at 13.0 "$node(3) color RED"
$ns at 8.0 "$node(4) color green"
$ns at 10.0 "$node(4) color RED"
$ns at 6.5 "$node(5) color green"
$ns at 9.5 "$node(5) color RED"
$ns at 9.0 "$node(6) color green"
$ns at 14.0 "$node(6) color RED"

#Setup a TCP Connection
set tcp [new Agent/TCP]
$ns attach-agent $node(1) $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $node(8) $sink
$ns connect $tcp $sink
$tcp set fid_ 1
$tcp set packetSize_ 552
set ftp [new Application/FTP]
$ftp attach-agent $tcp

set tcp1 [new Agent/TCP]
$ns attach-agent $node(2) $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $node(8) $sink1
$ns connect $tcp1 $sink1
$tcp1 set fid_ 1
$tcp1 set packetSize_ 552
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set tcp2 [new Agent/TCP]
$ns attach-agent $node(3) $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $node(8) $sink2
$ns connect $tcp2 $sink2
$tcp2 set fid_ 1
$tcp2 set packetSize_ 552
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

set tcp3 [new Agent/TCP]
$ns attach-agent $node(4) $tcp3
set sink3 [new Agent/TCPSink]
$ns attach-agent $node(8) $sink3
$ns connect $tcp3 $sink3
$tcp3 set fid_ 1
$tcp3 set packetSize_ 552
set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3

set tcp4 [new Agent/TCP]
$ns attach-agent $node(5) $tcp4
set sink4 [new Agent/TCPSink]
$ns attach-agent $node(8) $sink4
$ns connect $tcp4 $sink4
$tcp4 set fid_ 1
$tcp4 set packetSize_ 552
set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp4

set tcp5 [new Agent/TCP]
$ns attach-agent $node(6) $tcp5
set sink5 [new Agent/TCPSink]
$ns attach-agent $node(19) $sink5
$ns connect $tcp5 $sink5
$tcp5 set fid_ 1
$tcp5 set packetSize_ 552
set ftp5 [new Application/FTP]
$ftp5 attach-agent $tcp5

# Connect agents.

#$ns at 6.0 "$ftp start"
#$ns at 11.0 "$ftp stop"
#$ns at 5.0 "$ftp1 start"
#$ns at 9.0 "$ftp1 stop"


$ns at 1.0 "$ftp start"
$ns at 3.0 "$ftp stop"
$ns at 2.0 "$ftp1 start"
$ns at 4.0 "$ftp1 stop"
$ns at 2.0 "$ftp2 start"
$ns at 5.0 "$ftp2 stop"
$ns at 1.5 "$ftp3 start"
$ns at 2.0 "$ftp3 stop"
$ns at 2.5 "$ftp4 start"
$ns at 3.0 "$ftp4 stop"
$ns at 4.0 "$ftp5 start"
$ns at 5.0 "$ftp5 stop"

$ns at 5.0 "$ftp start"
$ns at 9.0 "$ftp stop"
$ns at 8.0 "$ftp1 start"
$ns at 12.0 "$ftp1 stop"
$ns at 7.0 "$ftp2 start"
$ns at 13.0 "$ftp2 stop"
$ns at 8.0 "$ftp3 start"
$ns at 10.0 "$ftp3 stop"
$ns at 6.5 "$ftp4 start"
$ns at 9.5 "$ftp4 stop"
$ns at 9.0 "$ftp5 start"
$ns at 14.0 "$ftp5 stop"

# Run the simulation
proc finish {} {
	global ns namfile
	$ns flush-trace
	close $namfile
	exec nam -r 2000.000000us oas.nam &
	puts "Running......"
	exit 0
	}
$ns at 20.000000 "finish"
$ns run
