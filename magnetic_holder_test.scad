magnet_h = 2.7;
magnet_dia = 10;

angle = 15;


difference(){
	union(){
		hull(){
			for(a = [0,120,240]){
				rotate([0,0,a]) translate([0,8,-8]) cylinder(d = 8.5, h = 8, $fn = 48);
			}
		}
		//translate([0,0,-8]) cylinder(d = 24, h = 8);
	}
	translate([0,0,-magnet_h+0.7]) cylinder(d = magnet_dia, h = magnet_h+.01, $fn=64);
	for(a = [0,120,240]){
		rotate([0,0,a]) translate([0,7.5,0]) rotate([angle, 0, 0]) 
			translate([0,0,-6.55]) cylinder(d = 3.95, h = 8.5, $fn = 48);

	}
}


//Visualization stuff
/*translate([0,0,-magnet_h+0.6]) magnet();

for(a = [0,120,240]){
		rotate([0,0,a]) translate([0,7.5,0]) rotate([angle, 0, 0]) screw();
}*/

//Modules
module magnet(){
	color("silver") translate() difference(){
		cylinder(d = magnet_dia-0.05, h = magnet_h, $fn=64);
		cylinder(d = 3, h = 7, $fn=24, center = true);
		translate([0,0,magnet_h-1.79]) cylinder(d1 = 3, d2 = 6.55, h = 1.81, $fn=24);
	}
}

module screw(){
	color("DimGray"){
		cylinder(d2 = 5.9, d1=2.8, h = 1.77, $fn = 48);
		translate([0,0,-4]) cylinder(d=2.8, h = 4.0, $fn = 48);
	}
}