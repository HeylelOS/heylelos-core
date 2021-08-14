-- HeylelOS image builder

--[[ host
	The host is the builder host configuration.
	It contains informations about the machine
	properties, compilers and the toolchain.
--]]

host = {
	cores = 2 * hex.charm('nproc');
	compilers = { C = 'clang'; };
}

--[[ target
	The target is the built system.
	It contains informations about its architecture.
--]]

target = {
	arch = 'x86_64';
	sub = '';
	vendor = 'unknown';
	sys = 'linux';
	abi = 'elf';
}

--[[ misc.
	Additional functions to help
	access and use host/target variables.
--]]

function triple(target)
	return target.arch..target.sub..'-'..target.vendor..'-'..target.sys..'-'..target.abi
end

-- This path would make sense in both host and target
function cmaketoolchain(host, target)
	return 'resources/toolchain.cmake'
end

--[[ rules and configurations
	Build infrastructure configurations.
	Set log level, create crucible,
	support files and wipe/reset directories.
--]]

log.level = 'debug'

crucible = hex.crucible('forge')
crucible.shackle = {
	user = { uid = 0; gid = 0 };
	outputs = fs.path(crucible.molten, 'outputs');
}

dofile 'hexes/materials/initrd.lua'
dofile 'hexes/materials/kernel.lua'

log.info('Performing sequence for target ', triple(target))
hex.perform(crucible, 'configure', 'build', 'install')

