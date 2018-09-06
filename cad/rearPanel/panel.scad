$fn=24;

// Configuration
powerHoleType = 1; // 0 = slot , 1 = 5.5mm barrel jack

panelSize=[23,83,4];

caseHoles=[[17,43],[52,83]];
caseHoleWidth=13.5;
switchSize=[10.2,18,50];
switchHoleDia=2.6;
switchHoleSpace=23.8;

powerDia = 8;

bottomSupportThickness=1.8;
bottomSupportPos=[panelSize[0]/2+caseHoleWidth/2,caseHoles[0][0]-5,panelSize[2]];

topSupportDepth=12;
topSupportSize=9;



module panel()
{
	botpos=(caseHoles[0][1]-caseHoles[0][0])/2+caseHoles[0][0];
	toppos=(caseHoles[1][1]-caseHoles[1][0])/2+caseHoles[1][0];
	difference() {
		union() {
			cube(panelSize);
			bottomSupport();
			topSupport();
		}

		if(powerHoleType) {
			translate([
				panelSize[0]/2,
				toppos,
				0
			])
			switchHole();
			translate([
				panelSize[0]/2,
				botpos,
				0
			])
			powerHole();
		} else {
			translate([
				panelSize[0]/2,
				botpos,
				0
			])
			switchHole();
			powerSlot();
		}
	}

}

module topSupport()
{	
	difference()
	{
	translate([0,panelSize[1]-topSupportSize,0])
	cube([panelSize[0],topSupportSize,topSupportDepth]);
	
	translate([-1,panelSize[1]-topSupportSize*0.35,topSupportDepth])
	rotate([-45,0,0])
	cube([panelSize[0]+2,topSupportSize,topSupportDepth]);
	}
}

module bottomSupport()
{

	translate(bottomSupportPos)
	cube([bottomSupportThickness,panelSize[1]-bottomSupportPos[1]-topSupportSize,10]);
};

module switchHole()
{
	cube(switchSize,true);

	for(side = [-1:2:1]) {
		translate([
			0,
			switchHoleSpace/2*side,
			-panelSize[2]
		])
		cylinder(r=switchHoleDia/2,panelSize[2]*3);
	}
}

module powerSlot()
{
	translate([
		panelSize[0]/2-caseHoleWidth/2,
		caseHoles[1][0],
		-topSupportDepth
	])

	cube([caseHoleWidth,panelSize[1]*2,topSupportDepth*3]);
}

module powerHole()
{
	translate([
		0,
		0,
		-panelSize[2]
	])

	cylinder(r=powerDia/2,h=panelSize[2]*3);
}

panel();
