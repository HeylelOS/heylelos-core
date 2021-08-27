--[[ target
	The target is the built system.
	It contains informations about its architecture.
--]]

function triple(target)
	return target.arch..target.sub..'-'..target.vendor..'-'..target.sys..'-'..target.abi
end

return {
	arch = 'x86_64';
	sub = '';
	vendor = 'unknown';
	sys = 'linux';
	abi = 'elf';
}

