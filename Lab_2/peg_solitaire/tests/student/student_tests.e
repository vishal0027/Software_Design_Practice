note
	description: "Summary description for {PRACTICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TESTS

inherit
	ES_TEST

create
	make

feature -- Constructor
	make
		do
			add_boolean_case (agent test_make_default)
			add_boolean_case (agent test_is_equal_slot_access)
			add_boolean_case (agent test_number_of_occupied)
			add_boolean_case (agent test_set_status)
			add_boolean_case (agent test_set_statuses)
			add_boolean_case (agent test_matched_slots_except3)
			add_boolean_case (agent test_cross)
			add_boolean_case (agent test_plus)
			add_boolean_case (agent test_pyramid)
			add_boolean_case (agent test_arrow)
			add_boolean_case (agent test_diamond)
			add_boolean_case (agent test_skull)
			add_boolean_case (agent test_bad_player_loses_pyramid_board)
			add_boolean_case (agent test_bad_player_loses_arrow_board)
			add_boolean_case (agent test_bad_player_loses_diamond_board)
			add_boolean_case (agent test_good_player_wins_cross_board)
			add_boolean_case (agent test_good_player_wins_plus_board)
			add_violation_case_with_tag ("valid_rows", agent test_by_matches_voilation)
			add_violation_case_with_tag ("valid_rows", agent test_by_matches_voilation)
			add_violation_case_with_tag ("valid_rows", agent test_by_matches_voilation)
		end

feature -- Tests
	test_make_default: BOOLEAN
		local
			b: BOARD
		do
			comment("Testing make_default")
			create b.make_default
			result := true
			check result end
		end

	test_is_equal_slot_access: BOOLEAN
		local
			slot_access: SLOT_STATUS_ACCESS
			slot1, slot2, slot3: SLOT_STATUS
		do
			comment("Checks if the is_equal for slot status works:")
			slot1 := slot_access.occupied_slot
			slot2 := slot_access.occupied_slot
			slot3 := slot_access.unavailable_slot
			result := slot1.is_equal (slot2)
			check result end
		end

	test_number_of_occupied: BOOLEAN
		local
			b: BOARD
			num: INTEGER
		do
			comment("Tests if the easy baord has 3 occupied slots:")
			create b.make_easy
			num := b.number_of_occupied_slots
			result := num = 3
		end

	test_set_status: BOOLEAN
		local
			b: BOARD
			sa: SLOT_STATUS_ACCESS
		do
			comment("Testing slot status by modifying one location in a default board:")
			create b.make_default
			b.set_status (2, 4, sa.occupied_slot)
			result := b.status_of (2, 4) ~ sa.occupied_slot
		end

	test_set_statuses: BOOLEAN
		local
			b: BOARD
			sa: SLOT_STATUS_ACCESS
		do
			comment("Testing a certain rectangle portion with set_statuses:")
			create b.make_default
			b.set_statuses (2, 5, 3, 5, sa.occupied_slot)
			result := b.out ~ "[
				*******
				**OOO**
				**OOO**
				**OOO**
				**OOO**
				*******
				*******
				]"
		end

	test_matched_slots_except3: BOOLEAN
		local
			b1: BOARD
			b2: BOARD
			sa: SLOT_STATUS_ACCESS
		do
			comment("Checks matched_slots_except from 1 through 7:")
			create b1.make_default
			create b2.make_default
			b2.set_statuses (2, 5, 3, 5, sa.unoccupied_slot)
			result := b2.matches_slots_except (b1, 1, 7, 1, 7)
		end

	test_cross: BOOLEAN
		local
			b: BOARD
		do
			comment("Checks make cross:")
			create b.make_cross
			result := b.out ~ "[
				**...**
				**.O.**
				..OOO..
				...O...
				...O...
				**...**
				**...**
				]"
		end

	test_plus: BOOLEAN
		local
			b: BOARD
		do
			comment("Checks make plus:")
			create b.make_plus
			result := b.out ~ "[
				**...**
				**.O.**
				...O...
				.OOOOO.
				...O...
				**.O.**
				**...**
				]"
		end

	test_pyramid: BOOLEAN
		local
			b: BOARD
		do
			comment("Check make pyramid:")
			create b.make_pyramid
			result := b.out ~ "[
				**...**
				**.O.**
				..OOO..
				.OOOOO.
				OOOOOOO
				**...**
				**...**
				]"
		end

	test_arrow: BOOLEAN
		local
			b: BOARD
		do
			comment("Check make arrow:")
			create b.make_arrow
			result := b.out ~ "[
				**.O.**
				**OOO**
				.OOOOO.
				...O...
				...O...
				**OOO**
				**OOO**
				]"
		end

	test_diamond: BOOLEAN
		local
			b: BOARD
		do
			comment("Check make diamond:")
			create b.make_diamond
			result := b.out ~ "[
				**.O.**
				**OOO**
				.OOOOO.
				OOO.OOO
				.OOOOO.
				**OOO**
				**.O.**
				]"
		end

	test_skull: BOOLEAN
		local
			b: BOARD
		do
			comment("Check make skull:")
			create b.make_skull
			result := b.out ~ "[
				**OOO**
				**OOO**
				.OOOOO.
				.O.O.O.
				.OOOOO.
				**OOO**
				**OOO**
				]"
		end

		test_bad_player_loses_pyramid_board: BOOLEAN
			local
				player: BAD_PLAYER
			do
				comment ("test: bad player loses an pyramid board")
				create player.make

				player.game.make_pyramid
				player.loses_pyramid_game
				Result :=
						player.game.is_over and not player.game.is_won
				print(player.game.out)
				check Result end
			end
			test_bad_player_loses_arrow_board: BOOLEAN
			local
				player: BAD_PLAYER
			do
				comment ("test: bad player loses an arrow board")
				create player.make

				player.game.make_arrow
				player.loses_arrow_game
				Result :=
						player.game.is_over and not player.game.is_won
				print(player.game.out)
				check Result end
			end
			test_bad_player_loses_diamond_board: BOOLEAN
					local
						player: BAD_PLAYER
					do
						comment ("test: bad player loses an diamond board")
						create player.make

						player.game.make_diamond
						player.loses_diamond_game
						Result :=
								player.game.is_over and not player.game.is_won
						print(player.game.out)
						check Result end
					end
			test_bad_player_loses_skull_board: BOOLEAN
							local
								player: BAD_PLAYER
							do
								comment ("test: bad player loses an diamond board")
								create player.make

								player.game.make_skull
								player.loses_skull_game
								Result :=
										player.game.is_over and not player.game.is_won
								print(player.game.out)
								check Result end
							end
			test_good_player_wins_cross_board: BOOLEAN
				local
					player: GOOD_PLAYER
				do
					comment ("test: good player wins an easy board")
					create player.make

					player.game.make_cross
					player.wins_cross_board
					Result :=
							player.game.is_over	and player.game.is_won
					check Result end
				end
			test_good_player_wins_plus_board: BOOLEAN
				local
					player: GOOD_PLAYER
				do
					comment ("test: good player wins an easy board")
					create player.make

					player.game.make_plus
					player.wins_plus_board
					Result :=
							player.game.is_over	and player.game.is_won
					check Result end
				end
		test_by_matches_voilation
		local
			b1: BOARD
			b2: BOARD
			sa: SLOT_STATUS_ACCESS
		do
			comment("Checks matched_slots_except from 1 through 7:")
			create b1.make_default
			create b2.make_default
			b2.set_statuses (-2, 5, 3, 5, sa.unoccupied_slot)
			end
end
