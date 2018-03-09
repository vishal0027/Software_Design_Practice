note
	description: "Summary description for {TEST_DELETE_AT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_DELETE_AT

inherit
	ES_TEST
create
	make

feature --- Testing Assign_At method in Array_container

	make			--- Testing
	do
		add_boolean_case(agent test_Delete_at)
	end

feature -- Test_by Failure
	test_Delete_at:BOOLEAN
		local
			ac3: ARRAYED_CONTAINER
			do
				comment("TEST Delete_at")
				create ac3.make
				ac3.insert_last ("alan")
			 	ac3.insert_last ("mark")
			 	ac3.insert_last ("tom")
			 	ac3.insert_last ("full")
			 	ac3.insert_last ("herry")
			 	ac3.insert_last ("pol")
				Result := ac3.get_at (1) ~ "alan"  and ac3.get_at(2) ~ "mark"and ac3.get_at (3) ~ "tom"
	   			check Result end
	   			ac3.delete_at(5)
	   			Result := ac3.get_at (1) ~ "alan"  and ac3.get_at(2) ~ "mark" and ac3.get_at (3) ~ "tom" and ac3.get_at (4) ~ "full" and ac3.get_at (5) ~ "pol"
	   			check Result end
			end



end
