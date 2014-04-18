// More Fontz! by polymaker http://www.thingiverse.com/thing:13677
include <Orbitron_Medium.scad>;

// steps - the amount of detail, the higher the more detailed.
// center - whether the output is centered or not
// extra - extra distance between characters
// height - height of extrusion, 0 for 2d
module logotype(){
	Orbitron_Medium("FRANKLIN", steps=3, center=true, extra=8, height=5);
}

logotype();