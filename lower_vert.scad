include <configuration.scad>;

tower_dist = corner_distance-outer_radius;

module lower_vert(){
	difference(){
		linear_extrude(height = 15, convexity = 6) lower_vert_base();
		translate([0,0,7.5]) extrusion_cutout(16, 0.8);

		//Remove 1 tap
		translate([-7.5-.4,-4,-.5]) cube([7.5+0.4,8,16]);

		//Lock screw hole
		translate([0,0,7.5]) rotate([0,90,0]) cylinder(d = 3.5, h = tower_dist+1, $fn = 12);
		translate([0,0,7.5]) rotate([0,45,0]) cube([13,5,13], center = true);
		translate([tower_dist-7.5+3,0,7.5]) rotate([0,90,0]) cylinder(d = 6, h = 8, $fn = 16);

		//Mounting holes
		rotate([0,-90,120]) translate([7.5,28,11.5]) 
			cylinder(d = 3.5, h = 6, center = true, $fn = 12);
		rotate([0,-90,120]) translate([7.5,28,9]) 
			cylinder(d1 = 7, d2 = 6, h = 4, center = true, $fn = 12);

		rotate([0,-90,120]) translate([7.5,58,11.5]) 
			cylinder(d = 3.5, h = 6, center = true, $fn = 12);
		rotate([0,-90,120]) translate([7.5,58,9]) 
			cylinder(d1 = 7, d2 = 6, h = 4, center = true, $fn = 12);

		rotate([0,-90,-120]) translate([7.5,-28,11.5]) 
			cylinder(d = 3.5, h = 6, center = true, $fn = 12);
		rotate([0,-90,-120]) translate([7.5,-28,9]) 
			cylinder(d1 = 7, d2 = 6, h = 4, center = true, $fn = 12);
		rotate([0,-90,-120]) translate([7.5,-58,11.5]) 
			cylinder(d = 3.5, h = 6, center = true, $fn = 12);
		rotate([0,-90,-120]) translate([7.5,-58,9]) 
			cylinder(d1 = 7, d2 = 6, h = 4, center = true, $fn = 12);

		//Plate mounting holes
		translate([tower_dist+1,corner_length/2-8,7.5]) 
			rotate([0,-90,0]) cylinder(d = 4, h = 6.5, $fn = 16);
		translate([tower_dist+1,corner_length/2-8,7.5]) rotate([0,-90,0]) 
			cylinder(d1 = 6, d2 = 4, h = 2, $fn = 16);

		translate([tower_dist+1,-corner_length/2+8,7.5]) 
			rotate([0,-90,0]) cylinder(d = 4, h = 6.5, $fn = 16);
		translate([tower_dist+1,-corner_length/2+8,7.5]) rotate([0,-90,0]) 
			cylinder(d1 = 6, d2 = 4, h = 2, $fn = 16);

		rotate([0,-90,120]) translate([7.5,10,23]) 
			cylinder(d = 4, h = 6.5, $fn = 16);
		rotate([0,-90,120]) translate([7.5,10,28]) 
			cylinder(d1 = 4, d2 = 6, h = 2, $fn = 16);

		rotate([0,-90,-120]) translate([7.5,-10,23]) 
			cylinder(d = 4, h = 6.5, $fn = 16);
		rotate([0,-90,-120]) translate([7.5,-10,28]) 
			cylinder(d1 = 4, d2 = 6, h = 2, $fn = 16);
	}
}

module extrusion_cutout(h, extra) {
  difference() {
    cube([15+extra, 15+extra, h], center=true);
    for (a = [0:90:359]) rotate([0, 0, a]) {
      translate([15/2, 0, 0])
        cube([6, 2.5, h+1], center=true);
    }
  }
}

module lower_vert_base(){
	translate([-outer_radius,0]) difference(){
		union(){
			translate([outer_radius-30,0]) square([4, 65], center = true);
			translate([outer_radius,-(corner_length-cos(30)*6)/2]) 
				square([corner_distance-outer_radius,corner_length-cos(30)*6]); 
			translate([2*outer_radius-corner_distance,-(corner_length-cos(30)*6)/2]) 
				square([corner_distance-outer_radius,corner_length-cos(30)*6]); 
			rotate(-30) translate([120-45,inner_radius-5]) 
				square([(side_length-240)/2+46, 20]);
			mirror([0,1,0]) rotate(-30) translate([120-45,inner_radius-5]) 
				square([(side_length-240)/2+46, 20]);
		}
		rotate(-30) translate([0,inner_radius]) square([120, 15.1]);
		mirror([0,1,0]) rotate(-30) translate([0,inner_radius]) square([120, 15.1]);
	}
}

module lower_vert_ears(){
	union(){
		lower_vert();
		//Mickey-mouse ears
		translate([-50,42,0]) cylinder(d = 12, h = 0.4);
		translate([-50,-42,0]) cylinder(d = 12, h = 0.4);
	}
}

lower_vert_ears();