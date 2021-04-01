#pragma once
#define LEAN_VERSION_MAJOR 4
#define LEAN_VERSION_MINOR 0
#define LEAN_VERSION_PATCH 0
#define LEAN_VERSION_IS_RELEASE 0

// Additional version description like "nightly-2018-03-11"
#define LEAN_SPECIAL_VERSION_DESC ""

// When git_sha1 is not avilable, lean reads bin/version file and
// assign its contents to LEAN_PACKAGE_VERSION
#define LEAN_PACKAGE_VERSION "NOT-FOUND"
