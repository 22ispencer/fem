package main

import "core:encoding/json"
import "core:fmt"
import "core:os"

Vec3 :: [3]f64

CurveType :: enum {}

Geometry :: struct {
	nodes: []Vec3,
}

load_geometry_from_slice :: proc(slice: []byte) -> (geo: ^Geometry, ok: bool) {
	geo = new(Geometry)
	unmarshall_err := json.unmarshal(slice, geo)
	if unmarshall_err != nil {
		free(geo)
		fmt.eprintfln("Error while unmarshalling json: %v", unmarshall_err)
		return
	}
	return geo, true
}

load_geometry_from_filename :: proc(filename: string) -> (geo: ^Geometry, ok: bool) {
	data, ok1 := os.read_entire_file_from_filename("./tests/1.json")
	if !ok1 {
		fmt.eprintln("Failed to load test 1")
		return
	}
	defer delete(data)
	return load_geometry_from_slice(data)
}
load_geometry_from_handle :: proc(handle: os.Handle) -> (geo: ^Geometry, ok: bool) {
	data, ok1 := os.read_entire_file_from_handle(handle)
	if !ok1 {
		fmt.eprintln("Failed to load test 1")
		return
	}
	defer delete(data)
	return load_geometry_from_slice(data)
}

load_geometry :: proc {
	load_geometry_from_slice,
	load_geometry_from_filename,
}

delete_geometry :: proc(ptr: ^Geometry) {
	delete(ptr.nodes)
	free(ptr)
}
