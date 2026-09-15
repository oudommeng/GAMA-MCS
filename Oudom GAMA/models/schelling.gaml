/**
* Name: schelling
* Based on the internal skeleton template. 
* Author: oudommeng
* Tags: 
*/

model schelling

global {
	init {
//		create a people 2000
		create people number: 2000 ;
		
		
	}
}

species people {
	aspect default {
		draw circle(1.0) color: #red border: #black;
	}
	
	aspect cricle_people {
		draw triangle(1.0) color: #blue border: #black;
		
	}
	
}


experiment people_run { 
	output {
		display my_people_display type: 2d {
			species people aspect: cricle_people; 
		}
	}
}