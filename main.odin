// Copyright (c) 2025 Isaac Spencer. All Rights Reserved.
package main

import rl "vendor:raylib"

main :: proc() {
	rl.InitWindow(800, 400, "Hello, World")
	for !rl.WindowShouldClose() {

	}
}
