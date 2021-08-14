-- initrfs, HeylelOS' minimal iniramfs

--[[
	initrfs shouldn't really install anything.
	It's purpose is to create the kernel-embedded
	initrd.img's init binary, therefore, it comes
	as a kernel dependency.
--]]

local material = hex.melt(crucible, 'materials/initrd')

material.setup = {
	configure = { options = { '--toolchain', fs.path('../../..', cmaketoolchain(host, target)) } };
	build = { options = { '--parallel', host.cores } };
}

material.override = {
	install = function(name, material)
		fs.chdir(material.build)
		hex.cast('strip', '-s', 'init')
	end;
}
