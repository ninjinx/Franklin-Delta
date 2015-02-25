include <configuration.scad>;

fsr_radius = 9.8;
fsr_recess = 1.5;
fsr_connector_width = 8.5;

module fsr_cutout(){
	translate([0,fsr_radius,0]) cylinder(r=fsr_radius, h=10);
	translate([-fsr_connector_width/2,fsr_radius,0]) cube([fsr_connector_width,100,10]);	
	translate([-fsr_connector_width/2,fsr_radius+12,0]) rotate([-8,0,0]) cube([fsr_connector_width,100,10]);	
}

module fsr_holder(width, length, height){
	difference(){
		union(){
			cube([width,length,height], center = true);
			translate([0,-(length/2)+0.2,(height/2)-2.2]) rotate([0,90,0])
				cylinder(r = 1.0, h = width, $fn = 16, center = true);
			translate([0,-(length/2)+0.2,-(height/2)+2.2]) rotate([0,90,0]) 
				cylinder(r = 1.0, h = width, $fn = 16, center = true);
			difference(){
				translate([-width/2,(-length/2)+0.5,0]) rotate([0,90,0])
					cylinder(r = 1.2, h = width, $fn = 16);
				rotate([90,0,0]) cylinder(r = 3.5, h = length*2, center = true);
			}
		}
		translate([0,(-length/2)+2,(height/2)-fsr_recess]) fsr_cutout();
		translate([6+width/2,length/2,0]) cylinder(r = 12, h = height+2, center = true, $fn = 64);
		translate([-6-width/2,length/2,0]) cylinder(r = 12, h = height+2, center = true, $fn = 64);
		translate([0,3,0]) rotate([90,0,0]) cylinder(r = 3.2, h = length, center = true, $fn = 16);
		translate([0,3,-(height/4+0.5)]) cube([6.4,length,1+height/2], center = true);
		rotate([90,0,0]) cylinder(r = m3_wide_radius, h = length*2, center = true, $fn = 16);
	}
}

fsr_holder(25, 30, extrusion);