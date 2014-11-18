include <configuration.scad>;

bearing_distance = 70;
bearing_major_dia = 13;
bearing_minor_dia = 4;
bearing_thickness = 6;
thickness = 3;
spacing = 53.5;

module roller(){
	difference(){
		union(){
			cube([bearing_thickness * 2, bearing_distance+bearing_major_dia, thickness], center=true);
			translate([-bearing_thickness, (bearing_distance-bearing_major_dia)/2, 0]) 
				bearing_holder();
			translate([-bearing_thickness, (-bearing_major_dia-bearing_distance)/2, 0]) 
				bearing_holder();

/*
			#translate([0, bearing_distance/2, 2+(thickness+bearing_major_dia)/2])
			rotate([0,90,0]) 
				cylinder(r=bearing_major_dia/2, h=bearing_thickness, center=true);
			#translate([0, -bearing_distance/2, 2+(thickness+bearing_major_dia)/2])
			rotate([0,90,0]) 
				cylinder(r=bearing_major_dia/2, h=bearing_thickness, center=true);*/
		}
	translate([0,0,-2]) cylinder(r=m3_nut_radius, h=2.5, $fn=6);
	cylinder(r=m3_wide_radius, h=thickness*3, $fn=48, center=true);
	}
}

module bearing_holder(){
	difference(){
		cube([bearing_thickness * 2, bearing_major_dia, bearing_major_dia+1]); 
		translate([(bearing_thickness-2)/2, -1, 1]) 
			cube([bearing_thickness+2, bearing_major_dia+6, bearing_major_dia+3]); 
		translate([bearing_thickness, 0, bearing_major_dia+3])
			rotate([45, 0, 0])
				cube([2+bearing_thickness*2, 8, 8], center=true);
		translate([bearing_thickness, bearing_major_dia, bearing_major_dia+3])
			rotate([45, 0, 0])
				cube([2+bearing_thickness*2, 8, 8], center=true);
		translate([bearing_thickness, bearing_major_dia/2, 2+(thickness+bearing_major_dia)/2]) 
			rotate([0, 90, 0]) cylinder(r=bearing_minor_dia/2, h=2+bearing_thickness*2, center=true, $fn=48);
	}
}

module spacer(){
	difference(){
		cube([spacing+(bearing_thickness*2), bearing_thickness*2, thickness*2], center=true);
		translate([spacing/2+0.5, 0, thickness])
			cube([1+bearing_thickness*2, 1+bearing_thickness*2, thickness*2], center=true);
		translate([-spacing/2-0.5, 0, thickness])
			cube([1+bearing_thickness*2, 1+bearing_thickness*2, thickness*2], center=true);
	   translate([spacing/2, 0, 0]) cylinder(r=m3_wide_radius, h=thickness*3, center=true, $fn=32);
		translate([-spacing/2, 0, 0]) cylinder(r=m3_wide_radius, h=thickness*3, center=true, $fn=32);
	}
}

module axle(){
	cylinder(r=bearing_minor_dia/2, h=bearing_thickness*2, $fn=48);
}

spacer();