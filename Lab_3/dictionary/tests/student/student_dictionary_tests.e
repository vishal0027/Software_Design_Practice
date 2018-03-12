note
	description: "Summary description for {STUDENT_DICTIONARY_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_DICTIONARY_TESTS
inherit
	ES_TEST
create
	make
feature
	make
		do
			add_boolean_case (agent testing_add)
			add_boolean_case (agent test_iterable)
		end
feature -- Setup


	testing_add : BOOLEAN
			-- Initialize 'd' as a 4-entry dictionary.
			-- This feature is executed in the beginning of every test feature.
		local
			d: DICTIONARY[STRING, INTEGER]
		do
			create	d.make
			comment ("test_setup: test the initial dictionary")
			d.add_entry ("A", 1)
			d.add_entry ("B", 2)
			d.add_entry ("C", 3)
			d.add_entry ("D", 4)

			Result :=
						d.count = 4
--						
						and	d.get_value (1) ~ "A"
						and	d.get_value (2) ~ "B"
						and	d.get_value (3) ~ "C"
						and	d.get_value (4) ~ "D"
						and	d.get_value (5) ~ Void
			check result end
		end
	test_iterable : BOOLEAN
		local
			temp : DICTIONARY[STRING, DATE]
			bd : DATE
			bd1: DATE
			do
				create temp.make
				comment("Test_ITerable: test the iterable class")
				 create	bd1.make_now
				  create	bd.make_now

				temp.add_entry ("Vishal", bd1)
				bd.make (1912, 3, 12)
				temp.add_entry ("yash", bd)
				Result :=
				across
					temp as cursor
				some
						cursor.item[2] ~ bd
				end
				check Result end
			end
end
