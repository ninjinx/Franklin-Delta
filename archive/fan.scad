$fn = 16;

module fan(size){
	difference(){
		cube([size, size, 10], center=true);
		translate([(size/2)-4, (size/2)-4, 0]) cylinder(r=1.65, h=15, center=true);
		translate([-(size/2)+4, (size/2)-4, 0]) cylinder(r=1.65, h=15, center=true);
		translate([-(size/2)+4, -(size/2)+4, 0]) cylinder(r=1.65, h=15, center=true);
		translate([(size/2)-4, -(size/2)+4, 0]) cylinder(r=1.65, h=15, center=true);
		cylinder(r=(size/2)-1, h=15, center=true);
	}
}