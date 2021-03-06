#
# Bareflank Hypervisor
# Copyright (C) 2018 Assured Information Security, Inc.
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

message(STATUS "Including dependency: capstone")

download_dependency(
    capstone
    URL         ${CAPSTONE_URL}
    URL_MD5     ${CAPSTONE_URL_MD5}
)

list(APPEND CAPSTONE_CONFIGURE_FLAGS
    -DCAPSTONE_BUILD_CSTOOL=OFF
    -DCAPSTONE_BUILD_DIET=ON
    -DCAPSTONE_BUILD_SHARED=ON
    -DCAPSTONE_BUILD_STATIC=ON
    -DCAPSTONE_BUILD_TESTS=OFF
    -DCAPSTONE_USE_DEFAULT_ALLOC=ON
    -DCAPSTONE_X86_ATT_DISABLE=ON
    -DCAPSTONE_X86_REDUCE=ON
    -DCAPSTONE_X86_SUPPORT=ON

    -DCAPSTONE_ARM64_SUPPORT=OFF
    -DCAPSTONE_ARM_SUPPORT=OFF
    -DCAPSTONE_MIPS_SUPPORT=OFF
    -DCAPSTONE_OSXKERNEL_SUPPORT=OFF
    -DCAPSTONE_PPC_SUPPORT=OFF
    -DCAPSTONE_SPARC_SUPPORT=OFF
    -DCAPSTONE_SYSZ_SUPPORT=OFF
    -DCAPSTONE_XCORE_SUPPORT=OFF
)

if(ENABLE_BUILD_VMM)
    generate_flags(vmm NOWARNINGS)

    list(APPEND CAPSTONE_CONFIGURE_FLAGS
        -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_TOOLCHAIN_FILE=${VMM_TOOLCHAIN_PATH}
        -DCMAKE_C_COMPILER_WORKS=1
        -DCMAKE_CXX_COMPILER_WORKS=1
    )

    add_dependency(
        capstone vmm
        CMAKE_ARGS ${CAPSTONE_CONFIGURE_FLAGS}
        DEPENDS newlib_${VMM_PREFIX}
    )
endif()

if(ENABLE_BUILD_TEST)
    generate_flags(test NOWARNINGS)

    list(APPEND CAPSTONE_CONFIGURE_FLAGS
        -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_TOOLCHAIN_FILE=${TEST_TOOLCHAIN_PATH}
        -DCMAKE_C_COMPILER_WORKS=1
        -DCMAKE_CXX_COMPILER_WORKS=1
    )

    add_dependency(
        capstone test
        CMAKE_ARGS ${CAPSTONE_CONFIGURE_FLAGS}
    )
endif()
