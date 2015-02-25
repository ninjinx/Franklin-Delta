d1 = 22.3;
d2 = 16.0;
d3 = 12.0;
h1 = 1.0;
h2 = 26.0;
s1 = 2.5;

res = 32;

module e3d_heatsink(){
	color("Silver"){union(){
		cylinder(r1 = 6, r2 = 4.5, h = h2+4);
		for(i = [0 : s1 : h2]){
			translate([0,0,i]) cylinder(r = d1/2, h = h1);
		}
		translate([0,0,h2+s1-h1]) cylinder(r = d2/2, h = h1);
		translate([0,0,h2+s1+1.5]) cylinder(r = d2/2, h = 3.0);
		translate([0,0,h2+s1+10.5]) cylinder(r = d2/2, h = 3.7);
		translate([0,0,h2+s1+4.5]) cylinder(r = d3/2, h = 6.0);
	}}
}

module e3d_heatbreak(){
	color("Gray"){
		union(){
			cylinder(r=3, h = 5.0, $fn = res);
			translate([0,0,7.1]) cylinder(r = 3.5, h = 14.8, $fn = res);
			translate([0,0,5.0]) cylinder(r = 1.4, h = 2.1, $fn = res);
		}
	}
}

module heatblock(){
	color("Silver"){
		union(){
			translate([-4.5,-8,0]) cube(size = [17.5, 16, 11.5]);
			translate([7,0,4]) rotate([90,0,0]) cylinder(r = 3.0, h = 18, center = true);
		}
	}
}

module nozzle(){
	color("Gold"){
		union(){
			cylinder(r1 = 0.5, r2 = 2.02, h = 2.02, $fn = res);
			translate([0,0,2.02]) cylinder(r = 4.04, h = 3, $fn = 6);
		}
	}
}

module fan_shroud(){
	color("Blue", 0.8){
		translate([(36.5-(22.3/2))/2,0,15]) cube(size = [36.5-(22.3/2), 30, 30], center = true);
	}
}

module e3d_v6(){
	e3d_heatsink();
	translate([0,0,-7.1]) e3d_heatbreak();
	translate([0,0,-14.2]) heatblock();
	translate([0,0,-19.26]) nozzle();
}

module e3d_v6_with_fan(){
	e3d_v6();
	fan_shroud();
}

e3d_v6();

