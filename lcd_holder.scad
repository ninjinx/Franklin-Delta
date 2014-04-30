include <configuration.scad>;

width = 15;

panel_height = 73;
printer_height = 45;
screw_separation = (49+56)/2; //center to center distance between mounting screws

angle = asin(printer_height/panel_height);

module lcd_holder(){
	union(){
		difference(){
			cube([width,extrusion,thickness]);
			translate([width/2,extrusion/2,thickness/2])
				cylinder(r=m3_wide_radius, h=2*thickness, center=true, $fn=16);
		}
		rotate([angle, 0, 0]) translate([0,-panel_height,0])
			difference(){
				cube([width, panel_height, thickness]);
				translate([width/2,(panel_height-screw_separation)/2,thickness/2])
					cylinder(r=m3_wide_radius, h=2*thickness, center=true, $fn=16);
				translate([width/2,panel_height-(panel_height-screw_separation)/2,thickness/2])
					cylinder(r=m3_wide_radius, h=2*thickness, center=true, $fn=16);
			}
		difference(){
			rotate([0,90,0])
				cylinder(r=thickness, h=15, $fn=48);
			translate([7.5,0,-thickness])
				cube([30, 20, thickness*2], center=true);
		}
	}
}

lcd_holder();