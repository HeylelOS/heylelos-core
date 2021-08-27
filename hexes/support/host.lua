--[[ host
	The host is the builder host configuration.
	It contains informations about the machine
	properties, compilers and the toolchain.
--]]

return {
	cores = 2 * hex.charm('nproc');
	compilers = { C = 'clang'; };
}

