// Copyright (c) 2025 Isaac Spencer. All Rights Reserved.
package main

import rl "vendor:raylib"

main :: proc() {
	rl.InitWindow(800, 400, "Hello, World")
	points: [3]rl.Vector3 = {{0, 0, 0}, {1, 0, 0}, {1, 1, 0}}
	members: [3][2]int = {{0, 1}, {1, 2}, {0, 2}}

	camera := rl.Camera3D {
		position   = {1, 0.5, 1},
		target     = {0, 0, 0},
		up         = {0, 1, 0},
		fovy       = 10,
		projection = .ORTHOGRAPHIC,
	}

	rl.DisableCursor()
	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() {
		rl.UpdateCameraPro(&camera, {}, {}, {})

		rl.BeginDrawing()

		rl.ClearBackground(rl.WHITE)

		rl.BeginMode3D(camera)
		for member in members {
			p1 := points[member[0]]
			p2 := points[member[1]]
			rl.DrawLine3D(p1, p2, rl.BLACK)
		}
		rl.EndMode3D()

		rl.DrawText("Hello, World", 20, 20, 10, rl.BLACK)

		rl.EndDrawing()
	}
	rl.CloseWindow()
}
