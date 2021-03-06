# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PLOCALES="ca cs de en es fr hu it nb nl pl pt ru sv"
inherit cmake-utils l10n

DESCRIPTION="Application to create and manage beer recipes"
HOMEPAGE="http://brewtarget.org/"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3 WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="kde"

DEPEND="
	>=dev-qt/qtcore-4.6:4
	>=dev-qt/qtgui-4.6:4
	>=dev-qt/qtsql-4.6:4
	>=dev-qt/qtsvg-4.6:4
	>=dev-qt/qtwebkit-4.6:4
	kde? ( media-libs/phonon )
	!kde? ( || ( >=dev-qt/qtphonon-4.6:4 media-libs/phonon ) )
"
RDEPEND="${DEPEND}"

remove_locale() {
	sed -i -e "/bt_$1.ts/d" CMakeLists.txt || die
}

src_prepare() {
	# Fix desktop file
	sed -i -e '/^Encoding/d' ${PN}.desktop.in || die

	# Check for new locales, respect LINGUAS
	l10n_find_plocales_changes "${S}/translations" "bt_" '.ts'
	l10n_for_each_disabled_locale_do remove_locale

	cmake-utils_src_prepare
}
