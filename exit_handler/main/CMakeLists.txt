cmake_minimum_required(VERSION 3.6)
project(libvmi_extensions C CXX)

include(${SOURCE_CMAKE_DIR}/project.cmake)
#init_project()

init_project(
	INCLUDES ${PROJECT_SOURCE_DIR}/../include
	INCLUDES ${CMAKE_CURRENT_LIST_DIR}/../../../bfsdk/include
)

list(APPEND ARGN
	 arch/intel_x64/vcpu_factory.cpp
)

add_vmm_executable(
		libvmi_extensions	
    SOURCES vmcall_handler.cpp
)
