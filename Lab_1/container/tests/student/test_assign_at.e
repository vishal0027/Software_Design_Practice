note
	description: "Summary description for {TEST_ASSIGN_AT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_ASSIGN_AT

inherit
	ES_TEST
create
	make

feature --- Testing Assign_At method in Array_container

	make			--- Testing
	do
		add_boolean_case(agent test_assign_at)
		add_boolean_case(agent test_insert_at)
		add_boolean_case(agent test_Remove_first)
		add_boolean_case(agent test_Delete_at)
	end

feature -- Test_by Failure
	test_assign_at: BOOLEAN
		local
			ac : ARRAYED_CONTAINER
		 do
			comment ("Test assign at position") create ac.make
			 ac.insert_last ("alan")
			 ac.insert_last ("mark")
			 ac.insert_last ("tom")
			Result := ac.get_at (1) ~ "alan"  and ac.get_at (2) ~ "mark"and ac.get_at (3) ~ "tom"
	   		check Result end
	   	 	ac.assign_at (2, "jim")
	   	 	Result := ac.get_at (1) ~ "alan" and ac.get_at (2) ~ "jim" and ac.get_at (3) ~ "tom"
		end

	test_insert_at:BOOLEAN
		local
			ac1: ARRAYED_CONTAINER
			do
				comment("TEST Insert at possition")
				create ac1.make
				ac1.insert_last ("alan")
			 	ac1.insert_last ("mark")
			 	ac1.insert_last ("tom")
			 	ac1.insert_last ("full")
			 	ac1.insert_last ("herry")
			 	ac1.insert_last ("pol")
				Result := ac1.get_at (1) ~ "alan"  and ac1.get_at(2) ~ "mark"and ac1.get_at (3) ~ "tom"
	   			check Result end
	   			ac1.insert_at (3, "vishal")
	   			Result := ac1.get_at (1) ~ "alan"  and ac1.get_at(2) ~ "mark" and ac1.get_at (3) ~ "vishal" -- and ac1.get_at (4) ~ "tom" and ac1.get_at (5) ~ "full"
	   			check Result end
			end

	test_Remove_first:BOOLEAN
		local
			ac2: ARRAYED_CONTAINER
			do
				comment("TEST Remove_First")
				create ac2.make
				ac2.insert_last ("alan")
			 	ac2.insert_last ("mark")
			 	ac2.insert_last ("tom")
			 	ac2.insert_last ("full")
			 	ac2.insert_last ("herry")
			 	ac2.insert_last ("pol")
				Result := ac2.get_at (1) ~ "alan"  and ac2.get_at(2) ~ "mark"and ac2.get_at (3) ~ "tom"
	   			check Result end
	   			ac2.remove_first
	   			Result := ac2.get_at (1) ~ "mark" -- and ac2.get_at(2) ~ "tom"
	   			check Result end
			end
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
