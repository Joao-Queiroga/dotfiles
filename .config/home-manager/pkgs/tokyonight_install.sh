set -Eeo pipefail

REPO_DIR="${src}/theme"
cp $REPO_DIR -r newRepo
REPO_DIR="${PWD}/newRepo"
chmod 777 -R $REPO_DIR
SRC_DIR="${REPO_DIR}/src"

source "${REPO_DIR}/gtkrc.sh"

DEST_DIR="${PWD}/themes"

ctype=

SASSC_OPT="-M -t expanded"

THEME_NAME=Tokyonight
THEME_VARIANTS=('' '-Purple' '-Pink' '-Red' '-Orange' '-Yellow' '-Green' '-Teal' '-Grey')
COLOR_VARIANTS=('-Light' '-Dark' )
SIZE_VARIANTS=('' '-Compact')

install() {
	local dest="${1}"
	local name="${2}"
	local theme="${3}"
	local color="${4}"
	local size="${5}"
	local ctype="${6}"

	[[ "${color}" == '-Light' ]] && local ELSE_LIGHT="${color}"
	[[ "${color}" == '-Dark' ]] && local ELSE_DARK="${color}"

	local THEME_DIR="${1}/${2}${3}${4}${5}${6}"

	[[ -d "${THEME_DIR}" ]] && rm -rf "${THEME_DIR}"

	echo "Installing '${THEME_DIR}'..."

	mkdir -p "${THEME_DIR}"

	# Index Theme File
	echo "Type=X-GNOME-Metatheme" >>                            						 "${THEME_DIR}/index.theme"
	echo "[Desktop Entry]" >>                                   						 "${THEME_DIR}/index.theme"
	echo "Name=${2}${3}${4}${5}${6}" >>                         						 "${THEME_DIR}/index.theme"
	echo "Comment=An Flat Gtk+ theme based on Elegant Design" >>						 "${THEME_DIR}/index.theme"
	echo "Encoding=UTF-8" >>                                    						 "${THEME_DIR}/index.theme"
	echo "" >>                                                  						 "${THEME_DIR}/index.theme"
	echo "[X-GNOME-Metatheme]" >>                               						 "${THEME_DIR}/index.theme"
	echo "GtkTheme=${2}${3}${4}${5}${6}" >>                     						 "${THEME_DIR}/index.theme"
	echo "MetacityTheme=${2}${3}${4}${5}${6}" >>                						 "${THEME_DIR}/index.theme"
	echo "IconTheme=Tela-circle${ELSE_DARK:-}" >>               						 "${THEME_DIR}/index.theme"
	echo "CursorTheme=${2}-cursors" >>                          						 "${THEME_DIR}/index.theme"
	echo "ButtonLayout=close,minimize,maximize:menu" >>         						 "${THEME_DIR}/index.theme"

	# Gnome Shell Themes
	mkdir -p                                                                			 "${THEME_DIR}/gnome-shell"
	cp -r "${SRC_DIR}/main/gnome-shell/pad-osd.css"                         			 "${THEME_DIR}/gnome-shell"
	sassc $SASSC_OPT "${SRC_DIR}/main/gnome-shell/gnome-shell${color}.scss" 			 "${THEME_DIR}/gnome-shell/gnome-shell.css"

	cp -r "${SRC_DIR}/assets/gnome-shell/common-assets"               					 "${THEME_DIR}/gnome-shell/assets"
	cp -r "${SRC_DIR}/assets/gnome-shell/assets${ELSE_DARK:-}/"*.svg  					 "${THEME_DIR}/gnome-shell/assets"
	cp -r "${SRC_DIR}/assets/gnome-shell/theme${theme}${ctype}/"*.svg 					 "${THEME_DIR}/gnome-shell/assets"

	cd "${THEME_DIR}/gnome-shell"
	ln -s assets/no-events.svg no-events.svg
	ln -s assets/process-working.svg process-working.svg
	ln -s assets/no-notifications.svg no-notifications.svg
  cd -


	# GTK2 Themes
	mkdir -p                                                                      		 "${THEME_DIR}/gtk-2.0"
	# cp -r "${SRC_DIR}/main/gtk-2.0/gtkrc${theme}${ELSE_DARK:-}${ctype}" 				       "${THEME_DIR}/gtk-2.0/gtkrc"
	cp -r "${SRC_DIR}/main/gtk-2.0/common/"*'.rc'                                 		 "${THEME_DIR}/gtk-2.0"
	cp -r "${SRC_DIR}/assets/gtk-2.0/assets-common${ELSE_DARK:-}"                 		 "${THEME_DIR}/gtk-2.0/assets"
	cp -r "${SRC_DIR}/assets/gtk-2.0/assets${theme}${ELSE_DARK:-}${ctype}/"*"png" 		 "${THEME_DIR}/gtk-2.0/assets"

	# GTK3 Themes
	mkdir -p                                                                             "${THEME_DIR}/gtk-3.0"
  cp -r "${SRC_DIR}/assets/gtk/assets${theme}${ctype}"                                 "${THEME_DIR}/gtk-3.0/assets"
	cp -r "${SRC_DIR}/assets/gtk/scalable"                                               "${THEME_DIR}/gtk-3.0/assets"
	cp -r "${SRC_DIR}/assets/gtk/thumbnails/thumbnail${theme}${ctype}${ELSE_DARK:-}.png" "${THEME_DIR}/gtk-3.0/thumbnail.png"
	sassc $SASSC_OPT "${SRC_DIR}/main/gtk-3.0/gtk${color}.scss"                          "${THEME_DIR}/gtk-3.0/gtk.css"
	sassc $SASSC_OPT "${SRC_DIR}/main/gtk-3.0/gtk-Dark.scss"                             "${THEME_DIR}/gtk-3.0/gtk-dark.css"


	# GTK4 Themes
	mkdir -p                                                                             "${THEME_DIR}/gtk-4.0"
	cp -r "${SRC_DIR}/assets/gtk/scalable"                                               "${THEME_DIR}/gtk-4.0/assets"
	cp -r "${SRC_DIR}/assets/gtk/thumbnails/thumbnail${theme}${ctype}${ELSE_DARK:-}.png" "${THEME_DIR}/gtk-4.0/thumbnail.png"
	sassc $SASSC_OPT "${SRC_DIR}/main/gtk-4.0/gtk${color}.scss"                          "${THEME_DIR}/gtk-4.0/gtk.css"
	sassc $SASSC_OPT "${SRC_DIR}/main/gtk-4.0/gtk-Dark.scss"                             "${THEME_DIR}/gtk-4.0/gtk-dark.css"


	# Cinnamon Themes
	mkdir -p                                                                             "${THEME_DIR}/cinnamon"
	cp -r "${SRC_DIR}/assets/cinnamon/common-assets"                                     "${THEME_DIR}/cinnamon/assets"
	cp -r "${SRC_DIR}/assets/cinnamon/assets${ELSE_DARK:-}/"*'.svg'                      "${THEME_DIR}/cinnamon/assets"
	cp -r "${SRC_DIR}/assets/cinnamon/theme${theme}${ctype}/"*'.svg'                     "${THEME_DIR}/cinnamon/assets"
	sassc $SASSC_OPT "${SRC_DIR}/main/cinnamon/cinnamon${color}.scss"                    "${THEME_DIR}/cinnamon/cinnamon.css"
	cp -r "${SRC_DIR}/assets/cinnamon/thumbnails/thumbnail${theme}${ctype}${color}.png"  "${THEME_DIR}/cinnamon/thumbnail.png"

	# Metacity Themes
	mkdir -p                                                         					 "${THEME_DIR}/metacity-1"
	cp -r "${SRC_DIR}/main/metacity-1/metacity-theme-3.xml"          					 "${THEME_DIR}/metacity-1/metacity-theme-3.xml"
	cp -r "${SRC_DIR}/assets/metacity-1/assets"                      					 "${THEME_DIR}/metacity-1/assets"
	cp -r "${SRC_DIR}/assets/metacity-1/thumbnail${ELSE_DARK:-}.png" 					 "${THEME_DIR}/metacity-1/thumbnail.png"
	cd "${THEME_DIR}/metacity-1" && ln -s metacity-theme-3.xml metacity-theme-1.xml && ln -s metacity-theme-3.xml metacity-theme-2.xml
  cd -

	# XFWM4 Themes
	mkdir -p                                                                             "${THEME_DIR}/xfwm4"
	cp -r "${SRC_DIR}/assets/xfwm4/assets${ELSE_LIGHT:-}${ctype}${window}/"*.png         "${THEME_DIR}/xfwm4"
	cp -r "${SRC_DIR}/main/xfwm4/themerc${ELSE_LIGHT:-}"                                 "${THEME_DIR}/xfwm4/themerc"
	mkdir -p                                                                             "${THEME_DIR}-hdpi/xfwm4"
	cp -r "${SRC_DIR}/assets/xfwm4/assets${ELSE_LIGHT:-}${ctype}${window}-hdpi/"*.png    "${THEME_DIR}-hdpi/xfwm4"
	cp -r "${SRC_DIR}/main/xfwm4/themerc${ELSE_LIGHT:-}"                                 "${THEME_DIR}-hdpi/xfwm4/themerc"
	sed -i "s/button_offset=6/button_offset=9/"                                          "${THEME_DIR}-hdpi/xfwm4/themerc"
	mkdir -p                                                                             "${THEME_DIR}-xhdpi/xfwm4"
	cp -r "${SRC_DIR}/assets/xfwm4/assets${ELSE_LIGHT:-}${ctype}${window}-xhdpi/"*.png   "${THEME_DIR}-xhdpi/xfwm4"
	cp -r "${SRC_DIR}/main/xfwm4/themerc${ELSE_LIGHT:-}"                                 "${THEME_DIR}-xhdpi/xfwm4/themerc"
	sed -i "s/button_offset=6/button_offset=12/"                                         "${THEME_DIR}-xhdpi/xfwm4/themerc"

	# Plank Themes
	mkdir -p                                                							 "${THEME_DIR}/plank"
	if [[ "$color" == '-Light' ]]; then
		cp -r "${SRC_DIR}/main/plank/theme-Light${ctype}/"* 							 "${THEME_DIR}/plank"
	else
		cp -r "${SRC_DIR}/main/plank/theme-Dark${ctype}/"*  							 "${THEME_DIR}/plank"
	fi
}

themes=()
colors=()
sizes=()
lcolors=()

if [[ "${#themes[@]}" -eq 0 ]]; then
	themes=("${THEME_VARIANTS[0]}")
fi

if [[ "${#colors[@]}" -eq 0 ]]; then
	colors=("${COLOR_VARIANTS[@]}")
fi

if [[ "${#sizes[@]}" -eq 0 ]]; then
	sizes=("${SIZE_VARIANTS[0]}")
fi

create_temp() {
	mv "${SRC_DIR}/sass/_tweaks.scss" "${SRC_DIR}/sass/_tweaks-temp.scss"
	mv "${SRC_DIR}/sass/gnome-shell/_common.scss" "${SRC_DIR}/sass/gnome-shell/_common-temp.scss"
}

install_theme() {
	for theme in "${themes[@]}"; do
		for color in "${colors[@]}"; do
			for size in "${sizes[@]}"; do
				install "$DEST_DIR" "$THEME_NAME" "$theme" "$color" "$size" "$ctype"
			done
		done
	done
}

create_temp

install_theme

echo
echo Done.
