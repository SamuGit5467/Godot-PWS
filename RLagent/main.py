
import random

maze = [
	"S....",
	".D##.",
	".#D..",
	"..#.#",
	"D...G"
]

# maze = [
# 	"S....",
# 	"..##.",
# 	".#...",
# 	"..#.#",
# 	"....G"
# ]

ROWS = len(maze)
COLS = len(maze[0])

for row in range(ROWS):
	for col in range(COLS):
		if maze[row][col] == "S":
			start = (row, col)
		elif maze[row][col] == "G":
			goal = (row, col)

ACTIONS = [
	(-1, 0),
	(0, 1),
	(1, 0),
	(0, -1)
]

ACTION_NAMES = ["UP", "RIGHT", "DOWN", "LEFT"]

q_table = {}

for row in range(ROWS):
	for col in range(COLS):
		if maze[row][col] != "#":
			q_table[(row, col)] = [0.0, 0.0, 0.0, 0.0]

LEARNING_RATE = 0.1
DISCOUNT = 0.95
EPSILON = 1.0
MIN_EPSILON = 0.05
EPISODES = 1000
MAX_STEPS = 100


def take_action(state, action):
	"""Move the agent and return next state, reward, done."""

	row, col = state
	dr, dc = ACTIONS[action]

	new_row = row + dr
	new_col = col + dc

	# Hit a wall or leave the maze
	if (
		new_row < 0 or new_row >= ROWS
		or new_col < 0 or new_col >= COLS
		or maze[new_row][new_col] == "#"
	):
		return state, -5, False

	next_state = (new_row, new_col)

	if maze[new_row][new_col] == "D":
		return next_state, -50, True

	# Reached the goal
	if next_state == goal:
		return next_state, 100, True

	# Ordinary move
	return next_state, -1, False


def choose_action(state, epsilon):
	"""Explore randomly or choose the best-known action."""

	# Exploration
	if random.random() < epsilon:
		return random.randrange(4)

	# Exploitation: use the highest Q-value
	values = q_table[state]
	best_value = max(values)

	# Randomly choose between equally good actions
	best_actions = [
		action for action, value in enumerate(values)
		if value == best_value
	]

	return random.choice(best_actions)


recent_successes = []

for episode in range(1, EPISODES + 1):
	state = start
	steps = 0
	success = False

	for step in range(MAX_STEPS):
		action = choose_action(state, EPSILON)

		next_state, reward, done = take_action(state, action)

		# Q-learning update
		old_value = q_table[state][action]

		if done:
			future_value = 0
		else:
			future_value = max(q_table[next_state])

		new_value = old_value + LEARNING_RATE * (
			reward + DISCOUNT * future_value - old_value
		)

		q_table[state][action] = new_value

		state = next_state
		steps = step + 1

		if done:
			success = reward == 100
			break

	# Gradually reduce random exploration
	EPSILON = max(
		MIN_EPSILON,
		EPSILON * 0.995
	)

	recent_successes.append(1 if success else 0)
	recent_successes = recent_successes[-100:]

	# Training statistics
	if episode % 100 == 0:
		success_rate = sum(recent_successes) / len(recent_successes)

		print(
			f"Episode {episode:4} | "
			f"Success rate: {success_rate:.0%} | "
			f"Epsilon: {EPSILON:.2f}"
		)
