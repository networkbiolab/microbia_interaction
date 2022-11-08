#!/usr/bin/perl
use strict;

my $dir = shift @ARGV;
my $folder = '/media/amartin/12TB1/interaccion_bacteria/data';
my $f = "$folder/4clustering.tsv";
my $c = "$folder/clusters.tsv";
my $h = `head -n1 $f`;
chomp $h;

open (F, "<", "$f") or die "can't open $f\n";
my @d = <F>;
close F;
shift @d;
my %n = ();
for my $l (@d){
	chomp $l;
	my @t = split("\t",$l);
	my $name = shift @t;
	$l =~ s/^$name\t//;
	if($l =~ /^$name/){
		print "$name\n";
	}
	my $type = '';
	$name =~ s/"//g;
	if($name =~ / CF$/){
		$type = "CF";
	}
	elsif($name =~ / CO$/){
		$type = "CO";
	}
	if($type ne ''){
		$n{$name} = "$type\t$l";
	}
	else{
		print "$name\n";
	}
}


open (F, "<", "$c") or die "can't open $c\n";
my @dc = <F>;
close F;
my %fold = (); 
while(my $l = shift @dc){
	chomp $l;
	my @t = split("\t",$l);
	if(!exists $n{$t[0]}){
		print "$t[0]\n";
	}
	else{
		if($t[1] == 1 || $t[1] == 4 || $t[1] == 7){
			$fold{"F0"} .= "$n{$t[0]}\n";
		}
		elsif($t[1] == 0 || $t[1] == 2 || $t[1] == 9){
			$fold{"F1"} .= "$n{$t[0]}\n";
		}
		elsif($t[1] == 5 || $t[1] == 8){
			$fold{"F2"} .= "$n{$t[0]}\n";
		}
		elsif($t[1] == 3 || $t[1] == 6){
			$fold{"F3"} .= "$n{$t[0]}\n";
		}
	}
}

my @k = keys %fold;
for (my $i = 0; $i < @k; $i++){
	open(F,">","$folder/metodo4/Test_$k[$i].tsv") or die "can't open Test_$k[$i].tsv\n";
	print F "$h\n$fold{$k[$i]}";
	close F;
	open(F,">","$folder/metodo4/Train_$k[$i].tsv");
	print F "$h\n";
	for (my $j = 0; $j < $i; $j++){
		print F "$fold{$k[$j]}\n";
	}
	for (my $j = $i+1; $j < @k; $j++){
		print F "$fold{$k[$j]}\n";
	}
	close F;
}

#clusters clustered into 4 clusters
#~ Fold0 1+4+7	660
#~ Fold1 0+2+9	667
#~ Fold2 8+5	660
#~ Fold3 3+6	637