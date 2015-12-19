include <configuration.scad>;
use <frame_motor.scad>;
use <extrusion.scad>;

for(i = [0:120:359]){
	rotate([90,0,i]) translate([90,7.5,-120]) extrusion(240);
	rotate([90,0,i]) translate([90,50,-120]) extrusion(240);
	rotate([90,0,i]) translate([90,600-7.5,-120]) extrusion(240);
	rotate([0,0,i+60]) translate([160,0,0]) extrusion(600);
}