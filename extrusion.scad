include <configuration.scad>;

module extrusion_cutsection(){
	import("openbeam.dxf", convexity = 8);
}


module extrusion(h, center){
	linear_extrude(height = h, center = center){
		extrusion_cutsection();
	}
}

extrusion(300);