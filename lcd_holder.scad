include <configuration.scad>;

width = 9;

panel_height = 73;
printer_height = 45;
screw_separation = (49+56)/2; //center to center distance between mounting screws

angle = asin(printer_height/panel_height);

module lcd_holder(){
	rotate([0,-90,0]){
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
					rotate([0, 0, 45]) translate([0,-width,-thickness/2])
						cube([width*2,width,thickness*2]);
				}
			difference(){
				rotate([0,90,0])
					cylinder(r=thickness, h=width, $fn=48);
				translate([width/2,0,-thickness])
					cube([width*2, thickness*2, thickness*2], center=true);
			}
		}
	}
}

module lcd_holders(num){
	for(i = [0 : num-1]){
		if(i % 2 == 0){
			translate([i*thickness*2, panel_height, 0]) rotate([0, 0, -angle])
				lcd_holder();
		} else {
			mirror([0, 1, 0]) translate([i*thickness*2, 0, 0])  rotate([0, 0, -angle])
				lcd_holder();
		}
	}
}

lcd_holders(2);