note
	description: "practice_test_2 application root class"
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
			add_boolean_case(agent test_insert_last)
			add_boolean_case(agent test_shift_right)
			add_boolean_case(agent test_remove)
			add_boolean_case(agent test_remove_first)
			show_browser
			run_espec
		end
feature
	test_insert_last : BOOLEAN
		local
			a : CONTAIN
		do
			create a.make
			a.insert_last ("vishal")
			a.insert_last ("kamal")
			a.insert_last ("dine")
			a.insert_last ("raj")
			Result := a.get_at (1) ~ "vishal" and a.get_at (2) ~ "kamal" and a.get_at (3) ~ "dine" and a.get_at (4) ~ "raj"
			check Result end
		end
	test_shift_right : BOOLEAN
		local
			b : CONTAIN
		do
			create b.make
			b.insert_last ("vishal")
			b.insert_last ("kamal")
			b.insert_last ("dine")
			b.insert_last ("raj")
			Result := b.get_at (1) ~ "vishal" and b.get_at (2) ~ "kamal" and b.get_at (3) ~ "dine" and b.get_at (4) ~ "raj"
			b.shift_to_right
			Result := b.get_at (1) ~ "kamal" and b.get_at (2) ~ "dine" and b.get_at (3) ~ "raj" and b.get_at (4) ~ "vishal"
			check Result end
		end
	test_remove : BOOLEAN
		local
			c : CONTAIN
		do
			create c.make
			c.insert_last ("vishal")
			c.insert_last ("kamal")
			c.insert_last ("dine")
			c.insert_last ("raj")
			Result := c.get_at (1) ~ "vishal" and c.get_at (2) ~ "kamal" and c.get_at (3) ~ "dine" and c.get_at (4) ~ "raj"
			check Result end
			c.remove (4)
			Result := c.get_at (1) ~ "vishal" and c.get_at (2) ~ "kamal" and c.get_at (3) ~ "dine"
			check Result end
		end
	test_remove_first : BOOLEAN
		local
			d : CONTAIN
		do
			create d.make
			d.insert_last ("vishal")
			d.insert_last ("kamal")
			d.insert_last ("dine")
			d.insert_last ("raj")
			Result := d.get_at (1) ~ "vishal" and d.get_at (2) ~ "kamal" and d.get_at (3) ~ "dine" and d.get_at (4) ~ "raj"
			check Result end
			d.remove_first
			Result := d.get_at (1) ~ "kamal" and d.get_at (2) ~ "dine" and d.get_at (3) ~ "raj"
			check Result end
		end

end
