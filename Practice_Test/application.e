note
	description: "practice_Test application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			--| Add your code here
			add_boolean_case(agent testSingleton)
			add_boolean_case(agent testArray)
			add_boolean_case(agent testArray_insert_at)
			show_browser
			run_espec
		end
feature
	testSingleton : BOOLEAN
		local
			one, two : A
			data_A : A_ACCESS
		do
			one := data_A.temp
			two := data_A.temp
			Result := one = two
			check
				Result
			end
			one.change_i (12)
			Result := one.i = two.i and two.i =12
			check Result end
		end

	testArray : BOOLEAN
		local
			temp : ARRAY_TEST
		do
			create temp.make
			temp.insert_last ("Vishal")
			temp.insert_last ("Hello")
			temp.insert_last ("Mark")
		--	Result := temp.get_at (1) ~ "Vishal" and temp.get_at (2) ~ "Hello" and temp.get_at (3) ~ "Mark"
		--	check Result end
			temp.delete_at (2)
			Result := temp.get_at (1) ~ "Vishal" and temp.get_at (2) ~ "Mark"
			check Result end
		end
	testArray_insert_at : BOOLEAN
		local
				temp : ARRAY_TEST
			do
				create temp.make
				temp.insert_last ("Vishal")
				temp.insert_last ("Hello")
				temp.insert_last ("Mark")
				Result := temp.get_at (1) ~ "Vishal" and temp.get_at (2) ~ "Hello" and temp.get_at (3) ~ "Mark"
				check Result end
				temp.insert_at (2, "1012")
				Result := temp.get_at (1) ~ "Vishal" and temp.get_at (2) ~ "1012" and temp.get_at (3) ~ "Hello" and temp.get_at (4) ~ "Mark"
				check Result end
				temp.assign_at (2, "make")
				Result := temp.get_at (1) ~ "Vishal" and temp.get_at (2) ~ "make" and temp.get_at (3) ~ "Hello" and temp.get_at (4) ~ "Mark"
				check Result end
			end
end
