note
	description: "A bad player who loses many solitaire games."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BAD_PLAYER

inherit
	PLAYER

create
	make
------------------------------------------------------------------------------------------------
feature -- Commands
	loses_easy_board
			-- Lose a cross board.
		require
			current_game_is_easy: game.board ~ templates.easy_board

		local
			assertion: BOOLEAN
		do
			assertion := game.out ~ "[
			Game is over: No
			Game is won : No
			Board Status:
			***.***
			***O***
			***O***
			***.***
			***O***
			***.***
			*******
			]"
			print(game.out)
			check assertion end

			game.move_up (3, 4)
			assertion := game.out ~ "[
			Game is over: Yes
			Game is won : No
			Board Status:
			***O***
			***.***
			***.***
			***.***
			***O***
			***.***
			*******
			]"
			check assertion end
		ensure
			finished_and_lost_game:  game.is_over and (not game.is_won)

		end
------------------------------------------------------------------------------------------------
	loses_pyramid_game
		require
			current_game_is_pyramid:  game.board ~ templates.pyramid_board

		local
			assertion: BOOLEAN

		do
			assertion:= game.out ~ "[
				Game is over: No
				Game is won : No
				Board Status:
				**...**
				**.O.**
				..OOO..
				.OOOOO.
				OOOOOOO
				**...**
				**...**
				]"
			game.move_up (3, 4)
			assertion:= game.out ~ "[
				Game is over: No
				Game is won : No
				Board Status:
				**.O.**
				**...**
				..O.O..
				.OOOOO.
				OOOOOOO
				**...**
				**...**
				]"
			check assertion end
			game.move_right (4, 5)
			assertion := game.out ~ "[
			Game is over: No
			Game is won : No
			Board Status:
			**.O.**
			**...**
			..O.O..
			.OOO..O
			OOOOOOO
			**...**
			**...**
			]"
			check assertion end
			game.move_left (4, 3)
			assertion := game.out ~ "[
			Game is over: No
			Game is won : No
			Board Status:
			**.O.**
			**...**
			..O.O..
			O..O..O
			OOOOOOO
			**...**
			**...**
			]"
			check assertion end
			game.move_down (4, 4)
			assertion := game.out ~ "[
			Game is over: No
			Game is won : No
			Board Status:
			**.O.**
			**...**
			..O.O..
			O.....O
			OOO.OOO
			**.O.**
			**...**
			]"
			check assertion end
			game.move_up(5,7)
			assertion := game.out ~ "[
			Game is over: No
			Game is won : No
			Board Status:
			**.O.**
			**...**
			..O.O.O
			O......
			OOO.OO.
			**.O.**
			**...**
			]"
			check assertion end
			game.move_up(5,1)
			assertion := game.out ~ "[
			Game is over: No
			Game is won : No
			Board Status:
			**.O.**
			**...**
			O.O.O.O
			.......
			.OO.OO.
			**.O.**
			**...**
			]"
			check assertion end
			game.move_left(5,3)
			assertion := game.out ~ "[
			Game is over: No
			Game is won : No
			Board Status:
			**.O.**
			**...**
			O.O.O.O
			.......
			O...OO.
			**.O.**
			**...**
			]"
			check assertion end
			game.move_right(5,5)
			assertion := game.out ~ "[
			Game is over: Yes
			Game is won : No
			Board Status:
			**.O.**
			**...**
			O.O.O.O
			.......
			O.....O
			**.O.**
			**...**
			]"
			check assertion end

		ensure
			finished_and_lost_game:  game.is_over and (not game.is_won)

		end
------------------------------------------------------------------------------------------------
	loses_arrow_game
		require
			current_game_is_arrow:  game.board ~ templates.arrow_board

		local
			assertion: BOOLEAN
		do
			assertion := game.out ~ "[
				Game is over: No
				Game is won : No
				Board Status:
				**.O.**
				**OOO**
				.OOOOO.
				...O...
				...O...
				**OOO**
				**OOO**
				]"
			check assertion end
			game.move_right (3,5)
			game.move_left (3, 3)
			game.move_up (7, 5)
			game.move_up (7, 3)
			game.move_right (5, 4)
			game.move_up (7, 4)
			game.move_left(5,4)
			game.move_down(3, 4)
			game.move_down (1, 4)
			assertion := game.out ~ "[
				Game is over: Yes
				Game is won : No
				Board Status:
				**...**
				**O.O**
				O..O..O
				.......
				.O.O.O.
				**...**
				**...**
				]"
			check assertion end

		ensure
			finished_and_lost_game:  game.is_over and not game.is_won
		end
------------------------------------------------------------------------------------------------
	loses_diamond_game
		require
			current_game_is_diamond: game.board ~ templates.diamond_board
				
		local
			assertion: BOOLEAN
		do
			assertion := game.out ~ "[
				Game is over: No
				Game is won : No
				Board Status:
				**.O.**
				**OOO**
				.OOOOO.
				OOO.OOO
				.OOOOO.
				**OOO**
				**.O.**
				]"
			check assertion end

			game.move_left (3, 3)
			assertion := game.out ~ "[
				Game is over: No
				Game is won : No
				Board Status:
				**.O.**
				**OOO**
				O..OOO.
				OOO.OOO
				.OOOOO.
				**OOO**
				**.O.**
				]"
			check assertion end
			game.move_right (3,5)
			assertion := game.out ~ "[
				Game is over: No
				Game is won : No
				Board Status:
				**.O.**
				**OOO**
				O..O..O
				OOO.OOO
				.OOOOO.
				**OOO**
				**.O.**
				]"
			check assertion end
			game.move_left (5,3)
			assertion := game.out ~ "[
				Game is over: No
				Game is won : No
				Board Status:
				**.O.**
				**OOO**
				O..O..O
				OOO.OOO
				O..OOO.
				**OOO**
				**.O.**
				]"
			check assertion end

			game.move_right (5, 5)
			assertion := game.out ~ "[
				Game is over: No
				Game is won : No
				Board Status:
				**.O.**
				**OOO**
				O..O..O
				OOO.OOO
				O..O..O
				**OOO**
				**.O.**
				]"
			check assertion end
			game.move_right (4, 2)
			assertion := game.out ~ "[
				Game is over: No
				Game is won : No
				Board Status:
				**.O.**
				**OOO**
				O..O..O
				O..OOOO
				O..O..O
				**OOO**
				**.O.**
				]"
			check assertion end
			game.move_left (4, 5)
			assertion := game.out ~ "[
				Game is over: No
				Game is won : No
				Board Status:
				**.O.**
				**OOO**
				O..O..O
				O.O..OO
				O..O..O
				**OOO**
				**.O.**
				]"
			check assertion end
			game.move_left (4, 7)
			assertion := game.out ~ "[
				Game is over: No
				Game is won : No
				Board Status:
				**.O.**
				**OOO**
				O..O..O
				O.O.O..
				O..O..O
				**OOO**
				**.O.**
				]"
			check assertion end
			game.move_down (2, 4)
			assertion := game.out ~ "[
				Game is over: No
				Game is won : No
				Board Status:
				**.O.**
				**O.O**
				O.....O
				O.OOO..
				O..O..O
				**OOO**
				**.O.**
				]"
			check assertion end
			game.move_right (4 ,4)
			assertion := game.out ~ "[
				Game is over: No
				Game is won : No
				Board Status:
				**.O.**
				**O.O**
				O.....O
				O.O..O.
				O..O..O
				**OOO**
				**.O.**
				]"
			check assertion end
			game.move_up (6, 4)
			assertion := game.out ~ "[
				Game is over: No
				Game is won : No
				Board Status:
				**.O.**
				**O.O**
				O.....O
				O.OO.O.
				O.....O
				**O.O**
				**.O.**
				]"
			check assertion end
			game.move_left (4, 4)
			assertion := game.out ~ "[
				Game is over: No
				Game is won : No
				Board Status:
				**.O.**
				**O.O**
				O.....O
				OO...O.
				O.....O
				**O.O**
				**.O.**
				]"
			check assertion end
			game.move_right (4, 1)
			assertion := game.out ~ "[
				Game is over: Yes
				Game is won : No
				Board Status:
				**.O.**
				**O.O**
				O.....O
				..O..O.
				O.....O
				**O.O**
				**.O.**
				]"
			check assertion end

		ensure
			finished_and_lost_game:  game.is_over and not game.is_won

		end
------------------------------------------------------------------------------------------------
	loses_skull_game
		require
			current_game_is_skull:  game.board ~ templates.skull_board

		local
			assertion: BOOLEAN
		do
			assertion := game.out ~ "[
			Game is over: No
			Game is won : No
			Board Status:
			**OOO**
			**OOO**
			.OOOOO.
			.O.O.O.
			.OOOOO.
			**OOO**
			**OOO**
			]"
			check assertion end


			game.move_down(2,3)
			game.move_left(2,5)
			game.move_right(3,5)
			game.move_right(4,3)
			game.move_right(4,5)
			game.move_left(5,3)
			game.move_right(5,5)
			game.move_up(6,4)
			game.move_up(7,3)
			game.move_left(7,5)
			game.move_down(1,3)
			game.move_left(1,5)
			game.move_down(3,2)
			game.move_right(3,3)
			game.move_right(5,2)
			game.move_up(5,4)
			game.move_right(3,4)
			game.move_left(3,7)
			game.move_up(5,7)

			assertion := game.out ~ "[
			Game is over: Yes
			Game is won : No
			Board Status:
			**O..**
			**...**
			....O.O
			.......
			O......
			**..O**
			**O..**
			]"
			check assertion end
		ensure
			finished_and_lost_game:  game.is_over and not game.is_won
		end
end
------------------------------------------------------------------------------------------------
