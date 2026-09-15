/**
* Name: p01
* Based on the internal empty template. 
* Author: oudommengbycha
* Tags: 
*/


model p01

/* Insert your model definition here */

global {
	float rate_similar_wanted <- 0.4;
	float neighbours_distance <- 5.0;
	int init_number_of_People <- 2000 min: 10;
	int total_happy_people <- 0 update: people count (each.is_happy);
//	ini total_number_ppl_black <- 0 update: people count 
	init {
//		init_number_of_People <- 0;
		create people number: init_number_of_People;
	}
}

species people{
	rgb my_color <- #red;
	bool is_happy <- true;
	float rate_similar;

	init {
//		if (flip(0.5)) {
//			my_color <- #blue;
//		}
		my_color <- flip(0.5) ? #yellow : #red;
	}

	aspect default {
		draw circle(1.0) color: my_color border: #black;
	}
	list<people> neighborhood update: people at_distance neighbours_distance;
//	reflex updateNeighbors {
//		neighborhood <- people at_distance neighbours_distance; 
//	}
	
	
	reflex computing_similarity  {
		if (empty(neighborhood)){
			rate_similar <- 1.0;
		} else {
			int total_neightbors <- length(neighborhood);
			int same_color_neightbors <- neighborhood count (each.my_color = my_color);
			rate_similar <- same_color_neightbors / total_neightbors ;
		}
		is_happy <- rate_similar >= rate_similar_wanted;
		
}

	reflex walk_around when: not is_happy {
		location <- any_location_in(world.shape);
	}

}

experiment run_people{
	output{ 
		monitor "Total Happy" value: total_happy_people;
		display myPeopleDisplay type: 2d { 
			species people;
		}
	}
	
}
