# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{9,10,11} )
inherit linux-info python-any-r1 toolchain-funcs

MY_P=linux-${PV}

S=${WORKDIR}/${MY_P}

DESCRIPTION="Developer documentation generated from the Linux kernel"
HOMEPAGE="https://www.kernel.org/"
SRC_URI="https://www.kernel.org/pub/linux/kernel/v6.x/${MY_P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sparc ~x86"

IUSE="graphviz"

DEPEND=""
RDEPEND="graphviz? ( >=media-gfx/graphviz-5.0.0 )"
BDEPEND="${PYTHON_DEPS}
	>=dev-python/sphinx-7
	dev-python/sphinx-rtd-theme
	media-libs/fontconfig"

src_prepare() {
	default
	# Fix the Python shebangs.
	python_fix_shebang "${S}/Documentation/sphinx/"
}

src_compile() {
	local ARCH="$(tc-arch-kernel)"
	unset KBUILD_OUTPUT
	HTML_DOCS=( Documentation/output/. )
	emake htmldocs
}

src_install() {
	einstalldocs
}
