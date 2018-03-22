//
// Bareflank Extended APIs
// Copyright (C) 2018 Assured Information Security, Inc.
//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

#include <vcpu/arch/intel_x64/vcpu.h>

namespace eapis
{
namespace intel_x64
{

vcpu::vcpu(vcpuid::type id) :
    bfvmm::intel_x64::vcpu{id},
    m_hve{std::make_unique<eapis::intel_x64::hve>(exit_handler(), vmcs())}
{ }

gsl::not_null<hve *>
vcpu::hve()
{ return m_hve.get(); }

}
}