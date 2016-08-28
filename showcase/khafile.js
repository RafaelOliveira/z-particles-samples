let project = new Project('showcase');
project.addAssets('Assets/**');
project.addSources('Sources');
project.addLibrary('z-particles');
project.windowOptions.width = 800;
project.windowOptions.height = 600;
resolve(project);