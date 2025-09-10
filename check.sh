#!/bin/bash
 
AFFECTED_PACKAGES=(
  "ansi-styles@6.2.2"
  "debug@4.4.2"
  "chalk@5.6.1"
  "supports-color@10.2.1"
  "strip-ansi@7.1.1"
  "ansi-regex@6.2.1"
  "wrap-ansi@9.0.1"
  "color-convert@3.1.1"
  "color-name@2.0.1"
  "is-arrayish@0.3.3"
  "slice-ansi@7.1.1"
  "color@5.0.1"
  "color-string@2.1.1"
  "simple-swizzle@0.2.3"
  "supports-hyperlinks@4.1.1"
  "has-ansi@6.0.1"
  "chalk-template@1.1.1"
  "backslash@0.2.1"
  "error-ex@1.3.3"
)

echo "Searching for affected packages in the project..."

echo "-------------------"

found_affected_package=false

# Get the full list of packages from yarn list and process it line by line
for affected_package_with_version in "${AFFECTED_PACKAGES[@]}"; do
  # Loop through the list of known affected packages
  package_name=$(echo "$affected_package_with_version" | cut -d'@' -f1)
  vulnerable_version=$(echo "$affected_package_with_version" | cut -d'@' -f2)

    # Extract the version number using a regular expression
  installed_version=$(yarn list --all 2>/dev/null | grep "$package_name" | grep -oP "$package_name@\K[^ ]*")

  # Check if the line contains the package name and a version number
  if [[ "$installed_version" == "$vulnerable_version" ]]; then

    echo "Found affected package: $package_name at version $installed_version"

    found_affected_package=true
  fi
done

echo "-------------------"

if [ "$found_affected_package" = false ]; then
  echo "No affected packages were found in this project."
else
  echo "Please review the packages listed above and take the necessary actions."
fi
