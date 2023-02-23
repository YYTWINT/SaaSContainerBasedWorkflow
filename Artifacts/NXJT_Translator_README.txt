NXJT Translator - v2206 Pre-Release version
May 23, 2022
==========================================

SECTION 1 - Release Information

SECTION 2 - Platforms and OS Supported

SECTION 3 - Installation Instructions and Usage

SECTION 4 - Licensing

SECTION 5 - Support

-------------------------------------------------------------------------

SECTION 1 - Release Information
 
NX to JT translator produces JT files for input part or assembly files.The translator is invoked
through Linux console.User can provide single part that may be a piece part or assembly for translator 
and get one JT file as an output.

JT file for parts contain precise geometry,tessellation,user defined attributes,
Mass properties,Model views, PMIs etc. JT file for assembly contains assembly structure, assembly level geometry,
PMI,Model Views, part transformations etc.

When an assembly is supplied for translation, translator expects the assembly should be able to resolve 
references to subassemblies and components in order to produce correct JT output in assembly context. 
If an assembly is supplied to translator without any subassemblies or parts, 
some functionalities won't work as expected unless entire chain upto to dependent component with sub assembly is completely resolved.

	- Color/translucency override applied on bodies in components in an assembly/subassembly context.	
	- Associativity of assembly/subassembly level PMI with geometry in components.
	- Model view specific component/object visibility defined at assembly/subassembly level.
	- Sub assembly level geometry.

Following capabilities are currently not supported in the translator due to limitation of data model used by Lifecyle Service (LCS). 
Existing data model used by LCS needs to be enhanced in order to support these capabilities.

	- Promotions, deformable parts, assembly cuts defined at assembly/subassembly level.
	- Components/object visibility defined in an assembly/subassembly using global visibility controls like show/hide.
	- Component visibility in assembly defined using reference sets.
		- JT assembly output is always displayed with 'Entire Part' reference sets of the components.

-------------------------------------------------------------------------

SECTION 2 - Platforms and OS Supported

LINUX:

	- CentOS Linux release 7.6.1810 (Core)

-------------------------------------------------------------------------

SECTION 3 - Installation Instructions and Usage

	- Following Linux packages are prerequisites to run translator binaries -
			fontconfig 
			ksh
			  
	- Set following environment variables -
			UGII_BASE_DIR=.../app                  ---> This is base directory containing translator binaries.
			SPLM_LICENSE_SERVER=<License server>   ---> This is as per "Licensing" section below.
		
	- Sample docker file 
			FROM centos:7
			RUN yum update --assumeyes --skip-broken && yum install --assumeyes fontconfig ksh && yum clean all
			WORKDIR /app
			COPY nxbin/     /app/nxbin
			COPY pvtrans/   /app/pvtrans
			COPY ugii/      /app/ugii
			COPY rule/      /app/rule
			COPY mbd/       /app/mbd
			COPY stage_model/   /app/stage_model
			COPY diagramming/   /app/diagramming
			COPY xlatorworker/  /app/xlatorworker
			COPY vdv/           /app/vdv

			COPY run_ugtopv_vis         /app/run_ugtopv_vis
			COPY tessUG_vis.config      /app/tessUG_vis.config
			COPY run_ugtopv_multicad         /app/run_ugtopv_multicad
			COPY tessUG_multicad.config      /app/tessUG_multicad.config

			ENV UGII_BASE_DIR=/app
			ENV SPLM_LICENSE_SERVER=28000@<License server>
			
	- 3.1 Translator for visualization workflows
 			This translator usage is for applications which use JT files in visualization workflows. E.g. Xcelerator Share.
 			 "run_ugtopv_vis" is the parent script and should be the entry point. It should be used as,
						e.g. run_ugtopv_vis  <xxx.prt>
 			 In this case, JT files will be generated at the location where input part is located.

	- 3.2 Translator for multicad workflows
 			 This translator usage is for applications which use JT files for visualization and multicad workflows. E.g. ISIM.
 			 "run_ugtopv_multicad" is the parent script and should be the entry point. It should be used as,
						e.g. run_ugtopv_multicad  <xxx.prt>
 			 In this case, JT files will be generated at the location where input part is located.
 
	- If user wants to output JT files at specified location, provide an argrument as,
      e.g. run_ugtopv_xxx -force_output_dir=<output folder location>
		
	- By default Log files will be created at location specified by UGII_TMP_DIR variable.
	  If it is not set, Log files will be generated at /var/tmp
	
-------------------------------------------------------------------------

SECTION 4 - Licensing
 
	- Please download the latest license server and development license file compatible with NX2206
	  from https://license/lws/#licenses:main
	
	- You need to provide host ID of a license server to get a license file.
	
	- After license server and license file is configured, please specify SPLM_LICENSE_SERVER
	  variable in run_ugtopv translator launch script as 
			SPLM_LICENSE_SERVER=28000@<license server>
	  
-------------------------------------------------------------------------

SECTION 5 - Support
 
	- Please contact Open Tools Translator Products development if you have any queries or issues
	  about translator configuration and usage.

-------------------------------------------------------------------------